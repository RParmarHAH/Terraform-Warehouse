resource "snowflake_table" "DW_HAH_DIM_JAZZHR_PARADOX_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_JAZZHR_PARADOX_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_JAZZHR_PARADOX_MAPPING

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "MAPPING_ID"
	type = "NUMBER(11,0)"
	nullable = true
}


column {
	name = "JAZZHR_APPLICANT_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARADOX_APPLICANT_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}

}

