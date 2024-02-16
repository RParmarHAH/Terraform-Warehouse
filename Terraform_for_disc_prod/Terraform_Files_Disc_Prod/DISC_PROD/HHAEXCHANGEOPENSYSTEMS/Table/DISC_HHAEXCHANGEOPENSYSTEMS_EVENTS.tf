resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_EVENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "EVENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.EVENTS

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
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "EVENTID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "EVENTTYPE"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVENTDATEUTC"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "SCHEDULEDTIME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHANGEINSERVICEDATEFROM"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHANGEINSERVICEDATETO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PREVIOUSCAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NEWCAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OVERTIMEREQUESTHOURSINMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMEREQUESTHOURSINMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "APPROVEDHOURSINMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "APPROVEDDATEUTC"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "APPROVEDBYUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EVENTSTATUS"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "DISCHARGEDATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CREATEDBYUSERNAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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

