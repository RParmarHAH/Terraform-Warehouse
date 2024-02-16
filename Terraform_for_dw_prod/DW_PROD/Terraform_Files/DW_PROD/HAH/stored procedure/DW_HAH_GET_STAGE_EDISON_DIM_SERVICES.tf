resource "snowflake_procedure" "DW_HAH_GET_STAGE_EDISON_DIM_SERVICES" {
	name ="GET_STAGE_EDISON_DIM_SERVICES"
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
-- NAME:  EDISON DIM SERVICES
--
-- PURPOSE: Populates Stage DIM SERVICES  for EDISON
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/05/22    SAM HUFF             Initial version
-- 06/26/23    Nutan Jagnade        Modified changes in  service_key , REVENUE_CATEGORY,REVENUE_SUBCATEGORY_NAME,REVENUE_SUBCATEGORY_CODE
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.EDISON_DIM_SERVICES

SELECT DISTINCT MD5(''EDISON'' || ''-'' || S.SERVICECODEID ||  ''-'' ||NVL(REV.REVENUE_SUBCATEGORY_CODE,''UNKNOWN'')|| ''-'' || ''EDISON'') AS SERVICE_KEY,
       ''17''                AS SOURCE_SYSTEM_ID,
       ''EDISON'' AS SYSTEM_CODE,
       S.SERVICECODE     AS SERVICE_CODE,
       S.SERVICECODE     AS SERVICE_DESCRIPTION,
       NVL(S.VISITTYPE,''UNKNOWN'')         AS SERVICE_TYPE,
       NVL(S.RATETYPETEXT,''UNKNOWN'')   AS SERVICE_RATE_TYPE,
       COALESCE(REV.REVENUE_CATEGORY ,''UNKNOWN'')AS  REVENUE_CATEGORY,
       COALESCE(REV.REVENUE_SUBCATEGORY_CODE,''UNKNOWN'') AS REVENUE_SUBCATEGORY_CODE,
       COALESCE(REV.REVENUE_SUBCATEGORY_NAME,''UNKNOWN'') AS REVENUE_SUBCATEGORY_NAME,
       CASE WHEN S.STATUS = ''Active'' then TRUE else FALSE end AS ACTIVE_FLAG,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
        CURRENT_USER as ETL_INSERTED_BY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
        CURRENT_USER as ETL_LAST_UPDATED_BY,
        0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES S
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VISITINFO_REPL VI ON S.SERVICECODEID = VI.PRIMARYSERVICECODEID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECATEGORY_REPL SC ON SC.SERVICECATEGORYID = VI.SERVICECATEGORYID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VW_EDISON_REVENUE_SEG REV ON REV.SERVICECODEID  = VI.PRIMARYSERVICECODEID 
WHERE S.AGENCYID = 155 ;
return ''SUCCESS'';
END;

 EOT
}

