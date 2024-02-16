resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_LOCATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_LOCATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_LOCATIONS

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
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
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
	name = "EMPLOYER_ID_NUMBER"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "CLAIM_FORM_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "STATEMENT_FORM_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "NOSHOW_DAYS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "HISTORY_DAYS"
	type = "VARCHAR(3)"
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
	name = "TSR_FORM"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "DURATION"
	type = "VARCHAR(5)"
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

