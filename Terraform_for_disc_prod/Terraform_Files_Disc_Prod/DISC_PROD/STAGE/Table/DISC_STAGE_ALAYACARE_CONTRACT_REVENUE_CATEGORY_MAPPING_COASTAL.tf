resource "snowflake_table" "DISC_STAGE_ALAYACARE_CONTRACT_REVENUE_CATEGORY_MAPPING_COASTAL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "ALAYACARE_CONTRACT_REVENUE_CATEGORY_MAPPING_COASTAL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.ALAYACARE_CONTRACT_REVENUE_CATEGORY_MAPPING_COASTAL

    -- Purpose : Discovery Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICECODE"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "BILLCODENAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FUNDERCODE"
	type = "VARCHAR(33)"
	nullable = true
}


column {
	name = "LEGACY_CONTRACT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCHNAME"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SUGGESTED_REVENUE_CATEGORY"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "SUGGESTED_REVENUE_SUB_CATEGORY"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BILLABLE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PAYABLE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

