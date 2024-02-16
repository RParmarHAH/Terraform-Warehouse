resource "snowflake_table" "DISC_ALAYACARE_INTAKE_MESSAGES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "INTAKE_MESSAGES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.INTAKE_MESSAGES

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ORIGINAL_REQUIRED_FIRST_VISIT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ORIGINAL_DATE_SERVICE_REQUIRED_BY"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFERRAL_TRANSMISSION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FREQ_END_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PATIENT_AVAILABLE_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FREQ_START_DATE_FIRST"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_DATE_FIRST"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICETYPECODE_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICETYPECODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_PRIORITY_RATING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_PATHWAY_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_REFERRAL_CASELOAD"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_CARE_COORDINATOR"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_PREFERRED_LANGUAGE"
	type = "VARCHAR(250)"
	nullable = true
}

}

