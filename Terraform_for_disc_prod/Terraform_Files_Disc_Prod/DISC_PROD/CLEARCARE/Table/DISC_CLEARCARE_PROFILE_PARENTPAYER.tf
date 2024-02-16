resource "snowflake_table" "DISC_CLEARCARE_PROFILE_PARENTPAYER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "PROFILE_PARENTPAYER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.PROFILE_PARENTPAYER

    -- Purpose : Discovery Data Population

    -- Project : CLEARCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYEE_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INVOICE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MULTI_CLIENT_INVOICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICE_DUEDATE_TERMS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROVIDER_NPI"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "QUALIFIER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEFAULT_MILEAGE_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "ONE_AUTHORIZATION_PER_INVOICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTH_PLAN_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PARENT_PAYER_IN_BOX_38"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOW_CARELOG_START_AND_END_IN_DESCRIPTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYS_EXPENSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYS_TAX"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BOX_23_ON_MULTIPAGE_INVOICES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PLAN_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BOX_31_CUSTOM_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TRACK_IN_N_MINUTE_UNITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAIM_SUBMISSION_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REQUIRES_CARE_LOGS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BUSINESS_ENTITY_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BUSINESS_ENTITY_MEDICAID_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "USER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ENCRYPTED_PASSWORD"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SFTP_URL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SFTP_USER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ENCRYPTED_SFTP_PASSWORD"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EVV_MANDATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EVV_PROVIDER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CLAIM_LINE_ITEM_CONTENT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LINE_ITEMS_PER_CLAIM"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILLING_PROVIDER_TAXONOMY_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INTERCHANGE_RECEIVER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INTERCHANGE_RECEIVER_ID_QUALIFIER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INTERCHANGE_SENDER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INTERCHANGE_SENDER_ID_QUALIFIER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYER_IDENTIFIER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYER_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RECEIVER_PRIMARY_IDENTIFIER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CLAIM_PLAN_TYPE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYER_PROVIDER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "FRANCHISOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
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

