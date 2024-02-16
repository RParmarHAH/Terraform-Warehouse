resource "snowflake_procedure" "DW_HAH_GET_STAGE_EDISON_DIM_CONTRACT" {
	name ="GET_STAGE_EDISON_DIM_CONTRACT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

                BEGIN
  --*****************************************************************************************************************************
-- NAME:  EDISONDB_DIM_CONTRACT
--
-- PURPOSE: Creates one row per CONTRACT according to EDISONDB
--
-- DEVELOPMENT LOG:
-- DATE        	AUTHOR                	NOTES:
-- --------    	-------------------   	-----------------------------------------------------------------------------------------------
-- 04/20/2022  	Poonit Mistry        	Initial development
-- 06/08/2022  	Mohit Vaghadiya			Added Bill Unit Type (Rate Type)
-- 08/09/2022   Mirisha Jarecha         Revised revenue category, subcategory logic
-- 08/12/2022	Mohit Vaghadiya			Hardcoded state to NY  
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.EDISON_DIM_CONTRACT
WITH CTE AS (
        SELECT
            distinct(s.CONTRACTID) AS CONTRACTID,
            s.SERVICECODEID AS SERVICECODEID,
            CR.CONTRACTRATEID,
            IFF(
                UPPER(VI.INCLUDEMILEAGEEXPENSE :: BOOLEAN) IS NULL,
                UPPER(FALSE :: BOOLEAN),
                UPPER(VI.INCLUDEMILEAGEEXPENSE :: BOOLEAN)
            ) AS MILEAGE_FLAG,
            CASE
                WHEN UPPER(S.SERVICECODE) LIKE ''%BILLABLE%'' THEN ''FALSE''
                WHEN UPPER(NONBILLABLE) = ''FALSE'' THEN UPPER(''TRUE'' :: BOOLEAN)
                WHEN UPPER(NONBILLABLE) = ''TRUE'' THEN UPPER(''FALSE'' :: BOOLEAN)
                ELSE UPPER(NONBILLABLE :: BOOLEAN)
            END AS BILLABLE_FLAG,
            IFF(
                SC.CATEGORY = ''Home Health''
                OR S.SERVICECODE LIKE ''%HHA%'',
                ''HH'',
                ''HC''
            ) AS R_CATEGORY,
            DECODE(R_CATEGORY, ''HC'', ''HC'', ''HH'', ''HHA'', ''NA'') AS REVENUE_SUBCATEGORY_CODE,
            DECODE(
                R_CATEGORY,
                ''HC'',
                ''HOME CARE'',
                ''HH'',
                ''HOME HEALTH AIDE'',
                ''NA''
            ) AS REVENUE_SUBCATEGORY_NAME
        FROM
            DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VisitInfo_REPL VI
            JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICETYPE_REPL ST ON ST.SERVICETYPEID = VI.SERVICETYPEID
            AND ST.AGENCYID = VI.AGENCYID
            JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECATEGORY_REPL SC ON SC.SERVICECATEGORYID = VI.SERVICECATEGORYID
            and st.SERVICECATEGORYID
            LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES S ON S.SERVICECODEID = VI.PRIMARYSERVICECODEID
            AND S.AGENCYID = VI.AGENCYID
            LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CONTRACTS C ON S.CONTRACTID = C.CONTRACTID
            AND C.AGENCYID = VI.AGENCYID
            JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CONTRACTRATES CR ON CR.CONTRACTID = C.CONTRACTID
            AND CR.AGENCYID = C.AGENCYID
            AND CR.SERVICECODEID = S.SERVICECODEID
            AND CR.TODATE :: DATE > GETDATE()
            AND CR.FROMDATE :: DATE <= GETDATE()
            LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.TBLVISITS_REPL TV ON TV.VISITID = VI.VISITID
            AND TV.AGENCYID = VI.AGENCYID
            LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VISITCONTRACTS_REPL VC ON VC.VISITID = TV.VISITID
            AND TV.AGENCYID = VC.AGENCYID
            LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PATIENTCONTRACTS_REPL PC ON PC.PATIENTCONTRACTID = VC.CONTRACTID
            AND PC.AGENCYID = VI.AGENCYID
        WHERE
            VI.AGENCYID = 155)
, EDISON_REVENUE_SEG AS 
(
	SELECT CONTRACTID, REVENUE_CATEGORY, REVENUE_SUBCATEGORY_NAME, REVENUE_SUBCATEGORY_CODE 
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VW_EDISON_REVENUE_SEG
	GROUP BY CONTRACTID, REVENUE_CATEGORY, REVENUE_SUBCATEGORY_NAME, REVENUE_SUBCATEGORY_CODE
)
SELECT
 MD5(SC.AGENCYID || ''-'' || SC.CONTRACTID || ''-'' || NVL(CR.CONTRACTRATEID, -1) || ''-'' || NVL(SC.SERVICECODEID, -1) || ''-'' || 
NVL(RS.REVENUE_SUBCATEGORY_CODE, ''UNKNOWN'') ||''EDISON'') AS CONTRACT_KEY,
    SC.CONTRACTID AS CONTRACT_CODE,
    ''EDISON'' AS SYSTEM_CODE,
    17 AS SOURCE_SYSTEM_ID,
    (SC.CONTRACTNAME) AS CONTRACT_NAME,
    SC.SERVICECODEID :: STRING AS SERVICE_CODE_ID,
    MD5(
        ''EDISON'' || ''-'' || SC.AGENCYID || nvl(SC.SERVICECODEID, -1) || ''-'' || ''EDISON''
    ) AS SERVICE_KEY,
    NULL AS DEFAULT_BILL_CODE, 
       NULL AS PAYROLL_CODE,
   NVL(RS.REVENUE_CATEGORY, ''UNKNOWN'') AS REVENUE_CATEGORY
		, NVL(RS.REVENUE_SUBCATEGORY_CODE, ''UNKNOWN'') AS REVENUE_SUBCATEGORY_CODE
		, NVL(RS.REVENUE_SUBCATEGORY_NAME, ''UNKNOWN'') AS REVENUE_SUBCATEGORY_NAME,
    NULL AS PAYOR_CODE, 
    SC.SERVICECODE AS PAYOR_DESCRIPTION,
    REVENUE_CATEGORY AS SERVICE_LINE_CODE, 
    SC.SERVICECODE AS SERVICE_LINE_DESCRIPTION,
    ''NY'' AS CONTRACT_STATE_CODE,
    CASE
        WHEN CR.UNITS = 1 THEN ''1HR''
        WHEN CR.UNITS = 2 THEN ''.5HR''
        WHEN CR.UNITS = 4 THEN ''.25HR''
        ELSE NULL
    END AS TIME_TRANSLATION_CODE,
    CR.UNITS :: NUMERIC AS TIME_TRANSLATION_DIVIDER,
    NULL AS PAY_TRAVELS_CODE,
    MILEAGE_FLAG AS MILEAGE_FLAG, 
    NULL AS PAYABLE_FLAG,
    IFF(UPPER(PAYOR_DESCRIPTION) LIKE ''%BILLABLE%'', 0, 1) AS BILLABLE_FLAG, 
    IFF(TIME_TRANSLATION_CODE = ''.25HR'', 1, 0) AS BILLED_BY_QUARTER_HOURS,
    IFF(TIME_TRANSLATION_CODE = ''.5HR'', 1, 0) AS BILLED_BY_HALF_HOURS, 
    SC.RATETYPETEXT AS BILL_UNIT_TYPE,
    TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
                        
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 as ETL_INFERRED_MEMBER_FLAG
FROM
    DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES SC
LEFT JOIN EDISON_REVENUE_SEG RS
		ON RS.CONTRACTID = SC.CONTRACTID
    LEFT JOIN  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CONTRACTS C ON SC.CONTRACTID = C.CONTRACTID
    AND SC.AGENCYID = C.AGENCYID
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CONTRACTRATES CR ON CR.CONTRACTID = SC.CONTRACTID
    AND CR.AGENCYID = SC.AGENCYID
    AND CR.SERVICECODEID = SC.SERVICECODEID
    AND CR.TODATE :: DATE > GETDATE()
    AND CR.FROMDATE :: DATE <= GETDATE() 
    LEFT JOIN CTE ON CTE.CONTRACTID = C.CONTRACTID
    AND CTE.CONTRACTRATEID = CR.CONTRACTRATEID
    AND SC.SERVICECODEID = CTE.SERVICECODEID
WHERE
    SC.AGENCYID = 155
;
    RETURN ''SUCCESS'';
    END;
    
 EOT
}

