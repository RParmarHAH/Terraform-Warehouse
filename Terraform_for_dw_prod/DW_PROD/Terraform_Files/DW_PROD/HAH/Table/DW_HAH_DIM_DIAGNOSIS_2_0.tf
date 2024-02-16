resource "snowflake_table" "DW_HAH_DIM_DIAGNOSIS_2_0" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_DIAGNOSIS_2_0"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_DIAGNOSIS_2_0

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
	name = "DIAGNOSIS_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ICD9"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ICD10"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIAGNOSIS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_CODE_INDICATOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHORT_DESC"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LONG_DESC"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

