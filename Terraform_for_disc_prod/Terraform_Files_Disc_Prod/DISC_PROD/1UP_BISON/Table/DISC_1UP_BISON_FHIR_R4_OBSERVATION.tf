resource "snowflake_table" "DISC_1UP_BISON_FHIR_R4_OBSERVATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_BISON"
	name = "FHIR_R4_OBSERVATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_BISON.FHIR_R4_OBSERVATION

    -- Purpose : Discovery Data Population

    -- Project : 1UP_BISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OBSERVATION_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENCOUNTER_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OBSERVATIONPUBLISHEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OBSERVATIONSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATIONPRIMARYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOINCCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOINCCODEDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SNOMEDCTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SNOMEDCTCODEDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHEROBSERVATIONSYSTEMNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHEROBSERVATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHEROBSERVATIONCODEDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATIONCODETEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_INTERPRETATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_INTERPRETATIONDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_METHODCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METHODDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_VALUE_RANGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_VALUE_RANGE_UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATION_VALUE_RANGE_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERFORMEDBY"
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
	name = "METALASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "METASOURCE"
	type = "VARCHAR(16777216)"
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

