resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_ADMISSIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_ADMISSIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_ADMISSIONS

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
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "ADMISSION_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "ADMIT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADMIT_HOUR"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VERBAL_SOC_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADMISSION_TYPE_CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADMISSION_SOURCE_CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADMITTED_FROM_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PRIMARY_PHYSICIAN"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "NURSE_ID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BILL_CLASSIFICATION_CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADMIT_DIAGNOSIS3_1"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DIAGNOSIS9_1"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DIAGNOSIS9_2"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DIAGNOSIS9_3"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DISCHARGE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DISCHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCHARGE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEPARTMENT__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PRIMARY_PLAN"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "REFERRING_SOURCE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "DRG_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "BILLTO_STATUS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ICD_CODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CURRENT_BILLTO_STAT_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CURRENT_PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "ROOM_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BED_NUMBER"
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

