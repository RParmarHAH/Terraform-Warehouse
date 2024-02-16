resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CLINICALDOCUMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CLINICALDOCUMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CLINICALDOCUMENTS

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
	nullable = false
}


column {
	name = "CLINICALDOCID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "HHAVISITID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITINFOID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITTIME"
	type = "VARCHAR(50)"
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
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DOCUMENTTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ENTRYMODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ATTACHMENTEXISTS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DOCUMENTSTATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VENDORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AIDENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COMPLETEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTPRINTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DOCTYPEVERSIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MASTER485ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTUNABLETOSIGN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PATIENTSIGNATURE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICIANSIGNATURE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DELETEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DELETEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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

