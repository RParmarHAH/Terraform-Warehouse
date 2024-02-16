resource "snowflake_table" "DISC_1UP_BISON_FHIR_R4_ORGANIZATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_BISON"
	name = "FHIR_R4_ORGANIZATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_BISON.FHIR_R4_ORGANIZATION

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
	name = "ORGANIZATION_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IDENTIFICATION_VALUE"
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

