resource "snowflake_table" "DISC_TRUSTPOINTDATA_EMPLOYEES_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
	name = "EMPLOYEES_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.TRUSTPOINTDATA.EMPLOYEES_MAPPING

    -- Purpose : Discovery Data Population

    -- Project : TRUSTPOINTDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_EIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHANGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBJECT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIELD_DESC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEW_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OLD_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RANK"
	type = "VARCHAR(16777216)"
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

