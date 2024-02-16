resource "snowflake_table" "DISC_1UP_HEALTH_FHIR_R4_RELATEDPERSON" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "FHIR_R4_RELATEDPERSON"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_HEALTH.FHIR_R4_RELATEDPERSON

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
	name = "RELATEDPERSON_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RELATEDPERSON_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISACTIVEUSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULLNAME"
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
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESSLINE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESSLINE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSTALCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RELATIONSHIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RELATIONWITHPATIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTACTNUMBER"
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
	name = "METASOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METALASTUPDATAED"
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

