resource "snowflake_table" "DISC_EMPEONPREFERRED_ESCHEDULEOVERRIDE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "ESCHEDULEOVERRIDE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.ESCHEDULEOVERRIDE

    -- Purpose : Discovery Data Population

    -- Project : EMPEONPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SCHEDULEOVERRIDID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "POSTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "START_DATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MARGINBEFORE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MARGINAFTER"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OFFDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CC1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "JOBCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SHIFT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CALLOUTREASON"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ONCALL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GRACEAFTER"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GRACEBEFORE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "LUNCH"
	type = "NUMBER(18,2)"
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

