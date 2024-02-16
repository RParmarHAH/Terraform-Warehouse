resource "snowflake_table" "DW_STAGE_DATAFLEXSYNCDATA_DIM_DERIVED_AUTH_FROM_HISTORY_WITH_MASTER_DEDUP" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "DATAFLEXSYNCDATA_DIM_DERIVED_AUTH_FROM_HISTORY_WITH_MASTER_DEDUP"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.DATAFLEXSYNCDATA_DIM_DERIVED_AUTH_FROM_HISTORY_WITH_MASTER_DEDUP

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "MASTER_MAXRN"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "MASTER_RN"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "MASTER_CLIENT_NUMBER"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "MAXRN"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "RN"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "DBNAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUTHTYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BEGINSERVICEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ENDSERVICEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MONTHLYMAXHOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "WEEKLYMAXHOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "DATECHANGED"
	type = "DATE"
	nullable = true
}


column {
	name = "MODIFIED_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MODIFIED_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AUTHDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MASTER_MODIFIED_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MASTER_MODIFIED_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MASTER_AUTHDAYS"
	type = "NUMBER(10,0)"
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

