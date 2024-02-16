resource "snowflake_table" "DISC_ALAYACARE_PAY_CODE_RATE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "PAY_CODE_RATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.PAY_CODE_RATE

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
	name = "PAYROLLITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_CODE_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE"
	type = "FLOAT"
	nullable = true
}

}

