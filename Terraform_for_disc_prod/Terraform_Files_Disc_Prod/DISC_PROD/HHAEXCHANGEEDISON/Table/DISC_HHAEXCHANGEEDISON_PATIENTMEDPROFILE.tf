resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_PATIENTMEDPROFILE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "PATIENTMEDPROFILE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.PATIENTMEDPROFILE

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
	name = "MEDPROFILEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MEDDESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYSICIANNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DOSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOSEOTHER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "FORM"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FORMOTHER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ROUTE"
	type = "VARCHAR(200)"
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
	name = "FREQUENCYDESCRIPTION"
	type = "VARCHAR(200)"
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
	name = "PHARMACYNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CREATEDUSERNAME"
	type = "VARCHAR(50)"
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
	name = "OTHERFREQUENCYTEXT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MEDICATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYSICIANID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOCID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CERTIFICATIONPERIODID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOSEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FORMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ROUTEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FREQUENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PREFERREDPHARMACYID"
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

