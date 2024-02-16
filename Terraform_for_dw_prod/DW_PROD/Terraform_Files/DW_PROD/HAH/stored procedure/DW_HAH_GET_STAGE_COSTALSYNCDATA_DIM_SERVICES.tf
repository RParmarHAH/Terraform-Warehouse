resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_DIM_SERVICES" {
	name ="GET_STAGE_COSTALSYNCDATA_DIM_SERVICES"
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
-- NAME:  COSTALSYNCDATA_DIM_SERVICES
--
-- PURPOSE: Creates one row per SERVICE_CODE, RATE_TYPE AND SERVICE_LINE combination according to COSTALSYNCDATA
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                	NOTES:
-- --------    -------------------   	-----------------------------------------------------------------------------------------------
--11/08/23       NUTAN JAGNADE            INITIAL VERSION 
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_DIM_SERVICES
SELECT
	md5(TRIM(PLANS.DB) || ''-'' || TRIM(PLANS.PLAN_CODE) || ''-''  || ''COSTALSYNCDATA'') AS SERVICE_KEY, --PK
	case when TRIM(PLANS.DB) = ''SHC_ALTRUS'' then 1 else 2 end SOURCE_SYSTEM_ID, --BK
	TRIM(PLANS.DB) AS SYSTEM_CODE, 
    TRIM(PLANS.PLAN_CODE) AS SEVICE_CODE, 
    PLANS.PLAN_NAME AS SERVICE_DESCRIPTION,
    NULL AS SERVICE_TYPE,
    NULL AS SERVICE_RATE_TYPE,
    CASE TRIM(PLANS.DB) WHEN ''SHC_ALTRUS'' THEN ''CLS''
    	WHEN ''SHC_SAVANNAH'' THEN ''HC'' END AS REVENUE_CATEGORY,
	CASE TRIM(PLANS.DB) WHEN ''SHC_ALTRUS'' THEN ''RES''
    	WHEN ''SHC_SAVANNAH'' THEN ''HC'' END AS REVENUE_SUBCATEGORY_CODE,
	CASE TRIM(PLANS.DB) WHEN ''SHC_ALTRUS'' THEN ''RESIDENTIAL CILA/DAILY''
    	WHEN ''SHC_SAVANNAH'' THEN ''HOME CARE'' END AS REVENUE_SUBCATEGORY_NAME,
	--CASE WHEN SUPERVISORS.SC_State_check = 1 THEN ''SC'' ELSE ''GA'' END AS CONTRACT_STATE_CODE,
    	TRUE AS ACTIVE_FLAG,
	     -1 AS ETL_TASK_KEY
       , -1 AS ETL_INSERTED_TASK_KEY              
        , CONVERT_TIMEZONE(''UTC'',CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
        , CURRENT_USER AS ETL_INSERTED_BY
        , CONVERT_TIMEZONE(''UTC'',CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
        , CURRENT_USER AS ETL_LAST_UPDATED_BY
        , 0 AS ETL_DELETED_FLAG
 FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_PLANS AS PLANS;
  RETURN ''SUCCESS'';
    END;
    
 EOT
}

