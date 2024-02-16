resource "snowflake_table" "DISC_AXXESS_HIST_AXXESS_HH_AUTHORIZATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "HIST_AXXESS_HH_AUTHORIZATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.HIST_AXXESS_HH_AUTHORIZATION

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AUTHORIZATION_DETAIL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATE_TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATE_TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_PAYER_PAYMENT_SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_PAYER_PAYMENT_SOURCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_SERVICE_CATEGORY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_SERVICE_CATEGORY_BILLCODE_LIST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_SERVICE_UNIT_TYPE_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_SERVICE_UNIT_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_SERVICE_UNIT_TYPE_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_SERVICE_DAY_LIST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_SERVICE_VISITS_PER_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_SERVICE_UNIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_CLIENT_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_CLIENT_MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_CLIENT_BRANCH_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_CLIENT_BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_UTILIZATION_USED_UNIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_UTILIZATION_UNUSED_UNIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
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

