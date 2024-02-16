resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_MDLICCDE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_MDLICCDE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_MDLICCDE

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
	name = "LICENSE_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "LICENSE_CODE_DESC"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "TERM"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_TERM_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "REMARK_40"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "CB_LICENSE_REQ_BY_SERV_C"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NOTIFY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "LICENSE_REQUIRED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DAYS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_LICENSE_REQ_BY_PROC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "LICENSE_TYPE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DDL_LICENSE_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "IN_SERVICE_HRS_REQUIRED"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PRECEPT_HRS_REQUIRED"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CB_LICENSE_MULTI_STATE"
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

