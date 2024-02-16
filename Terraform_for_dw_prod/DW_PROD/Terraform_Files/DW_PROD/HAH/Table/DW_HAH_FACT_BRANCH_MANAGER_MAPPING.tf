resource "snowflake_table" "DW_HAH_FACT_BRANCH_MANAGER_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_BRANCH_MANAGER_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_BRANCH_MANAGER_MAPPING

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
	name = "OFFICE_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "OFFICE_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PRIMARY_MANAGER_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "PRIMARY_MANAGER_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "PRIMARY_MANAGER_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "PRIMARY_MANAGER_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SECONDARY_MANAGER_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SECONDARY_MANAGER_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECONDARY_MANAGER_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SECONDARY_MANAGER_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SECONDARY_BRANCH_EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}

}

