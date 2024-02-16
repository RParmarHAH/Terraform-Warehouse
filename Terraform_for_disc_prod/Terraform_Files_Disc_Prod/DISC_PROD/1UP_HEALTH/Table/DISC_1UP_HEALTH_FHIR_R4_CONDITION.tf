resource "snowflake_table" "DISC_1UP_HEALTH_FHIR_R4_CONDITION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "FHIR_R4_CONDITION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_HEALTH.FHIR_R4_CONDITION

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
	name = "CONDITION_ONEUP_KEY"
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
	name = "CONDITION_IDENTIFICATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONDITION_EXTERNAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONDITIONCATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICALSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONDITIONVERIFICATIONSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONDITION_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ICD10CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ICD10CODEDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ICD9CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ICD9CODEDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SNOMEDCTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SNOMEDCTCDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHERSYSTEMNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHERSYSTEMCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHERSYSTEMCODEDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONSETDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CONDITIONASSERTEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONDITIONASSERTEDDATE"
	type = "DATE"
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

