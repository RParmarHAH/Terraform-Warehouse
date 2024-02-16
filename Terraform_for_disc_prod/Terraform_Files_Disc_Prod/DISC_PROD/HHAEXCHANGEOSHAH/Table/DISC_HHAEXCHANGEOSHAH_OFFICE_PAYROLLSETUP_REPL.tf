resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_OFFICE_PAYROLLSETUP_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "OFFICE_PAYROLLSETUP_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_PAYROLLSETUP_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

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
	name = "PAYROLLSETUPID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PAYROLLSETUPNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYPREFERENCESKILLED"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PAYPREFERENCENONSKILLED"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OVERTIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OVERTIMEMINS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OVERTIMERATE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MINDAILYMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALCULATEOTFORPRIORWEEK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLLWEEKENDINGDAY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "MULTIPLEPAYROLLPERCAREGIVERPERPAYROLL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OFFICENAMES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUTOFFOTRATE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISPLAYPATIENTONSTUB"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DAILYCAPPED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISDAILYHOURLYPAID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BLENDEDCUTOFFOTRATE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PREPAYROLLPROCESSADDDISCIPLINE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PREPAYROLLPROCESSUPDATEPAYCODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLLCREATIONONANYWEEKENDINGDAY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYTRAVELTIMETOTHEMINUTE"
	type = "VARCHAR(5)"
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
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTUPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTUPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTUPDATEDUTCDATE"
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

