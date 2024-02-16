resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_REPORTGROUPTYPES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_REPORTGROUPTYPES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_REPORTGROUPTYPES

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RPTGRPTYP_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RPTGRPTYP_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RPTGRPTYP_DESCRIPTION"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "RPTGRPTYP_TYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RPTGRPTYP_ENUMNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RPTGRPTYP_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RPTGRPTYP_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RPTGRPTYP_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RPTGRPTYP_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RPTGRPTYP_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RPTGRP_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RPTGRPTYP_DDMAINTENANCE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RPTGRPTYP_TABLENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RPTGRPTYP_TABLEABBREVIATION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
	type = "BOOLEAN"
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

