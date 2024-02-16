resource "snowflake_table" "DISC_PAYLOCITY_PAY_STATEMENT_DETAILS_HISTORICAL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYLOCITY"
	name = "PAY_STATEMENT_DETAILS_HISTORICAL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PAYLOCITY.PAY_STATEMENT_DETAILS_HISTORICAL

    -- Purpose : Discovery Data Population

    -- Project : PAYLOCITY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANYID"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(12,3)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DETCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DETTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ELIGIBLECOMPENSATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TRANSACTIONNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TRANSACTIONTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
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
	type = "NUMBER(1,0)"
	nullable = true
}

}

