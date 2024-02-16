resource "snowflake_table" "DISC_AXXESS_HIST_AXXESS_HC_CLIENTINFO_BACKUP_20240112" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "HIST_AXXESS_HC_CLIENTINFO_BACKUP_20240112"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.HIST_AXXESS_HC_CLIENTINFO_BACKUP_20240112

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATE_TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATE_TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_DELETED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLE_INITIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAL_RECORD_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER_PRONOUNS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARITAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATE_MEDICAID_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RACE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_ADDRESS_COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_ADDRESS_LINE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_ADDRESS_LINE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_ADDRESS_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_ADDRESS_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_ADDRESS_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_ADDRESS_ZIP4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYADDRESSCOUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_PHONE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICAL_MANAGER_EMPLOYEE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICAL_EMPLOYEE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASH_MANAGER_EMPLOYEE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(32,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(32,0)"
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

}

