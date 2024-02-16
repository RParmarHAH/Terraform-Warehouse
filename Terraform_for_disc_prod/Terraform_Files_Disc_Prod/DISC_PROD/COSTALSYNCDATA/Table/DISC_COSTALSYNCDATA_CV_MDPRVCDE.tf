resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_MDPRVCDE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_MDPRVCDE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_MDPRVCDE

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
	name = "PROVIDER_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "EMPLOYER_ID_NUMBER"
	type = "VARCHAR(13)"
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
	name = "SPECIALTY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROVIDER_CATEGORY"
	type = "VARCHAR(3)"
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
	name = "PHONE_NUMBER"
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
	name = "PHONE_COMMENTT"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "DEGREE"
	type = "VARCHAR(31)"
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
	name = "FORM_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "STATRT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END__DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYEE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROVIDER_UNIT_RATE"
	type = "NUMBER(19,5)"
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
	name = "OTHER_PROVIDER_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "NOTE_40"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "TAXID_TYPE"
	type = "VARCHAR(3)"
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
	name = "EMAIL"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "DEA"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "FAX_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "WORK_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CELL_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BEEPER_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "HOME_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CB_SQL_UPGRADE_01"
	type = "NUMBER(3,0)"
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

