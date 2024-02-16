resource "snowflake_procedure" "DW_HAH_GET_STAGE_ADPOPAL_DIM_BRANCH" {
	name ="GET_STAGE_ADPOPAL_DIM_BRANCH"
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
-- NAME: ADPOPAL_DIM_BRANCH
--
-- PURPOSE: Creates one row for each branch according to ADP-OPAL
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 27/12/2022		Aditya Shukla							Initial Development
-- 29/05/2023		Shikhar Saxena							Changd the logic to add SOURCE_SYSTEM_TYPE field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ADPOPAL_DIM_BRANCH
WITH BRANCH AS(
SELECT DISTINCT 
	MD5(18 || BRANCH_NAME || ADP_HOME_DEPT::NUMBER || ''OPAL'') AS BRANCH_KEY,
	BRANCH_NAME AS BRANCH_NAME,
	''ADP-OPAL'' AS SYSTEM_CODE,
	18 AS SOURCE_SYSTEM_ID,
	ADP_HOME_DEPT::NUMBER AS OFFICE_NUMBER,
	ADP_HOME_DEPT::NUMBER AS OFFICE_CODE,
	BRANCH_NAME AS OFFICE_NAME,
	BRANCH_NAME AS OFFICE_NAME_ALT,
	NULL AS DEPARTMENT_NAME,
	NULL AS BRANCH_SERVICE_LINE,
	TRUE AS PARENT_FLAG,
	MD5(18 || BRANCH_NAME || ADP_HOME_DEPT::NUMBER || ''OPAL'') AS PARENT_BRANCH_KEY,
	ADP_HOME_DEPT::NUMBER AS PARENT_OFFICE_NUMBER,
	ADP_HOME_DEPT::NUMBER AS PARENT_OFFICE_CODE,
	STATE || '' - '' || UPPER(TRIM(BRANCH_NAME)) || '' ('' || ADP_HOME_DEPT::NUMBER || '')'' AS PARENT_BRANCH_NAME,
	STREET_ADDRESS AS OFFICE_ADDRESS1,
	SUITE AS OFFICE_ADDRESS2,
	CITY AS OFFICE_CITY,
	STATE AS OFFICE_STATE_CODE,
	ZIP AS OFFICE_ZIP,
	REPLACE(PHONE, ''-'') AS OFFICE_PHONE,
	NULL AS OFFICE_TOLL_FREE_PHONE,
	NULL AS OFFICE_FAX,
	STATE || '' - '' || UPPER(TRIM(BRANCH_NAME)) || '' ('' || ADP_HOME_DEPT::NUMBER || '')'' AS DETAILED_OFFICE_NAME,
	NULL AS REGION_NUMBER,
	NULL AS REGION_NAME,
	NULL AS REGION_MANAGER,
	NULL AS REGION_MANAGER_EMPLOYEE_KEY,
	NULL AS SUBREGION_NAME,
	ACCOUNT_EXECUTIVE AS PRIMARY_BRANCH_MANAGER_NAME,
	TRIM(REGEXP_REPLACE(SUBSTRING(BRANCH_EMAIL, CHARINDEX(''<'', BRANCH_EMAIL)), ''<|>'')) AS PRIMARY_BRANCH_EMAIL,
	MD5(18 || BRANCH_NAME || ACCOUNT_EXECUTIVE || ''OPAL'') AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
	NULL AS SECONDARY_BRANCH_MANAGER_NAME,
	NULL AS SECONDARY_BRANCH_EMAIL,
	NULL AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
	NULL AS RISKCONNECT_NODE_KEY,
	NULL AS RISKCONNECT_NAME,
	NULL AS HR_OFFICE_NUMBER,
	NULL AS HR_OFFICE_NAME,
	CASE WHEN CLOSED_DATE IS NULL THEN TRUE ELSE FALSE END AS ACTIVE_FLAG,
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		current_date() AS ETL_INSERTED_DATE,
		current_user() AS ETL_INSERTED_BY,
		current_date() AS ETL_LAST_UPDATED_DATE,
		current_user() AS ETL_LAST_UPDATED_BY,
		FALSE ETL_DELETED_FLAG,
		FALSE ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.ADP.OPALBRANCHES
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
LEFT JOIN HAH.DIM_SOURCE_SYSTEM AS SOURCE_SYSTEM ON BRANCH.SOURCE_SYSTEM_ID = SOURCE_SYSTEM.SOURCE_SYSTEM_ID;

RETURN ''SUCESS'';

END;

 EOT
}

