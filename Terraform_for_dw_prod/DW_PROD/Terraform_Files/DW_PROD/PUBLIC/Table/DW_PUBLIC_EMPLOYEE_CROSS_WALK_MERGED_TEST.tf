resource "snowflake_table" "DW_PUBLIC_EMPLOYEE_CROSS_WALK_MERGED_TEST" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "EMPLOYEE_CROSS_WALK_MERGED_TEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.EMPLOYEE_CROSS_WALK_MERGED_TEST

    -- Purpose : 

    -- Project : PUBLIC

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
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LATEST_ENTERPRISE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OLD_ENTERPRISE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MERGE_REASON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}

}

