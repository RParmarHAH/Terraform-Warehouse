resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CLINICALMEDICATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CLINICALMEDICATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CLINICALMEDICATIONS

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
	name = "CLINICALDOCUMENTMEDICATIONID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MEDPROFILEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLINICALDOCID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "MEDICATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MEDDESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PHYSICIANID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOSEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOSEOTHER"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "FORMID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FORMOTHER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ROUTEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ROUTEOTHER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLASS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FREQUENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTHERFREQUENCYTEXT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ORDERDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TAUGHTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCONTINUEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCONTINUEORDERDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PREFERREDPHARMACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ORDERTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CERTIFICATIONPERIODID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INCLUDEINMEDPROFILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DOSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ROUTE"
	type = "VARCHAR(200)"
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

