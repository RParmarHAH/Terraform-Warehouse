resource "snowflake_table" "DW_STAGE_OPENSYSTEMS_FACT_ADMISSION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "OPENSYSTEMS_FACT_ADMISSION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.OPENSYSTEMS_FACT_ADMISSION

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENT_ADMISSION_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "REFERRER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PARTNER_CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PRIMARY_DIAGNOSIS_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REFERRAL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REFERRAL_INTAKE_BY_EMP_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REFERRAL_ACCEPTED_SERVICES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_CAMPAIGN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREVIOUS_PROVIDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PRIMARY_DIAGNOSIS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DISCHARGE_REASON"
	type = "VARCHAR(16777216)"
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

