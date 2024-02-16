resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_REFPOCTASKS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "REFPOCTASKS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.REFPOCTASKS_REPL

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
	name = "POCTASKID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "POCTASKCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCCATEGORYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TASKNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POCMASTERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "DUTYLISTSETUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ALLOWADDITIONALPROMPTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NUMBEROFDIGITS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DISPLAYDECIMAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DECIMALLENGTH"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "MINALLOWABLEENTRY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MAXALLOWABLEENTRY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ALLOWMILEAGE"
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
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
	type = "NUMBER(10,0)"
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

