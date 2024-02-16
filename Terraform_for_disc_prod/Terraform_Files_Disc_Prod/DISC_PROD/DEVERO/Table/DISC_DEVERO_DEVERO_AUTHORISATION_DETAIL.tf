resource "snowflake_table" "DISC_DEVERO_DEVERO_AUTHORISATION_DETAIL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_AUTHORISATION_DETAIL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_AUTHORISATION_DETAIL

    -- Purpose : Discovery Data Population

    -- Project : DEVERO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMIT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHSTARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCIPLINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITTOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLIEDTOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITSREMAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DAYSREMAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

