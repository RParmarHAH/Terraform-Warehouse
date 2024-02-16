resource "snowflake_table" "DISC_GPSYNCDATA_HIST_DD00200" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_DD00200"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_DD00200

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
	name = "DDACTNUM"
	type = "VARCHAR(17)"
	nullable = true
}


column {
	name = "DDAMTDLR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DDPCT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDPRE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDPRECNT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDTRANS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DDTRANUM"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DEDNMTHD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DEDUCTON"
	type = "VARCHAR(7)"
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
	name = "INACTIVE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INDXLONG"
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

