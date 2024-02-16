resource "snowflake_table" "DISC_ASR_HIST_ASR_PAYROLL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_PAYROLL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_PAYROLL

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CO_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BATCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REG_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OT_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TEMP_DEPT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REG_HOURS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REG_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OT_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYER_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGULAR_EARNINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OT_EARNINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_EARNINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_LOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMBINED_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
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

