resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_PATIENTPLANCOPAYS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_PATIENTPLANCOPAYS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_PATIENTPLANCOPAYS

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
	type = "VARCHAR(25)"
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
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = false
}


column {
	name = "STATRT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "END__DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CO_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DATE_ENTERED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PREVIOUS_COPAY_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DDL_COPAY_TRANSFER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_RATE_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_PRO_RATE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_RETRO_CALCULATION_ME"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_USE_DETAIL_PROCEDURE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_CHANGE_OPTION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_RETRO_BILLING"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_RETRO_CHANGE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RETRO_COMPLETED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROCCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "RETRO_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CB_INCL_MEDA_CO_INS_DAYS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_ADJUST_COPAY_DAILY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PL_PAY_SOURCE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PL_PLAN"
	type = "VARCHAR(7)"
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

