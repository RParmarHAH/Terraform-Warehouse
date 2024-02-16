resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_CPTSKFREQ" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_CPTSKFREQ"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_CPTSKFREQ

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
	name = "CARE_PLAN_NUMBER"
	type = "VARCHAR(15)"
	nullable = false
}


column {
	name = "CLINICAL_TASK_CTG_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CLINICAL_TASK_CODE"
	type = "VARCHAR(11)"
	nullable = false
}


column {
	name = "CB_SUNDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_MONDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_TUESDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_WEDNESDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_THURSDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_FRIDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_SATURDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_DAILY_EVERY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_DAILY_EVERY_WEEKDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RB_PATTERN_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TIMES_PER_DAY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NO_OF_TIMES_PER_FREQ"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "RECUR_EVERY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_EVERY_HOUR"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CB_PRN_FREQUENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PRN_FREQUENCY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_PRN_FREQUENCY_TYPE"
	type = "NUMBER(5,0)"
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

