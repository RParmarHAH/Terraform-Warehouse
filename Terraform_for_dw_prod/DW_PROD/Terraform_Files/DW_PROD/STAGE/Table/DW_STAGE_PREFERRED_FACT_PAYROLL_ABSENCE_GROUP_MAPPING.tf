resource "snowflake_table" "DW_STAGE_PREFERRED_FACT_PAYROLL_ABSENCE_GROUP_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "PREFERRED_FACT_PAYROLL_ABSENCE_GROUP_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.PREFERRED_FACT_PAYROLL_ABSENCE_GROUP_MAPPING

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CAREGIVERABSENCETYPESID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ABSENCETYPESNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ABSENCEGROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

