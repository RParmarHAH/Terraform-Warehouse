resource "snowflake_table" "DW_INTEGRATION_APPLICANT_CROSSWALK_E2E_DEDUPE_OUTPUT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "APPLICANT_CROSSWALK_E2E_DEDUPE_OUTPUT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.APPLICANT_CROSSWALK_E2E_DEDUPE_OUTPUT

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
	name = "ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "APPLICANT_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLUSTER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

