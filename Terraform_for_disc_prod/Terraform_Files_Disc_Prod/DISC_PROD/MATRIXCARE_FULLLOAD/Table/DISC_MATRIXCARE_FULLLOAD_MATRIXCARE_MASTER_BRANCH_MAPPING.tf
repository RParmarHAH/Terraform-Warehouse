resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_MATRIXCARE_MASTER_BRANCH_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "MATRIXCARE_MASTER_BRANCH_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.MATRIXCARE_MASTER_BRANCH_MAPPING

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONVERGED_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CONVERGED_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "CONVERGED_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "CONVERGED_OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "CONVERGED_OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}

}

