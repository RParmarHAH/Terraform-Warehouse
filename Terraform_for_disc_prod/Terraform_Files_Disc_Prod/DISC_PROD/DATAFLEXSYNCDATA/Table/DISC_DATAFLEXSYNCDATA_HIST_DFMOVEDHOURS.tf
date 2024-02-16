resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_HIST_DFMOVEDHOURS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "HIST_DFMOVEDHOURS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.HIST_DFMOVEDHOURS

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
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "REFERENCENO"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OLDCONTRACT"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "NEWCONTRACT"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PERIOD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOURSMOVED"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "CHANGEDBY"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CHANGEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUDITNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLHOURSMOVED"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "BILLAMOUNTMOVED"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "CLIENTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WRITEOFF"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "TOBERECOUPED"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "OFFICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PREVWRITEOFF"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "RECOUPED"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "RECOUPWRITEOFF"
	type = "NUMBER(10,2)"
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

