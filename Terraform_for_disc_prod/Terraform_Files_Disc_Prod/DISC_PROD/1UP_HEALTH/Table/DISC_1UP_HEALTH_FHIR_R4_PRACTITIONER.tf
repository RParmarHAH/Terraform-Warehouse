resource "snowflake_table" "DISC_1UP_HEALTH_FHIR_R4_PRACTITIONER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "FHIR_R4_PRACTITIONER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_HEALTH.FHIR_R4_PRACTITIONER

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
	name = "PRACTITIONER_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULL_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISACTIVE_USE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERIOD_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIOD_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NATIONAL_PROVIDER_IDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROVIDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORGANIZATION_IDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHER_PRACTITIONER_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHER_PRACTITIONER_NUMBER"
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
	name = "META_LASTUPDATED"
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

