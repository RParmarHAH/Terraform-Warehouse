resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_DIM_SERVICES" {
	name ="GET_STAGE_PREFERRED_DIM_SERVICES"
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
-- NAME:  PREFERRED DIM SERVICES 
--
-- PURPOSE: Populates Stage DIM SERVICES  for PREFERRED
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/07/23    SANKET JAIN           Initial version
--06/26/23     NUTAN JAGNADE         Modified changes in service_key added REVENUE_CATEGORY,REVENUE_SUBCATEGORY_NAME,REVENUE_SUBCATEGORY_CODE
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.PREFERRED_DIM_SERVICES

SELECT DISTINCT MD5(''PREFERRED'' || ''-'' || S.SERVICECODEID || ''-'' ||NVL(VOR.REVENUE_SUBCATEGORY_CODE,''-1'')|| ''-'' || ''HHAEXCHANGE'')  AS SERVICE_KEY
      ,''17'' AS SOURCE_SYSTEM_ID
      ,''PREFERRED'' AS SYSTEM_CODE  
      ,S.SERVICECODE AS SERVICE_CODE
      ,S.SERVICECODE AS SERVICE_DESCRIPTION
      ,NVL(S.VISITTYPE,''UNKNOWN'') AS SERVICE_TYPE
      ,NVL(S.RATETYPETEXT,''UNKNOWN'')   AS SERVICE_RATE_TYPE
	  ,  COALESCE(VOR.REVENUE_CATEGORY,''UNKNOWN'') AS REVENUE_CATEGORY
	, COALESCE(VOR.REVENUE_SUBCATEGORY_CODE,''UNKNOWN'') AS  REVENUE_SUBCATEGORY_CODE
	, COALESCE(VOR.REVENUE_SUBCATEGORY_NAME,''UNKNOWN'') AS REVENUE_SUBCATEGORY_NAME
      ,CASE WHEN S.STATUS = ''Active'' then TRUE else FALSE end AS ACTIVE_FLAG
      ,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
   	  ,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
      ,convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE
      ,CURRENT_USER as ETL_INSERTED_BY
      ,convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE
      ,CURRENT_USER as ETL_LAST_UPDATED_BY
      ,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.SERVICECODES S
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.REVENUE_MAPPING  vor ON VOR.SERVICECODEID = S.SERVICECODEID;
RETURN ''SUCCESS'';
end;

 EOT
}

