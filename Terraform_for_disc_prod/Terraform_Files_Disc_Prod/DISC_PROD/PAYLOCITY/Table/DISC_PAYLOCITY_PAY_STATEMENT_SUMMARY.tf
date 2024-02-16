resource "snowflake_table" "DISC_PAYLOCITY_PAY_STATEMENT_SUMMARY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYLOCITY"
	name = "PAY_STATEMENT_SUMMARY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PAYLOCITY.PAY_STATEMENT_SUMMARY

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
	name = "AUTOPAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BEGINDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DIRECTDEPOSITAMOUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSSPAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NETCHECK"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NETPAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OVERTIMEDOLLARS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OVERTIMEHOURS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROCESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REGULARDOLLARS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REGULARHOURS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TRANSACTIONNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VOUCHERNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "WORKERSCOMPCODE"
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

