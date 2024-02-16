resource "snowflake_table" "DISC_ADMINPAYROLL_EMPLOYEEPTODATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADMINPAYROLL"
	name = "EMPLOYEEPTODATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADMINPAYROLL.EMPLOYEEPTODATA

    -- Purpose : Discovery Data Population

    -- Project : ADMINPAYROLL

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "KEY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "COMPANYCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATAJSON"
	type = "VARCHAR(16777216)"
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

