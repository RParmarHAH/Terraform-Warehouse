resource "snowflake_table" "DISC_GPSYNCDATA_GP_PROD_ISSUE0925_GP_FED_TAX" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "GP_PROD_ISSUE0925_GP_FED_TAX"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.GP_PROD_ISSUE0925_GP_FED_TAX

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
	name = "FEDERALFILINGSTATUSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERALFILINGSTATUSNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERALMARITALSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERALEXEMPT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALWITHHOLDING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ESTIMATEDWITHHOLDING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCALTAXCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXWITHHOLDINGSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARRIEDWITHHOLDINGASSINGLE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

