resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_EMPLOYEEPROFILECODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_EMPLOYEEPROFILECODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_EMPLOYEEPROFILECODES

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
	name = "EMPLOYEE_PROFILE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "EMPLOYEE_PROFILE_NAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "RESOURCE_CATEGORY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DISCIPLINE_CODE"
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
	name = "DDL_EMPLOYEE_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_CHECK_OVER_TIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OVERTIME_CRITERIA_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATUS_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE_CODE"
	type = "VARCHAR(15)"
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

