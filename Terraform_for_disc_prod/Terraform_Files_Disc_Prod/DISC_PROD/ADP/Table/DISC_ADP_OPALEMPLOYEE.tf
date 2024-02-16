resource "snowflake_table" "DISC_ADP_OPALEMPLOYEE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "OPALEMPLOYEE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.OPALEMPLOYEE

    -- Purpose : Discovery Data Population

    -- Project : ADP

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PAYROLL_COMPANY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOME_DEPARTMENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOME_DEPARTMENT_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_ID_SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BIRTH_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITION_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITION_EFFECTIVE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITION_EFFECTIVE_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REHIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATION_REASON_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATION_REASON_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_DEATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_PREFERRED_ADDRESS_ADDRESS_LINE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_PREFERRED_ADDRESS_ADDRESS_LINE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_PREFERRED_ADDRESS_ADDRESS_LINE_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_PREFERRED_ADDRESS_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_PREFERRED_ADDRESS_STATE_TERRITORY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGAL_PREFERRED_ADDRESS_ZIP_POSTAL_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_CONTACT_PERSONAL_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_CONTACT_USE_PERSONAL_EMAIL_FOR_NOTIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_CONTACT_WORK_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER_SELF_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICITY_RACE_ID_METHOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARITAL_STATUS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARITAL_STATUS_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKER_CATEGORY_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FLSA_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EEOC_JOB_CLASSIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CLASS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CLASS_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_ADDRESS_STATE_TERRITORY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_SDI_TAX_CODE_DESCRIPTION"
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

}

