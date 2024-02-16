resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_FACILITIES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_FACILITIES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_FACILITIES

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
	name = "FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FACILITY_NAME"
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
	name = "CONTACT_PERSON"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "TAX_ID"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "PLACE_OF_SERVICE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FACILITYCATG"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FACILITY_TYPE_CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FROM_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "THRU_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DURATION"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "SUBTAXID_NUMBER"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "CLAIM_OPTION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_BILL_AFTER_DISCHG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SPECIALTY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "WORK_FACTOR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PE_FACTOR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MP_FACTOR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STATEMENT_FORM_CODE"
	type = "VARCHAR(5)"
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
	name = "BLUE_CROSS_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "COMMERCIAL_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BRANCH_ID_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMC_SITE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "TAXONOMY_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "RESIDENCY_CODES"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CB_SWING_BED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INCLUDE_DETAILS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_CREATE_ORDER_REQ"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "FAX_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "DDL_MPPR_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "MPPR_LOCALITY_ID"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "TIME_ZONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CB_DST_NOT_OBSERVED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_URBAN_RURAL"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_NO_PAY_RAP"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_DONT_CAL_ST_PDPM_OBRA"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_EMAR_REQUIREMENTS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_ETAR_REQUIREMENTS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_EINTERVENTION_REQUIRE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MAIN_EMAIL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "FINANCIAL_EMAIL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SCHEDULE_EMAIL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLINICAL_EMAIL"
	type = "VARCHAR(255)"
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

