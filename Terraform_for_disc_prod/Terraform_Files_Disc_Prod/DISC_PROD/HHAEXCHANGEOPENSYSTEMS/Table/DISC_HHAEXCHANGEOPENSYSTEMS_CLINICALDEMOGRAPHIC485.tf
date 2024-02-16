resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CLINICALDEMOGRAPHIC485" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CLINICALDEMOGRAPHIC485"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CLINICALDEMOGRAPHIC485

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
	name = "DEMOGRAPHICID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "MASTER485ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VENDORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTHICLAIMNO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STARTOFCARE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MEDICALRECORD"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PROVIDERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENTFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENTLASTNAME"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(55)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROVIDERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROVIDERADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROVIDERTELEPHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENTDOB"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENTSEX"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ALLERGIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NURSENAME"
	type = "VARCHAR(110)"
	nullable = true
}


column {
	name = "VERBALSOCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYSICIANID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYSICIANNAME"
	type = "VARCHAR(110)"
	nullable = true
}


column {
	name = "PHYSICIANADDRESS"
	type = "VARCHAR(300)"
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
	name = "NURSEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYSICIANNPI"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PHYSICIANPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYSICIANFAX"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENTPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROVIDERFAX"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYSICIANADDRESSID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PHYSICIANADDRESSPHONE2"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PHYSICIANADDRESSPHONE3"
	type = "VARCHAR(30)"
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

