resource "snowflake_table" "DISC_ADMINPAYROLL_HIST_PTOBANKDATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADMINPAYROLL"
	name = "HIST_PTOBANKDATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADMINPAYROLL.HIST_PTOBANKDATA

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
	nullable = false
}


column {
	name = "TIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISACCRUAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TARGETPAYCODE"
	type = "VARCHAR(10)"
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

