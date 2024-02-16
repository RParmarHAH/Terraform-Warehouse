resource "snowflake_table" "DISC_1UP_BISON_HIST_FHIR_R4_ENCOUNTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_BISON"
	name = "HIST_FHIR_R4_ENCOUNTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_BISON.HIST_FHIR_R4_ENCOUNTER

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
	name = "SOURCE_DATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
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

}

