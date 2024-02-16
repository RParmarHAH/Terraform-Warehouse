resource "snowflake_table" "DW_HAH_FACT_AREA_DEPRIVATION_INDEX" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_AREA_DEPRIVATION_INDEX"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_AREA_DEPRIVATION_INDEX

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
	name = "AREA_DEPRIVATION_INDEX_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ADI_YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ZIP_CODE_PLUS_FOUR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "GISJOIN"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIPS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADI_NATRANK_PERCENTILE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ADI_STATERANK_DECILE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NATRANK_SUPRESSION_REASON"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "STATERANK_SUPRESSION_REASON"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ZIP_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

