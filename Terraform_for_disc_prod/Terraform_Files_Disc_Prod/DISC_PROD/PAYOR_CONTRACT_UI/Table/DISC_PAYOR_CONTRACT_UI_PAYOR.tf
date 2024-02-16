resource "snowflake_table" "DISC_PAYOR_CONTRACT_UI_PAYOR" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYOR_CONTRACT_UI"
	name = "PAYOR"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PAYOR_CONTRACT_UI.PAYOR

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
	name = "PAYOR_ID"
	type = "NUMBER(38,0)"
	nullable = false
	comment = "Arbitrary key for the payer"
}


column {
	name = "PAYOR_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "PAYOR_TYPE_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "PARENT_PAYOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
	comment = "Arbitrary key for the parent payer"
}


column {
	name = "PARENT_PAYOR_NAME"
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


column {
	name = "UPDOPERATION"
	type = "VARCHAR(6)"
	nullable = false
}


column {
	name = "DELETE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYOR_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}

}

