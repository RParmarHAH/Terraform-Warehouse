resource "snowflake_table" "DISC_1UP_BISON_FHIR_R4_COVERAGE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_BISON"
	name = "FHIR_R4_COVERAGE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_BISON.FHIR_R4_COVERAGE

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
	name = "COVERAGE_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COVERAGE_IDENTIFIER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBERNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HEALTHPLANIDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBSCRIBERNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTMEDICAIDNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTMEDICARENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERIOD_START"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIOD_END"
	type = "DATE"
	nullable = true
}


column {
	name = "SUBSCRIBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBSCRIBER_POLICYHOLDER_RELATIONSHIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBSCRIBER_POLICYHOLDER_RELATIONSHIP_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLASSNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLASSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROUPORPLANNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER"
	type = "NUMBER(38,0)"
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

