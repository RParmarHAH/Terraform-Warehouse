resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_DISCIPLINEFREQUENCIES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_DISCIPLINEFREQUENCIES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_DISCIPLINEFREQUENCIES

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
	name = "SEQUENCE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DISCIPLINE_SEQUENCE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LINE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FREQUENCY_UNITS_ARR2_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FREQUENCY_UNITS_ARR2_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FREQUENCY_INT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_UNITS_FREQ_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "LENGTHVALUE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_VISITS_DURATION_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FORMAT"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "ORDER_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "FREQUENCY_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CB_DISCREPANCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_REQUIREMENT_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TREATMENT_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TREATMENT_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCIPLINE_ORDER_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "DISCHARGE_REASON_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "REASON_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WEEKLY_DAYS_ARRAY7_1"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WEEKLY_DAYS_ARRAY7_2"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WEEKLY_DAYS_ARRAY7_3"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WEEKLY_DAYS_ARRAY7_4"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WEEKLY_DAYS_ARRAY7_5"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WEEKLY_DAYS_ARRAY7_6"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WEEKLY_DAYS_ARRAY7_7"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PHYSICIAN_ORDER_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CERT_TRAN_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CB_ORIGINAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NURSE_ID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "ACTUAL_FREQUENCY_END_DT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME1_ARRAY_1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME1_ARRAY_2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME1_ARRAY_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME1_ARRAY_4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME1_ARRAY_5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME1_ARRAY_6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME1_ARRAY_7"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME1_ARRAY_1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME1_ARRAY_2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME1_ARRAY_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME1_ARRAY_4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME1_ARRAY_5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME1_ARRAY_6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME1_ARRAY_7"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME2_ARRAY_1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME2_ARRAY_2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME2_ARRAY_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME2_ARRAY_4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME2_ARRAY_5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME2_ARRAY_6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME2_ARRAY_7"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME2_ARRAY_1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME2_ARRAY_2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME2_ARRAY_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME2_ARRAY_4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME2_ARRAY_5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME2_ARRAY_6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME2_ARRAY_7"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME3_ARRAY_1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME3_ARRAY_2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME3_ARRAY_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME3_ARRAY_4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME3_ARRAY_5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME3_ARRAY_6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_START_TIME3_ARRAY_7"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME3_ARRAY_1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME3_ARRAY_2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME3_ARRAY_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME3_ARRAY_4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME3_ARRAY_5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME3_ARRAY_6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FREQ_END_TIME3_ARRAY_7"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NUMBER_ARRAY_1"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBER_ARRAY_2"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBER_ARRAY_3"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBER_ARRAY_4"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBER_ARRAY_5"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBER_ARRAY_6"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBER_ARRAY_7"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY1_ARR7_1"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY1_ARR7_2"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY1_ARR7_3"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY1_ARR7_4"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY1_ARR7_5"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY1_ARR7_6"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY1_ARR7_7"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY2_ARR7_1"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY2_ARR7_2"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY2_ARR7_3"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY2_ARR7_4"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY2_ARR7_5"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY2_ARR7_6"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY2_ARR7_7"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY3_ARR7_1"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY3_ARR7_2"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY3_ARR7_3"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY3_ARR7_4"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY3_ARR7_5"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY3_ARR7_6"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY3_ARR7_7"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "NURSE_ID1_ARR7_1"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID1_ARR7_2"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID1_ARR7_3"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID1_ARR7_4"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID1_ARR7_5"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID1_ARR7_6"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID1_ARR7_7"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID2_ARR7_1"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID2_ARR7_2"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID2_ARR7_3"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID2_ARR7_4"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID2_ARR7_5"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID2_ARR7_6"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID2_ARR7_7"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID3_ARR7_1"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID3_ARR7_2"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID3_ARR7_3"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID3_ARR7_4"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID3_ARR7_5"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID3_ARR7_6"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NURSE_ID3_ARR7_7"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "RB_PATTERN_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY_2"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PATIENT_PLAN"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_POC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_DISCONTINUE"
	type = "NUMBER(3,0)"
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

