resource "snowflake_table" "DISC_1UP_BISON_FHIR_R4_ALLERGYINTOLERANCE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_BISON"
	name = "FHIR_R4_ALLERGYINTOLERANCE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_BISON.FHIR_R4_ALLERGYINTOLERANCE

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
	name = "ALLERGYINTOLERANCE_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_UNIQUE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLERGYINTOLERANCE_IDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLERGYSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLERGYVERIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLERGYCATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLERGYRISK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLERGY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIFFERENT_CODES_ALLERGY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDERREFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REACTION"
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

