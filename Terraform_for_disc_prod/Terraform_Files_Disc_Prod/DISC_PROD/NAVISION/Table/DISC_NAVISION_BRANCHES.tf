resource "snowflake_table" "DISC_NAVISION_BRANCHES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "NAVISION"
	name = "BRANCHES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.NAVISION.BRANCHES

    -- Purpose : Discovery Data Population

    -- Project : NAVISION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIMENSION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIMENSION_VALUE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTALING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BLOCKED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONSOLIDATION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INDENTATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GLOBAL_DIMENSION_NO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAP_TO_IC_DIMENSION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAP_TO_IC_DIMENSION_VALUE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIELD_DEPARTMENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIMENSION_VALUE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

