resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_PAYROLL_HEADER_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "PAYROLL_HEADER_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.PAYROLL_HEADER_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HEADERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEEKSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WEEKEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TOTALHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTALOTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTALAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTALOTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTALHOLIDAYHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTALHOLIDAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYROLLSETUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXPENSEAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MILEAGEAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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

}

