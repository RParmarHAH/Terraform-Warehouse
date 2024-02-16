resource "snowflake_procedure" "DW_HAH_GET_STAGE_OSHAH_DIM_PARTNER" {
	name ="GET_STAGE_OSHAH_DIM_PARTNER"
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
-- NAME:  OSHAH_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to OSHAH 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/22/23     SANKET JAIN          Initial development
-- 07/12/23     Sandesh Gosavi         update code to use config flag
-- 08/25/23     Mirisha              updated state and system_code logic
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.OSHAH_DIM_PARTNER

WITH STATES AS (
SELECT DISTINCT S.SERVICECODEID , C.STATE  FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.SERVICECODES S			-- FOR linked contracts WITH linkedid
JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CONTRACTS C	
ON  S.CONTRACTID = C.LINKEDCONTRACTPAYERID															-- NOT joining WITH payer AND THEN payeroffice AS one linked contractid will ave multiple contracts, AND thus multilpe payors, which further would have multiple offices per payer (state can be one or more.)
JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PAYER_REPL PR ON IFNULL(PR.CONTRACTID,PR.PAYERID) = C.ContractID
 ) 

, PARTNER AS 
(
	SELECT MD5(''OSHAH'' || ''-'' || PR.PAYERID || ''-'' || ''HHAEXCHANGE'') AS PARTNER_KEY
        , NULL AS PARENT_PARTNER_KEY
        , ''UNKNOWN'' AS PARENT_PARTNER_NAME 
		, 17 AS SOURCE_SYSTEM_ID
		, CONCAT(''OSHAH - '', nvl(off.STATE,PR.STATE)) AS SYSTEM_CODE	
        , PR.PAYERNAME AS PARTNER_NAME                                                                                      
		, PR.PAYERID::VARCHAR  AS PARTNER_CODE
		, PR.STATUS  AS ACTIVE_FLAG
		FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PAYER_REPL PR
	    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PAYEROFFICES PO ON PR.PAYERID= PO.PAYERID  --ADDED 
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL OFF ON OFF.OFFICEID = PO.OFFICEID   --ADDED
		WHERE nvl(off.STATE,PR.STATE) IN  (SELECT STATE FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CONFIGURATION WHERE CONFIG = TRUE)
)
,ADDITIONAL_PARTNER AS (
	SELECT * FROM PARTNER
	UNION ALL
  	SELECT DISTINCT MD5(''OSHAH'' || ''-'' || S.CONTRACTID || ''-'' || ''HHAEXCHANGE'') AS PARTNER_KEY
        , NULL AS PARENT_PARTNER_KEY
        , ''UNKNOWN'' AS PARENT_PARTNER_NAME 
		, 17 AS SOURCE_SYSTEM_ID
		, CONCAT(''OSHAH - '', STATES.STATE) AS SYSTEM_CODE		
        , CASE WHEN S.CONTRACTID IN (14475,20154,16999,17470) THEN regexp_replace(S.CONTRACTNAME,''.....$'','''') ELSE S.CONTRACTNAME END AS PARTNER_NAME                                                                                      
		, S.CONTRACTID::VARCHAR  AS PARTNER_CODE
		, CASE WHEN S.STATUS =''Active'' THEN TRUE ELSE FALSE END AS ACTIVE_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.SERVICECODES S 
LEFT JOIN STATES ON S.SERVICECODEID = STATES.SERVICECODEID
WHERE 1=1
AND STATES.STATE IN  (SELECT STATE FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CONFIGURATION WHERE CONFIG = TRUE)
AND PARTNER_KEY NOT IN 
(SELECT PARTNER_KEY FROM PARTNER) 
AND S.CONTRACTID NOT IN (SELECT NVL(CONTRACTID,0) FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PAYER_REPL)
)
SELECT DISTINCT *, ''1990-01-01''::DATE AS START_DATE
		, ''9999-12-31''::DATE END_DATE 
		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0::BOOLEAN AS ETL_DELETED_FLAG
		, 0::BOOLEAN AS ETL_INFERRED_MEMBER_FLAG 
FROM ADDITIONAL_PARTNER;

return ''SUCCESS'';
END;

 EOT
}

