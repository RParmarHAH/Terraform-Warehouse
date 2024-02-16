resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_MEDICATIONTABLES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_MEDICATIONTABLES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_MEDICATIONTABLES

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
	name = "MEDICATION_CODE"
	type = "VARCHAR(31)"
	nullable = false
}


column {
	name = "MEDICATION_DESCRIPTION"
	type = "VARCHAR(101)"
	nullable = true
}


column {
	name = "MEDICATION_DOSE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "ROUTE_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "MEDICATION_FREQUENCY"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "FORM"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "MEDICATION_CATEGORY"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "MEDICATION_NDC_NUMBER"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "COST"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "ORDER_TYPE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FIRM_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DDL_RXOTC"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FDB_MED_STATUS_CD"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FDB_MED_STREN"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FDB_MED_STREN_UOM"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FDB_GCN_SEQNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FDB_GTC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DDL_SRC"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_SQL_UPGRADE_01"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "FDB_MEDID"
	type = "NUMBER(10,0)"
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

