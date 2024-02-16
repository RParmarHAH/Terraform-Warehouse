resource "snowflake_table" "DISC_GPSYNCDATA_UPR40301" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "UPR40301"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.UPR40301

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
	name = "CHANGEBY_I"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CHANGEDATE_I"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DSCRIPTN"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EEOCLASS_I"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FLSASTATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "JOBTITLE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "NOTEINDX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NOTEINDX2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "REPORTSTOPOS"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "REVIEWSETUPCODE_I"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "SKILLSETNUMBER_I"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TXTFIELD"
	type = "VARCHAR(50)"
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

