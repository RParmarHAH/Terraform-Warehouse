resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_PAYLOCATIONFACILITYPLANSHIFT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_PAYLOCATIONFACILITYPLANSHIFT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_PAYLOCATIONFACILITYPLANSHIFT

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
	nullable = false
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
	name = "START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DDL_LOC_FAC"
	type = "NUMBER(3,0)"
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
	name = "PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SHIFT_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "BASE_RATE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "WEEKDAY_PAYRATE_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "WEEKEND_PAYRATE_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "WEEKEND_PAYRATE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "HOLIDAY_PAYRATETYPE_ARR3_1"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HOLIDAY_PAYRATETYPE_ARR3_2"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HOLIDAY_PAYRATETYPE_ARR3_3"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HOLIDAY_PAYRATE_ARR3_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "HOLIDAY_PAYRATE_ARR3_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "HOLIDAY_PAYRATE_ARR3_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "ROW_ID"
	type = "NUMBER(10,0)"
	nullable = false
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

