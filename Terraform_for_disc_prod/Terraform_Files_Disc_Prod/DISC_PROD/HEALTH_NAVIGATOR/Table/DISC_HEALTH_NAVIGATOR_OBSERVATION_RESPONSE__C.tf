resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_OBSERVATION_RESPONSE__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "OBSERVATION_RESPONSE__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.OBSERVATION_RESPONSE__C

    -- Purpose : Discovery Data Population

    -- Project : HEALTH_NAVIGATOR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SDOH_ACUITY_SCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "EVENT_ACUITY_SCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REASON_REVIEW_ONLY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLIENT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "END_DATE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "EMPLOYEE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ACUITY_SCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "OBSERVATION_VERSION__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LANGUAGE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COMPLETED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXTERNAL_ID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "REVIEWED_DATE_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "START_DATE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DURATION__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYSICAL_ACUITY_SCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "OBSERVATION_DATE_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LOCATION__LONGITUDE__S"
	type = "NUMBER(13,10)"
	nullable = true
}


column {
	name = "BEHAVIORAL_ACUITY_SCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "REVIEW_COMPLETED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SURVEY_ID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LOCATION__LATITUDE__S"
	type = "NUMBER(13,10)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "REVIEWEDBYID__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DATE_RECORDED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

