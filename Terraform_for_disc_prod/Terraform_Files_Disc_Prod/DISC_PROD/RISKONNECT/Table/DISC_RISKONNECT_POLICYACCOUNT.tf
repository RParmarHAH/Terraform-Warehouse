resource "snowflake_table" "DISC_RISKONNECT_POLICYACCOUNT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "POLICYACCOUNT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.POLICYACCOUNT

    -- Purpose : Discovery Data Population

    -- Project : RISKONNECT

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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MASTERRECORDID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PARENTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGSTREET"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGPOSTALCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGCOUNTRY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGLATITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGLONGITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGGEOCODEACCURACY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIPPINGSTREET"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIPPINGCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIPPINGSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIPPINGPOSTALCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIPPINGCOUNTRY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIPPINGLATITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIPPINGLONGITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHIPPINGGEOCODEACCURACY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNTNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEBSITE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SIC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INDUSTRY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ANNUALREVENUE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NUMBEROFEMPLOYEES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OWNERSHIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TICKERSYMBOL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RATING"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SITE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "JIGSAW"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "JIGSAWCOMPANYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNTSOURCE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SICDESC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SALESFORCECUSTOMER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "A_M_BEST_RATING__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTIVE__C"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "TAX_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CATEGORY_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COLOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ID_PRIOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAIC_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EIN_TAX_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TAXABLE_ENTITY_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROPERTY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CARRIER_RATING_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INACTIVE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABA_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_ADDRESS_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_ADDRESS_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_CONTACT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_COUNTRY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_FAX_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_PHONE_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_STATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_ZIP_CODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_ADDRESS_LINE_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_ADDRESS_LINE_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_COUNTRY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_STATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_ZIP_CODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BENEFICIARY_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLABE_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IBAN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SWIFT_NUMBER__C"
	type = "VARCHAR(50)"
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
	type = "NUMBER(1,0)"
	nullable = true
}

}

