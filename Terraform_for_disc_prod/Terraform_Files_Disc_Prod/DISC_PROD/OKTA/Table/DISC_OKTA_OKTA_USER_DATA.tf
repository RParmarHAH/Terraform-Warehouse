resource "snowflake_table" "DISC_OKTA_OKTA_USER_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "OKTA"
	name = "OKTA_USER_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.OKTA.OKTA_USER_DATA

    -- Purpose : Discovery Data Population

    -- Project : OKTA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OKTA_INTERNAL_USER_ID"
	type = "VARCHAR(25)"
	nullable = false
}


column {
	name = "USER_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTIVATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS_CHANGED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_LOGIN_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PASSWORD_CHANGED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATA_READ_TIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OKTA_USERNAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ENTERPRISE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ROLE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "IS_EMPLOYEE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "BRANCH_STATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARY_EMAIL"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "SECONDARY_EMAIL"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "PRIMARY_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MOBILE_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MANAGER_EMPLOYEE_KEY"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "MANAGER_EMPLOYEE_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "LOCALE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IMPORT_BATCH_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

