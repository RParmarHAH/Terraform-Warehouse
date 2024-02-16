resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_PAYRATES_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "PAYRATES_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PAYRATES_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

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
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DISCIPLINEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISDEFAULTRATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLLSETUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXCLUDEFROMOT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULTTRAVELTIMERATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DEFAULTINSERVICERATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DEFAULTOFFDUTYTIMERATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DEFAULTMILEAGERATE"
	type = "VARCHAR(10)"
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
	name = "UPDATEDBY"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
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

