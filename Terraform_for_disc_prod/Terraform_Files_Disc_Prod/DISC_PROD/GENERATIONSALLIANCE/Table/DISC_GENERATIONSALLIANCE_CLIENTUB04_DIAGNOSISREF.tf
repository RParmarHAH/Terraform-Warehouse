resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CLIENTUB04_DIAGNOSISREF" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CLIENTUB04_DIAGNOSISREF"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CLIENTUB04_DIAGNOSISREF

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "HCFAID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DIAGNOSISCODE1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE6"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE7"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE8"
	type = "VARCHAR(10)"
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

