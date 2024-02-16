resource "snowflake_procedure" "DW_HAH_GET_STAGE_EMPEONPREFERRED_DIM_BRANCH" {
	name ="GET_STAGE_EMPEONPREFERRED_DIM_BRANCH"
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
-- NAME: EMPEONPREFERRED_DIM_BRANCH
--
-- PURPOSE: Creates one row for each BRANCH according TO EMPEON-PREFERRED
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 18/10/2022		Aditya Shukla / Jigar Prajapati			Initial Development
-- 25/05/2023		Shikhar Saxena							Changed the logic to add SOURCE_SYSTEM_TYPE field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.EMPEONPREFERRED_DIM_BRANCH
WITH BRANCH AS(
SELECT DISTINCT
	MD5(22 || ''-'' || TRIM(CO) || ''-'' || ''EMPEONPREFERRED'') AS BRANCH_KEY,
	TRIM(CO) AS BRANCH_NAME,
	''EMPEONPREFERRED'' || ''-'' || TRIM(CO) AS SYSTEM_CODE,
	22 AS SOURCE_SYSTEM_ID,
	-1 AS OFFICE_NUMBER,
	-1 AS OFFICE_CODE,
	NULL AS OFFICE_NAME,
	NULL AS OFFICE_NAME_ALT,
	NULL AS DEPARTMENT_NAME,
	NULL AS BRANCH_SERVICE_LINE,
	TRUE AS PARENT_FLAG,
	MD5(22 || ''-'' || TRIM(CO) || ''-'' || ''EMPEONPREFERRED'') AS PARENT_BRANCH_KEY,
	-1 AS PARENT_OFFICE_NUMBER,
	-1 AS PARENT_OFFICE_CODE,
	TRIM(CO) AS PARENT_BRANCH_NAME,
	NULL AS OFFICE_ADDRESS1,
	NULL AS OFFICE_ADDRESS2,
	NULL AS OFFICE_CITY,
	NULL AS OFFICE_STATE_CODE,
	NULL AS OFFICE_ZIP,
	NULL AS OFFICE_PHONE,
	NULL AS OFFICE_TOLL_FREE_PHONE,
	NULL AS OFFICE_FAX,
	NULL AS DETAILED_OFFICE_NAME,
	NULL AS REGION_NUMBER,
	NULL AS REGION_NAME,
	NULL AS REGION_MANAGER,
	NULL AS REGION_MANAGER_EMPLOYEE_KEY,
	NULL AS SUBREGION_NAME,
	NULL AS PRIMARY_BRANCH_MANAGER_NAME,
	NULL AS PRIMARY_BRANCH_EMAIL,
	NULL AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
	NULL AS SECONDARY_BRANCH_MANAGER_NAME,
	NULL AS SECONDARY_BRANCH_EMAIL,
	NULL AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
	NULL AS RISKCONNECT_NODE_KEY,
	NULL AS RISKCONNECT_NAME,
	NULL AS HR_OFFICE_NUMBER,
	NULL AS HR_OFFICE_NAME,
	TRUE AS ACTIVE_FLAG,
	''1900-01-01''::DATE EFFECTIVE_FROM_DATE,
	''2099-01-01''::DATE EFFECTIVE_TO_DATE,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'',
		CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		convert_timezone(''UTC'',
		CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG,
		FALSE AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EINFO_TABLE
)
SELECT BRANCH.BRANCH_KEY,
BRANCH.BRANCH_NAME,
BRANCH.SYSTEM_CODE,
BRANCH.SOURCE_SYSTEM_ID,
SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE,
BRANCH.OFFICE_NUMBER,
BRANCH.OFFICE_CODE,
BRANCH.OFFICE_NAME,
BRANCH.OFFICE_NAME_ALT,
BRANCH.DEPARTMENT_NAME,
BRANCH.BRANCH_SERVICE_LINE,
BRANCH.PARENT_FLAG,
BRANCH.PARENT_BRANCH_KEY,
BRANCH.PARENT_OFFICE_NUMBER,
BRANCH.PARENT_OFFICE_CODE,
BRANCH.PARENT_BRANCH_NAME,
BRANCH.OFFICE_ADDRESS1,
BRANCH.OFFICE_ADDRESS2,
BRANCH.OFFICE_CITY,
BRANCH.OFFICE_STATE_CODE,
BRANCH.OFFICE_ZIP,
BRANCH.OFFICE_PHONE,
BRANCH.OFFICE_TOLL_FREE_PHONE,
BRANCH.OFFICE_FAX,
BRANCH.DETAILED_OFFICE_NAME,
BRANCH.REGION_NUMBER,
BRANCH.REGION_NAME,
BRANCH.REGION_MANAGER,
BRANCH.REGION_MANAGER_EMPLOYEE_KEY,
BRANCH.SUBREGION_NAME,
BRANCH.PRIMARY_BRANCH_MANAGER_NAME,
BRANCH.PRIMARY_BRANCH_EMAIL,
BRANCH.PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
BRANCH.SECONDARY_BRANCH_MANAGER_NAME,
BRANCH.SECONDARY_BRANCH_EMAIL,
BRANCH.SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
BRANCH.RISKCONNECT_NODE_KEY,
BRANCH.RISKCONNECT_NAME,
BRANCH.HR_OFFICE_NUMBER,
BRANCH.HR_OFFICE_NAME,
BRANCH.ACTIVE_FLAG,
BRANCH.EFFECTIVE_FROM_DATE,
BRANCH.EFFECTIVE_TO_DATE,
BRANCH.ETL_TASK_KEY,
BRANCH.ETL_INSERTED_TASK_KEY,
BRANCH.ETL_INSERTED_DATE,
BRANCH.ETL_INSERTED_BY,
BRANCH.ETL_LAST_UPDATED_DATE,
BRANCH.ETL_LAST_UPDATED_BY,
BRANCH.ETL_DELETED_FLAG,
BRANCH.ETL_INFERRED_MEMBER_FLAG
FROM BRANCH
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SOURCE_SYSTEM AS SOURCE_SYSTEM ON BRANCH.SOURCE_SYSTEM_ID = SOURCE_SYSTEM.SOURCE_SYSTEM_ID;
	
END;

 EOT
}

