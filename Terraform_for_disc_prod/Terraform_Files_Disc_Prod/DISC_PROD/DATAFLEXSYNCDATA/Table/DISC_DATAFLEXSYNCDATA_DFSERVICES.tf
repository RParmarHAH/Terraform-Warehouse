resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_DFSERVICES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DFSERVICES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.DFSERVICES

    -- Purpose : Discovery Data Population

    -- Project : DATAFLEXSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DBNAME"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "AREA"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CONTRACTNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "FEINNUMBER"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "VENDORAGREENO"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BATCH_TOTALS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "CCUAGREENO"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DORSHSPCNUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CCUCONTRACT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BATCHCLIENTS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISTRICT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "IDOAFLAG"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(75)"
	nullable = true
}


column {
	name = "GAURNAME"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "GAURCONTACT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GAURADDRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GAURCITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GAURSTATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "GAURZIP"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CASEMGRID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEBATCH"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "UPDATEDTIME"
	type = "TIMESTAMP_NTZ(9)"
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

