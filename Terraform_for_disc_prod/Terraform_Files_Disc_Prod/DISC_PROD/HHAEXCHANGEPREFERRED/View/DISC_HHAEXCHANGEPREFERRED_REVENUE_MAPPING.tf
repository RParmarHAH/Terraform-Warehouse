resource "snowflake_view" "DISC_HHAEXCHANGEPREFERRED_REVENUE_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "REVENUE_MAPPING"
	statement = <<-SQL
	 ( 
WITH VISITS_DATA AS
(
	SELECT * FROM HHAEXCHANGEPREFERRED.VISITS
	QUALIFY ROW_NUMBER() OVER (PARTITION BY VISITID ORDER BY LASTMODIFIEDDATE DESC) = 1
), REVENUE_MAPPING AS 
(
	SELECT V.VISITID 
		   , SC.CONTRACTID 
		   , SC.SERVICECODEID 
	       , CASE WHEN SC.CONTRACTNAME  LIKE '%Private%' OR V.PAYERID IN (584,2838,20109)
	                 THEN 'PP'
	             WHEN SC.DISCIPLINE = 'PA' AND OFC.OFFICECODE = 'PHN'
	                THEN 'CDPAP'
	             WHEN SC.DISCIPLINE IN ('HHA','PCA','HSK','RESP') AND OFC.OFFICECODE IN('PHN', 'ARI') AND (SC.CONTRACTNAME NOT LIKE '%Private%' OR V.PAYERID NOT IN (584,2838,20109))
	                 THEN 'LHCSA'
	             WHEN OFC.OFFICECODE = 'MAN'
	                 THEN 'MANORS'
	             WHEN OFC.OFFICECODE = 'PSV'
	                 THEN 'BOE'
	             WHEN SC.DISCIPLINE IN ('RN', 'LPN', 'PT', 'OT', 'ST', 'MSW', 'NT', 'RT', 'Other (Skilled)', 'SCM', 'SCI', 'NINS')
	                 THEN 'SKILLED'
	             ELSE 'UNKNOWN'
	            END REVENUE_SUBCATEGORY_CODE
			, CASE 	WHEN REVENUE_SUBCATEGORY_CODE = 'CDPAP' THEN 'CONSUMER DIRECT PERSONAL ASSISTANCE PROGRAM'
				    WHEN REVENUE_SUBCATEGORY_CODE = 'LHCSA' THEN 'LICENSED HOME CARE AGENCY SERVICE'
				    WHEN REVENUE_SUBCATEGORY_CODE = 'MANORS' THEN 'MANORS'
				    WHEN REVENUE_SUBCATEGORY_CODE = 'BOE' THEN 'BOARD OF EDUCATION'
				    WHEN REVENUE_SUBCATEGORY_CODE = 'PP' THEN 'PRIVATE PAY'
				    WHEN REVENUE_SUBCATEGORY_CODE = 'SKILLED' THEN 'SKILLED'
			    ELSE 'UNKNOWN'
			END REVENUE_SUBCATEGORY_NAME
			, CASE  WHEN REVENUE_SUBCATEGORY_CODE IN ('CDPAP', 'LHCSA', 'PP') THEN 'HC'
			    	WHEN REVENUE_SUBCATEGORY_CODE = 'MANORS' THEN 'OTHER'
			    	WHEN REVENUE_SUBCATEGORY_CODE = 'BOE' THEN 'OTHER'
			    	WHEN REVENUE_SUBCATEGORY_CODE = 'SKILLED' THEN 'HH'
		      ELSE 'UNKNOWN'
			  END REVENUE_CATEGORY
	FROM VISITS_DATA V
	INNER JOIN HHAEXCHANGEPREFERRED.VISITINFO_REPL VISITS
		ON VISITS.VISITID = V.VISITID
	LEFT JOIN HHAEXCHANGEPREFERRED.OFFICE_OFFICES_REPL OFC
	    ON OFC.OFFICEID = V.OFFICEID
	LEFT JOIN HHAEXCHANGEPREFERRED.SERVICECODES SC 
		ON VISITS.PRIMARYSERVICECODEID = SC.SERVICECODEID
			AND  VISITS.AGENCYID = SC.AGENCYID
	GROUP BY 1, 2, 3, 4
)
SELECT 	VISITID,
	CONTRACTID,
    SERVICECODEID,
	REVENUE_SUBCATEGORY_CODE,
	REVENUE_SUBCATEGORY_NAME,
	REVENUE_CATEGORY
FROM REVENUE_MAPPING
);
SQL
	or_replace = true 
	is_secure = false 
}

