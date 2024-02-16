resource "snowflake_table" "DISC_CCSI_FMLA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "FMLA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.FMLA

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BEGIN_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CALENDAR_DAYS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEDICAL_CERTIFICATION_RECEIVED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEDICAL_CERTIFICATION_DUE_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NOTES_1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTES_2"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTES_3"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTES_4"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTES_5"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTES_6"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTES_7"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "STD_INSURANCE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RETURNED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLOSED_FIELD"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ISSUES"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRELIMS_DONE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TERMINATION_LETTER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EXPECTED_TO_RETURN"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LAST_PAY_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OPTIONAL_INSURANCE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DENTAL"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "VISION"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "CANCER"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "ACCIDENT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "INS_LETTER_SENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HEALTH_INS"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "MONTHLY_TOTAL"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "DUE_1"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PAID_1"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "DATE_PAID_1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DUE_2"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PAID_2"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "DATE_PAID_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DUE_3"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PAID_3"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "DATE_PAID_3"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ATTENDANCE_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ATTENDANCE_FLAG"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PERIOD_1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PERIOD_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PERIOD_3"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PERIOD_4"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PERIOD_5"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BALANCE_1"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "BALANCE_2"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "BALANCE_3"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "BALANCE_4"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "BALANCE_5"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "DUE_4"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "DUE_5"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "DATE_4"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DATE_5"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TOTAL_OUTSTANDING"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PAID_4"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PAID_5"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "EMP_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OPTIONAL_INS_YORN"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "LEAVE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CERT_RECEIVED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LAST_PUNCH_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LAST_UPDATED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED2_BY"
	type = "VARCHAR(100)"
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
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

