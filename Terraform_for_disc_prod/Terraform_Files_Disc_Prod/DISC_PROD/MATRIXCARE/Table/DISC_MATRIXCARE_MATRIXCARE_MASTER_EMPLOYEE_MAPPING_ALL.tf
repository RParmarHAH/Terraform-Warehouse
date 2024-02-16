resource "snowflake_table" "DISC_MATRIXCARE_MATRIXCARE_MASTER_EMPLOYEE_MAPPING_ALL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "MATRIXCARE_MASTER_EMPLOYEE_MAPPING_ALL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_EMPLOYEE_MAPPING_ALL

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
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
	name = "EMPLOYEE_ADDRESS_1"
	type = "VARCHAR(765)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS_2"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "MASTER_EMPLOYEE_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MASTER_EMPLOYEE_NUMBER"
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
	nullable = false
}

}

