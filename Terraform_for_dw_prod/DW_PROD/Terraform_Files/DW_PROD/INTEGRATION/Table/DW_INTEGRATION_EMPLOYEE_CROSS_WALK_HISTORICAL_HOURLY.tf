resource "snowflake_table" "DW_INTEGRATION_EMPLOYEE_CROSS_WALK_HISTORICAL_HOURLY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "EMPLOYEE_CROSS_WALK_HISTORICAL_HOURLY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_HISTORICAL_HOURLY

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ENTERPRISE_ID"
	type = "NUMBER(38,0)"
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
	name = "BRANCH_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "AMS_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "AMS_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMS_SYSTEM_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "AMS_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMS_METADATA"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PAYROLL_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_SYSTEM_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_METADATA"
	type = "VARIANT"
	nullable = true
}


column {
	name = "APPLICANT_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "APPLICANT_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "APPLICANT_SYSTEM_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "APPLICANT_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMS_IVR_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GATOR_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "GATOR_EMPLOYEE_ACCOUNT_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COACHUPCARE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CARIBOU_ID_SENT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SERVICENOW_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DERIVED_WORKDAY_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WORKDAY_USERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORKDAY_INTERNAL_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BROADSPIRE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OKTA_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OKTA_USERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACTIVE_DIRECTORY_SID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVE_DIRECTORY_EMAIL"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "EMPLOYEE_RISKONNECT_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MOST_RECENT_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MOST_RECENT_PAYROLL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EXCEPTION_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DUP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DUP_FLAG_REASON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMS_PUBLIC_ID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_SSN"
	type = "VARCHAR(51)"
	nullable = true
}

}

