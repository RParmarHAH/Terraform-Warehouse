resource "snowflake_table" "DISC_GPSYNCDATA_HIST_UPR00300" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_UPR00300"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_UPR00300

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ADFDWHDG"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEPENDENTCLAIMAMT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EICFLGST"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "EMPLOYID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ESTFEDWH"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "EXMFRFED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "FDFLGSTS"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "FEDEXMPT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "LOCALTAX"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "MARRIEDWITHHOLDASSINGLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "MCRQGEMP"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NOTEINDX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NYTXDIFF"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "QUALIFIEDHIRE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STATECD"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "W2BF942E"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "W2BFDCMP"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "W2BFDCSD"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "W2BFLREP"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "W2BFPPLN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "W2BFSTEM"
	type = "NUMBER(3,0)"
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

