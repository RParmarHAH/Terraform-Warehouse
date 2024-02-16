resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_REJECTEDCALLS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "REJECTEDCALLS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.REJECTEDCALLS

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
	name = "REJECTEDCALLID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "MAINTENANCEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ASSIGNMENTID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CAREGIVERCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CAREGIVERPHONE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAREGIVERPHONE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAREGIVERTEAM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "CALLDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CALLTIME_0"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CALLTYPE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "CALLERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EVVSOURCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EVVTYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DUTYSHEETCOUNT"
	type = "NUMBER(10,0)"
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
	type = "NUMBER(10,0)"
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

