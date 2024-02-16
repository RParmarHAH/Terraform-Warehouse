resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CLINICALMEDPROFILE485" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CLINICALMEDPROFILE485"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CLINICALMEDPROFILE485

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
	name = "MEDPROFILE485ID"
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
	name = "MASTER485ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MEDCODE"
	type = "VARCHAR(50)"
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
	name = "PHYSICIAN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DOSAGE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ROUTE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLASS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(50)"
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
	name = "COMMENTS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DOSEFORM"
	type = "VARCHAR(510)"
	nullable = true
}


column {
	name = "MEDICATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOSESCALEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOSESCALE"
	type = "VARCHAR(50)"
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
	name = "CERTIFICATIONPERIODID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CERTIFICATIONSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFICATIONENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DOCID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(163)"
	nullable = true
}


column {
	name = "PATIENTNUMBER"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PHYSICIANADDRESS"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "OTHERFREQUENCYTEXT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ISDOSEEDITED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHHAID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PATIENTPHONE"
	type = "VARCHAR(50)"
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
	name = "PREFERREDPHARMACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VERSION"
	type = "NUMBER(4,2)"
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

