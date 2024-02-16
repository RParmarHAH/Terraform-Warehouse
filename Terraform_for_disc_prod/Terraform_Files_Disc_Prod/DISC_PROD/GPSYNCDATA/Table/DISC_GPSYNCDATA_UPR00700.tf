resource "snowflake_table" "DISC_GPSYNCDATA_UPR00700" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "UPR00700"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.UPR00700

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
	name = "ADNLALOW"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ADSTWHDG"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEPNDNTS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ESTDEDAL"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ESTSTWHD"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "EXFBLSPS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXFORO65"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXFSPO65"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXMFBLND"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXMFRSLF"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXMFRSPS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXMFSPAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXMTAMNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "INACTIVE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NOTEINDX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PRSNEXPT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "STATECD"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TXFLGSTS"
	type = "VARCHAR(7)"
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

