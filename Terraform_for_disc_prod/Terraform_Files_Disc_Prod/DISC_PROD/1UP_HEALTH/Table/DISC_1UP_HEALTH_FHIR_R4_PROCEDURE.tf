resource "snowflake_table" "DISC_1UP_HEALTH_FHIR_R4_PROCEDURE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "FHIR_R4_PROCEDURE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_HEALTH.FHIR_R4_PROCEDURE

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
	name = "PROCEDURE_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENCOUNTER_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_IDENTIFIER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_PRIMARY_IDENITIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IDENTIFIER_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENCOUNTER_REFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERFORMED_STARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERFORMED_ENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PROCEDURE_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_AMA_CPT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_AMA_CPT_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_OTHER_SYSTEMNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_OTHER_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_OTHER_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_SNOMEDCT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_SNOMEDCT_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_LOINC_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_LOINC_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_ICD10CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCEDURE_ICD10CODE_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERFORMER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERFORMER_FUNCTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBEHALFOF_ORGANIZATION"
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

