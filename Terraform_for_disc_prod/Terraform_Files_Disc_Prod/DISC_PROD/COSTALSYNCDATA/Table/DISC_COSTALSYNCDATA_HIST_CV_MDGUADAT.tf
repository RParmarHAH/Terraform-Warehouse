resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_MDGUADAT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_MDGUADAT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_MDGUADAT

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(15)"
	nullable = false
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ENTRY_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GUARANTOR_NUMBER"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MIDDLE_INITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "STREET_NAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BIRTH_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SEX"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SALUTE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMERGENCY_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CONTACT_PERSON"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "BILLTO_STATUS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "OPEN_ITEM_BAL_FORWARD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "STATEMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STATEMENT_CYCLE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "NO_STATEMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESTATEMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STATEMENT_DAYS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "GUARANTOR_SIGN_ON_FILE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "AUOT_SELFPAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "AUTO_SELFPAY_DAYS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "AUTO_ADJUSTMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "MINIMUM_BALANCE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DUNNING_MESSAGE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NO_MESSAGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MESSAGE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CREDITSTAT_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMPLOYER_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMPLOYER_NAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EMPLOYER_STREET"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "ADDRESS_2"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EMPLOYER_CITY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "EMPLOYER_STATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMPLOYER_ZIPCODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMPLOYER_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EXTENSION_NUMBER"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "EMPLOYMENT_EMAIL"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "EMPLOYER_CONTACT"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "CONTACT_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMPLOYER_CONTACT_EXTN"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "EMPLOYER_CONTACT_EMAIL"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "BUSINESS_TYPE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "FINANCE_CHAARGE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "UNUSED_INTEGER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "REBILL_CHARGE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "REBILL_CHARGE_RATE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TOTAL_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "TOTAL_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "TOTAL_ADJUSTMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LAST_CHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_ADJUSTMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_STATEMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_CLAIM_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_BILLTO_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYMENT_STATUS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TOTAL_CONTRACTUAL"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FINANCE_CHARGE_METHO"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FINANCE_CHARGE_RATE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "INTERFACE_GUARANTOR_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "OCCUPATION__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "GUARANTOR_CONTACT"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "REFERING_PATIENT"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "RECALLRESN_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "RECALL_DAYS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "LAST_RECALL_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RECALL_NOTE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "CRLF"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CELL_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
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

