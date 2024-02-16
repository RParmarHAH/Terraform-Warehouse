resource "snowflake_table" "DISC_CCSI_EMPCALL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "EMPCALL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.EMPCALL

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "VARCHAR(9999999)"
	nullable = true
}


column {
	name = "EMP_NUMBER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REVERSE_INDEX_KEY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMP_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REVERSE_INDEX_KEY1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_ON"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_BY1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C2"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C3"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C4"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C5"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C6"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C7"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C8"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C9"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "C_C10"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LOCKED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ADMIN_CODE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FOLLOWUP"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DESK"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "WORKMANS_COMP_CLAIM"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REFUSED_HOURS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "POSTED_TO_EMPWC"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FKEYS_TXCODE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(200)"
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
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

