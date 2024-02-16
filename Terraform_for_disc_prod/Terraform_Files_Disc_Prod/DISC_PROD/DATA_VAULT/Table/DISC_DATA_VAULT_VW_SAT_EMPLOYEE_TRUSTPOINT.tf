resource "snowflake_table" "DISC_DATA_VAULT_VW_SAT_EMPLOYEE_TRUSTPOINT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_VAULT"
	name = "VW_SAT_EMPLOYEE_TRUSTPOINT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_VAULT.VW_SAT_EMPLOYEE_TRUSTPOINT

    -- Purpose : Discovery Data Population

    -- Project : DATA_VAULT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "HASH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_SSN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEE_SUFFIX"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUTA_STATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WORK_STATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REASON_TO_TERMINATE"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "FIELD_WORKER_FLAG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_TYPE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "HOURLY_PAY"
	type = "NUMBER(12,3)"
	nullable = true
}


column {
	name = "SALARY_PAY"
	type = "NUMBER(12,3)"
	nullable = true
}


column {
	name = "ADDED_DATE_UTC"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDED_FILENAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_DATE_UTC"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_FILENAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_DATE"
	type = "DATE"
	nullable = true
}

}

