resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_SCHEDULECHANGES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "SCHEDULECHANGES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.SCHEDULECHANGES

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
	name = "SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "INVOICEDETAILID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "SCHEDULETYPE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHEDULEDSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRIMARYCONTRACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRIMARYSERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISMISSEDVISIT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TIMESHEETREQUIRED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EVVSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVVENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VERIFIEDBY"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "VERIFIEDTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DATEVERIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEVERIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SUPERVISOR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TIMESHEETAPPROVED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DUTIESPERFORMED"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "TRAVELTIMEMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILLEDMINUTES"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYROLLPAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYROLLBATCHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "OFFICEID"
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

