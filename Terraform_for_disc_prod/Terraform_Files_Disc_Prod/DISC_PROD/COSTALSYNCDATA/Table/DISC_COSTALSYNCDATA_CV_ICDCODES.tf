resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_ICDCODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_ICDCODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_ICDCODES

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
	name = "ICD_CODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "ICD_CODE_DESCRIPTION"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "DIAGCATG"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FILLER_51"
	type = "VARCHAR(51)"
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
	name = "DDL_DIAGNOSIS_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INACTIVATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DDL_ICD_TYPE"
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

