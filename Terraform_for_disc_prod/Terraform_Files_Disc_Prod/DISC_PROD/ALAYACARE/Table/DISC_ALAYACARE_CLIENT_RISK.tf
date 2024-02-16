resource "snowflake_table" "DISC_ALAYACARE_CLIENT_RISK" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT_RISK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT_RISK

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
	name = "RISK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SEVERITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_CREATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RISK_CREATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RISK_UPDATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

