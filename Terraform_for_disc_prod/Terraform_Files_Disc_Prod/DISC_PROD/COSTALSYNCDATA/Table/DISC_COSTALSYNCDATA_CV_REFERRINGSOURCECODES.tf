resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_REFERRINGSOURCECODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_REFERRINGSOURCECODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_REFERRINGSOURCECODES

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
	type = "VARCHAR(20)"
	nullable = true
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
	name = "REFERRING_SOURCE_CODE"
	type = "VARCHAR(7)"
	nullable = true
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
	name = "PRACTICE_NAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "ADDRESS"
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
	name = "CONTACT_PERSON"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EMERGENCY_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "DEGREE"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "SPECIALTY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "REFSRC_CATG"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "TAX_ID"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "EMPLOYER_ID_NUMBER"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "PROVIDER_UNIQUE_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "NOTE_40"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "MEDICARE_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MEDICAID_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PTD_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CASH_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CHECK_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CREDIT_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_INSURANCE_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_OTHER_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CONTRACTUAL"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_ADJUSTMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_VISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PTD_PATIENT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PTD_PROCEDURE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YTD_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CASH_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CHECK_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CREDIT_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_INSURANCE_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_OTHER_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CONTRACTUAL"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD__ADJUSTMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_VISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YTD_PATIENT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YTD_PROCEDURE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BLUE_CROSS_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "OTHER_PROVIDER_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "DEPARTMENT__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TAXONOMY_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "REFERRING_SOURCE_EMAIL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "SALES_PERSON_ID"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CB_NPI"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_PECOS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NPI_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PECOS_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_CHECKED_DATE"
	type = "TIMESTAMP_NTZ(9)"
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

