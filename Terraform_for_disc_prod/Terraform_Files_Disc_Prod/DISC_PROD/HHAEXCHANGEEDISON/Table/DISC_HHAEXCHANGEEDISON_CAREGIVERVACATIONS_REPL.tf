resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_CAREGIVERVACATIONS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "CAREGIVERVACATIONS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.CAREGIVERVACATIONS_REPL

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
	name = "CAREGIVERVACATIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CAREGIVERABSENCETYPESID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYROLLBATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "APPLYABSENCEHOURSTOPAYROLL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PTOAPPROVED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PTOHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(19,0)"
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
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
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

