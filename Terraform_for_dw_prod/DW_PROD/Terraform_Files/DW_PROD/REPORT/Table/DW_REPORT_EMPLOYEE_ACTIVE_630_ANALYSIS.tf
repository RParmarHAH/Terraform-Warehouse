resource "snowflake_table" "DW_REPORT_EMPLOYEE_ACTIVE_630_ANALYSIS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "EMPLOYEE_ACTIVE_630_ANALYSIS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.EMPLOYEE_ACTIVE_630_ANALYSIS

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "UNION_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADAPTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IN_ARTIS_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ARTIS_FILE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OVERALL_QC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DISC_OPS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ACTIVE_IN_JUNE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(300)"
	nullable = true
}

}

