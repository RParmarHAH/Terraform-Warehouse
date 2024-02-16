resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_PHYSICIANORDERTYPES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_PHYSICIANORDERTYPES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_PHYSICIANORDERTYPES

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
	nullable = true
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ORDER_TYPE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ORDER_TYPE_DESCRIPTION"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "DDL_ORDER_TYPE_GROUP"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_QUANTITY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "FILLER_182"
	type = "VARCHAR(183)"
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
	name = "CB_RFB"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_DOSE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_ROUTE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_FREQUENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_VISIT_FREQUENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INSTRUCTION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INSERT_ORDER_DESC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INSERT_DOSE_DESC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INSERT_ROUTE_DESC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INSERT_FREQUENCY_DESC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INSERT_VISIT_FREQUENC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INSERT_INSTRUCTION_DE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_REFERRAL_OUT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_PROCEDURE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_DISCIPLINE_FREQUENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CP_NOTE_TYPE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "REFERRAL_TYPE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DISPLAY_SEQUENCE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_ORDER_PRINT_OPTION"
	type = "NUMBER(5,0)"
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

