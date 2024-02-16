resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_SERVICECATEGORYCODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_SERVICECATEGORYCODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_SERVICECATEGORYCODES

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
	name = "SERVICE_CATEGORY_CODE"
	type = "VARCHAR(7)"
	nullable = false
}


column {
	name = "SERVICE_CATG_CODE_DESC"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "DDL_SERVICE_CATG_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PROCCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CB_SPLIT_SCHEDULE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_WEEKEND_CROSSOVER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_HOLIDAY_CROSSOVER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_VISIT_BILL_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_VISIT_PAY_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BILLABLE_CONV_FACTOR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYABLE_CONV_FACTOR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DISCIPLINE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DDL_SPLIT_SCHEDULE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_SCHEDULE_BY_DATE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_PR_SHIFT_CROSS_OVER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_PR_WEEKEND_CROSS_OVER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_PR_HOLIDAY_CROSS_OVER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OT_SERVICE_CATEGORY"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_EXCLUDE_OVERTIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_FLAT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "VIST_PRODUCTIVITY_FACTOR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CB_BONUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_EXCLUDE_FOR_BONUS_UNI"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WEEKEND_PAYRATE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "HOLIDAY_TYPE_ARR3_1"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HOLIDAY_TYPE_ARR3_2"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HOLIDAY_TYPE_ARR3_3"
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
	name = "WEEKEND_PROCEDURE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "HOLIDAY_PROCEDURE_ARR3_1"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "HOLIDAY_PROCEDURE_ARR3_2"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "HOLIDAY_PROCEDURE_ARR3_3"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CB_ALLOW_DUP_SVC_SCH"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_CHECK_CLN_NOTE_STATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_SERVICE_CATG_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INACTIVATED_DATE"
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

