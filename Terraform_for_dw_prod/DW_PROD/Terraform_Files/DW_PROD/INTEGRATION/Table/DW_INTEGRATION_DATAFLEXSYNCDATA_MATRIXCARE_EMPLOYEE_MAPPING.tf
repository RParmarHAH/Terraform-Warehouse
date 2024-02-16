resource "snowflake_table" "DW_INTEGRATION_DATAFLEXSYNCDATA_MATRIXCARE_EMPLOYEE_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "DATAFLEXSYNCDATA_MATRIXCARE_EMPLOYEE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.DATAFLEXSYNCDATA_MATRIXCARE_EMPLOYEE_MAPPING

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "MATRIX_EMP_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "MATRIX_EMP_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATAFLEX_EMP_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DATAFLEX_EMP_ID"
	type = "VARCHAR(50)"
	nullable = true
}

}

