resource "snowflake_table" "DW_REPORT_COVID_19_SF_EXTERNAL_DATA_VISITS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "COVID_19_SF_EXTERNAL_DATA_VISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.COVID_19_SF_EXTERNAL_DATA_VISITS

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
	name = "DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "VISIT_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAPPING_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CASES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DEATHS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGE_IN_CASES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGE_IN_DEATHS"
	type = "NUMBER(38,0)"
	nullable = true
}

}

