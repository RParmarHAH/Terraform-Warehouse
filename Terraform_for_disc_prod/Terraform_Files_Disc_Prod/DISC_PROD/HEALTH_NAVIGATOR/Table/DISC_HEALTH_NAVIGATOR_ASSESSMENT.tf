resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_ASSESSMENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "ASSESSMENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.ASSESSMENT

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
	name = "ACUITY_LEVEL__C"
	type = "VARCHAR(124)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACCOUNTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONTACTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "TOTAL_SCORE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "COMPLETED_DATE_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SAVED_DATE_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LAST_SAVED_BY__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ACUITY_SCORE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ASSESSMENTRATING"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "COMPLETED_BY__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RESPONSECONTEXTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "EFFECTIVEDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PARENTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXPIRATIONDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CASEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "OLD_ASSESSMENT_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASSESSMENTSTATUS"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "ARCHIVE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

