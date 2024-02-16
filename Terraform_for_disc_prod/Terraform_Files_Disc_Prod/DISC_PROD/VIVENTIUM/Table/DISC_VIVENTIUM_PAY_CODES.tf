resource "snowflake_table" "DISC_VIVENTIUM_PAY_CODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	name = "PAY_CODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.VIVENTIUM.PAY_CODES

    -- Purpose : Discovery Data Population

    -- Project : VIVENTIUM

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVISIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_CODE_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_CODE_TYPE"
	type = "VARCHAR(16777216)"
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
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

