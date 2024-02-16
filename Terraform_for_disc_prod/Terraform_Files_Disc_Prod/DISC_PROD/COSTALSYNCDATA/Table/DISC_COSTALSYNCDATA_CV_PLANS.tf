resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_PLANS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_PLANS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_PLANS

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
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PLAN_NAME"
	type = "VARCHAR(31)"
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
	name = "PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EXTENSION_NUMBER"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CONTACT_PERSON"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "INSURANCE_TYPE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CLAIM_FORM_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "ACCEPT_ASSIGNMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "APPROVED_WRITE_OFF"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYMENT_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ELECTRONIC_CLAIM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "FORMAT_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PAYOR_ID"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "PAYOR_SUB_ID"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "SOURCE_OF_PAYMENT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "GROUP_BY_TOS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "GROUP_BY_POS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLAIM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLAIM_PAYMENT_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BILLTO_STATUS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROCEDURE_CODING"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CB_ZERO_BAL_CLAIMS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_CREDIT_BAL_CLAIMS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_CLAIM_BY_PROCEDURE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_CLAIM_BY_PROC_SERV_DT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_GROUP_BY_AUTHORIZATI"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "EMC_FORMAT_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DDL_COPAY_OPTION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_ROUNDING_PROGRAM"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_CHECK_FREQUENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_CLAIM_BY_BILL"
	type = "NUMBER(3,0)"
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

