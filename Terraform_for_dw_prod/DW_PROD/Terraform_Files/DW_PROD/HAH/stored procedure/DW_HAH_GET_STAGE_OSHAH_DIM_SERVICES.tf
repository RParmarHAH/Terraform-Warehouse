resource "snowflake_procedure" "DW_HAH_GET_STAGE_OSHAH_DIM_SERVICES" {
	name ="GET_STAGE_OSHAH_DIM_SERVICES"
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
-- NAME:  OSHAH DIM SERVICES 
--
-- PURPOSE: Populates Stage DIM SERVICES  for OSHAH
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/07/23    SANKET JAIN           Initial version
--06/26/23     Sagar gulghane        Modified changes in REVENUE_CATEGORY,REVENUE_SUBCATEGORY_NAME,REVENUE_SUBCATEGORY_CODE
--07/07/23     Sandesh Gosavi        update code to use config flag
--08/25/23     Mirisha               updated state and system_code logic
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.OSHAH_DIM_SERVICES

WITH STATES AS (
SELECT DISTINCT S.SERVICECODEID  ,C.STATE  FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.SERVICECODES S
JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CONTRACTS C
ON  S.CONTRACTID = C.LINKEDCONTRACTPAYERID
UNION ALL
SELECT DISTINCT S.SERVICECODEID  ,OFF.STATE  FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.SERVICECODES S
JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PAYER_REPL PR ON IFNULL(PR.CONTRACTID,PR.PAYERID) = S.ContractID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PAYEROFFICES PO ON PR.PAYERID= PO.PAYERID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL OFF ON OFF.OFFICEID = PO.OFFICEID 
  ) 

SELECT DISTINCT MD5(''OSHAH'' || ''-'' || S.SERVICECODEID || ''-'' || ''HHAEXCHANGE'')  AS SERVICE_KEY
      ,''17'' AS SOURCE_SYSTEM_ID
      ,CONCAT(''OSHAH - '',STATES.STATE) AS SYSTEM_CODE 
      ,S.SERVICECODE AS SERVICE_CODE
      ,S.SERVICECODE AS SERVICE_DESCRIPTION
      ,NVL(S.VISITTYPE,''UNKNOWN'') AS SERVICE_TYPE
      ,NVL(S.RATETYPETEXT,''UNKNOWN'')   AS SERVICE_RATE_TYPE
	  ,R.REVENUE_CATEGORY 
      ,R.REVENUE_SUBCATEGORY_CODE 
	  ,R.REVENUE_SUBCATEGORY_NAME
      ,CASE WHEN S.STATUS = ''Active'' then TRUE else FALSE end AS ACTIVE_FLAG
      ,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
   	  ,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
      ,convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE
      ,CURRENT_USER as ETL_INSERTED_BY
      ,convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE
      ,CURRENT_USER as ETL_LAST_UPDATED_BY
      ,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.SERVICECODES S
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.VW_OSHAH_REVENUE R ON R.SERVICECODEID = S.SERVICECODEID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.Contracts c  on S.ContractID = c.ContractID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.Payer_REPL PR ON  IFNULL(PR.CONTRACTID,PR.PAYERID) = S.ContractID
LEFT JOIN STATES ON S.SERVICECODEID = STATES.SERVICECODEID
WHERE STATES.STATE IN  (SELECT STATE FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CONFIGURATION WHERE CONFIG = TRUE) ;
RETURN ''SUCCESS'';
end;

 EOT
}

