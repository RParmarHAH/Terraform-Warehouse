resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_CAREPATHALERTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "CAREPATHALERTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.CAREPATHALERTS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

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
	name = "VISITFEEDBACKDETAILID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FEEDBACKPRIORITY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RECEIVED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEELAPSED"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ALERT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALERTSTATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NURSENAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "COORDINATOR"
	type = "VARCHAR(500)"
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

