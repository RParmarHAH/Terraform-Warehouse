resource "snowflake_table" "DISC_1UP_HEALTH_FHIR_R4_PATIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "FHIR_R4_PATIENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_HEALTH.FHIR_R4_PATIENT

    -- Purpose : Discovery Data Population

    -- Project : 1UP_HEALTH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PATIENT_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREFIX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUFFIX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULLNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MOTHERSMAIDENNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MARITALSTATUSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARTIALSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DECEASEDBOOLEAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DECEASEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISTRICT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSTALCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREFERREDLANGUAGECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREFERREDLANGUAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HAH_CLIENT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIQUE_MEMBER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HL7_PID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBERNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTMEDICARENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTMEDICAIDNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DRIVINGLICENSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TJU_CMRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHER_SYSTEMS_IDENTIFIERS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHER_IDENTIFIERS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CELLPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CELLPHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAILID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RELIGION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RELIGION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICITY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGINORGANIZATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METAEVENTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METAMESSAGETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METAEVENTTIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "METAPROCESSTIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "METASOURCERECORDID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METAPROCESSCLIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "META_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METALASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

