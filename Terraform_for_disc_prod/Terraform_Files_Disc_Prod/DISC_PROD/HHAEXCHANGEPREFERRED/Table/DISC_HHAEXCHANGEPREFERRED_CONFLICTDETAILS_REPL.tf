resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_CONFLICTDETAILS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "CONFLICTDETAILS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.CONFLICTDETAILS_REPL

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
	name = "CONFLICTDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYERNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AGENCYNAME"
	type = "VARCHAR(200)"
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
	name = "CAREGIVERSSN"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AGENCYPHONENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "BILLEDHOURS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLEDMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDHOURS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULEDMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONFLICTINGHOURS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CONFLICTPATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONFLICTPATIENTNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CONFLICTADMISSIONID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CONFLICTPAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONFLICTPAYERNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CONFLICTAGENCYNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CONFLICTCAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONFLICTCAREGIVERNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CONFLICTCAREGIVERCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONFLICTVISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CONFLICTAGENCYPHONENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONFLICTVISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONFLICTVISITSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONFLICTVISITENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONFLICTSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTECREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOTECREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAREGIVERFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULEDTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CONFLICTSCHEDULEDTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OVERLAPMINUTES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "VISITTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CONFLICTVISITTIME"
	type = "VARCHAR(10)"
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
	name = "CONFLICTOFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONFLICTOFFICENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICEPATIENTCODE"
	type = "VARCHAR(85)"
	nullable = true
}


column {
	name = "OFFICECAREGIVERCODE"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CONFLICTOFFICEPATIENTCODE"
	type = "VARCHAR(85)"
	nullable = true
}


column {
	name = "CONFLICTOFFICECAREGIVERCODE"
	type = "VARCHAR(12)"
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

