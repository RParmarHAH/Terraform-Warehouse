resource "snowflake_table" "DISC_GPSYNCDATA_GP_PROD_ISSUE0925_GP_STATE_TAX" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "GP_PROD_ISSUE0925_GP_STATE_TAX"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.GP_PROD_ISSUE0925_GP_STATE_TAX

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXEMPT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WITHHOLDING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILINGSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILINGSTATUSTEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INACTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

