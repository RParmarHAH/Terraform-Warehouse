resource "snowflake_table" "DW_STAGE_QUICKBOOKS_DIM_BRANCH" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "QUICKBOOKS_DIM_BRANCH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.QUICKBOOKS_DIM_BRANCH

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_NAME_ALT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_SERVICE_LINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PARENT_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PARENT_OFFICE_NUMBER"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PARENT_OFFICE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_TOLL_FREE_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_FAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DETAILED_OFFICE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGION_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGION_MANAGER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGION_MANAGER_EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBREGION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_MANAGER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARY_BRANCH_MANAGER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARY_BRANCH_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RISKCONNECT_NODE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RISKCONNECT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HR_OFFICE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HR_OFFICE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EFFECTIVE_FROM_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EFFECTIVE_TO_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

