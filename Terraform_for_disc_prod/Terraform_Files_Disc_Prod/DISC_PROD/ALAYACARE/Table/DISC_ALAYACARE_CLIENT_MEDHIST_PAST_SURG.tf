resource "snowflake_table" "DISC_ALAYACARE_CLIENT_MEDHIST_PAST_SURG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT_MEDHIST_PAST_SURG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT_MEDHIST_PAST_SURG

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
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DETAILS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROCEDURE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "VARCHAR(250)"
	nullable = true
}

}

