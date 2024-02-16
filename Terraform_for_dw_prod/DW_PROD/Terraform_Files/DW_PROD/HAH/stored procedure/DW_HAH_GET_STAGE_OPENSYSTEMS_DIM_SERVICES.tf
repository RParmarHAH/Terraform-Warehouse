resource "snowflake_procedure" "DW_HAH_GET_STAGE_OPENSYSTEMS_DIM_SERVICES" {
	name ="GET_STAGE_OPENSYSTEMS_DIM_SERVICES"
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
-- NAME:  OPENSYSTEMS DIM SERVICES 
--
-- PURPOSE: Populates Stage DIM SERVICES  for OPENSYSTEMS
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/07/23    SANKET JAIN           Initial version
-- 06/26/23    SAGAR GULGHANE        Modified changes in REVENUE_CATEGORY,REVENUE_SUBCATEGORY_NAME,REVENUE_SUBCATEGORY_CODE
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.OPENSYSTEMS_DIM_SERVICES

SELECT DISTINCT MD5(''OPENSYSTEMS'' || ''-'' || S.SERVICECODEID || ''-'' || ''HHAEXCHANGE'')  AS SERVICE_KEY
      ,''17'' AS SOURCE_SYSTEM_ID
      ,CONCAT(''OPENSYSTEMS - '',CASE WHEN IFNULL(TRIM(c.State),TRIM(PR.State)) IN (''PA'',''DE'') THEN IFNULL(TRIM(c.State),TRIM(PR.State))
   				   WHEN S.CONTRACTNAME LIKE ''%DE'' THEN ''DE''  ELSE ''PA'' END) AS SYSTEM_CODE  
      ,S.SERVICECODE AS SERVICE_CODE
      ,S.SERVICECODE AS SERVICE_DESCRIPTION
      ,NVL(S.VISITTYPE,''UNKNOWN'') AS SERVICE_TYPE
      ,NVL(S.RATETYPETEXT,''UNKNOWN'')   AS SERVICE_RATE_TYPE
	  ,R.REVENUE_CATEGORY AS REVENUE_CATEGORY
      ,R.REVENUE_SUBCATEGORY_CODE as REVENUE_SUBCATEGORY_CODE
	  ,R.REVENUE_SUBCATEGORY_NAME as REVENUE_SUBCATEGORY_NAME
      ,CASE WHEN S.STATUS = ''Active'' then TRUE else FALSE end AS ACTIVE_FLAG
      ,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
   	  ,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
      ,convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE
      ,CURRENT_USER as ETL_INSERTED_BY
      ,convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE
      ,CURRENT_USER as ETL_LAST_UPDATED_BY
      ,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.SERVICECODES S
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.VW_OPENSYSTEMS_REVENUE R ON R.SERVICECODEID = S.SERVICECODEID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.Contracts c  on S.ContractID = c.ContractID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.Payer_REPL PR ON  IFNULL(PR.CONTRACTID,PR.PAYERID) = S.ContractID;
RETURN ''SUCCESS'';
end;

 EOT
}

