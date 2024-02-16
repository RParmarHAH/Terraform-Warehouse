resource "snowflake_table" "DISC_HSX_HIST_HSX_NOTIFICATION_SUMMARY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HSX"
	name = "HIST_HSX_NOTIFICATION_SUMMARY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HSX.HIST_HSX_NOTIFICATION_SUMMARY

    -- Purpose : Discovery Data Population

    -- Project : HSX

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DEST_FACILITY"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "DEST_PRACTICE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PCP"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DEST_MRN"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SRC_FACILITY"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "SRC_MRN"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "GENDER"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BIRTH_DT"
	type = "DATE"
	nullable = false
}


column {
	name = "ADDRESS"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PRIMARY_PHONE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SRC_SETTING"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "EVENT_TYPE"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "ADMIT_DT"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ADMIT_TIME"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ADMIT_RSN"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ADMIT_TYPE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REFERRAL_INFO"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "DISCHARGE_DT"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DISCHARGE_TIME"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DEATH_IND"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DIAG_CD"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "DIAG_DESC"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "DISCHARGE_DISP"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "ATTENDING_DR"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "INSURANCE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SRC_FILENAME"
	type = "VARCHAR(256)"
	nullable = false
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(10,0)"
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

