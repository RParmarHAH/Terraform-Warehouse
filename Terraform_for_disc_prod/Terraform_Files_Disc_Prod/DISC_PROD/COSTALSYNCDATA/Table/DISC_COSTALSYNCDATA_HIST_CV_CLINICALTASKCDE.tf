resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_CLINICALTASKCDE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_CLINICALTASKCDE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_CLINICALTASKCDE

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
	name = "CLINICAL_TASK_CODE"
	type = "VARCHAR(11)"
	nullable = false
}


column {
	name = "CLINICAL_TASK_DESC"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "DISCIPLINE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CLINICAL_TASK_CTG_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FREQUENCY_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "TIME_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "DDL_SCORING_OPTION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCORE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ESTIMATED_TIME"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PROCCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CB_LOCK_TIME_SCORE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_COPY_AIDE_CARE_PLAN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_REQUIRE_COMMENT_NO"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_APC_TASK"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLINICAL_TASK_NOTE"
	type = "VARCHAR(4096)"
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

