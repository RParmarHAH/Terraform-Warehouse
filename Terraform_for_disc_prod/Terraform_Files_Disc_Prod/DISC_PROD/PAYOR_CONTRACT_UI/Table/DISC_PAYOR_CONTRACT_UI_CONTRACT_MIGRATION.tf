resource "snowflake_table" "DISC_PAYOR_CONTRACT_UI_CONTRACT_MIGRATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYOR_CONTRACT_UI"
	name = "CONTRACT_MIGRATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PAYOR_CONTRACT_UI.CONTRACT_MIGRATION

    -- Purpose : Discovery Data Population

    -- Project : PAYOR_CONTRACT_UI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "LEGACY_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "LEGACY_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "LEGACY_CONTRACT_CODE"
	type = "VARCHAR(40)"
	nullable = false
}


column {
	name = "LEGACY_CONTRACT_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TARGET_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "TARGET_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "TARGET_CONTRACT_CODE"
	type = "VARCHAR(40)"
	nullable = false
}


column {
	name = "TARGET_CONTRACT_NAME"
	type = "VARCHAR(100)"
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

}

