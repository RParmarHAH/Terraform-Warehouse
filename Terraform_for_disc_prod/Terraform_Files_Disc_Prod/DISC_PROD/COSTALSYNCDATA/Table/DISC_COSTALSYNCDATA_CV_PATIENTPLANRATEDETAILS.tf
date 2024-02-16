resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_PATIENTPLANRATEDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_PATIENTPLANRATEDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_PATIENTPLANRATEDETAILS

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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PROCCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PLAN_PROCEDURE_CODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PLAN_PROC_DESCRIPTION"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "CHARGE_AMOUNT82"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "APPROVED_AMOUNT82"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "USE_APPROVED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CHARGE_ADJUSTMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYMENT_AMOUNT82"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PPR_PAYMENT_METHOD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PRINT_APP_AMT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_CERT_REQUIRED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "FILLER_67"
	type = "VARCHAR(67)"
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
	name = "CRLF"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DDL_CHARGE_AMOUNT_SOURCE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_APPROVED_AMT_SOURCE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "APPROVED_AMOUNT_DISCOUNT"
	type = "NUMBER(19,5)"
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

