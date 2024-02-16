resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_EMPLOYEES_TEMP_20231229" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_EMPLOYEES_TEMP_20231229"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_EMPLOYEES_TEMP_20231229

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
	name = "USER_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "NURSE_ID"
	type = "VARCHAR(9)"
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
	name = "LAST_FIRST_NAME"
	type = "VARCHAR(45)"
	nullable = true
}


column {
	name = "DISCIPLINE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROVIDER_CODE"
	type = "VARCHAR(7)"
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
	name = "PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "WORK_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMERGENCY_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BEEPER_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "ZONE_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DESCRIPTION30_FROM"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "DESCRIPTION30_THRU"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NUMBER"
	type = "VARCHAR(9)"
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

