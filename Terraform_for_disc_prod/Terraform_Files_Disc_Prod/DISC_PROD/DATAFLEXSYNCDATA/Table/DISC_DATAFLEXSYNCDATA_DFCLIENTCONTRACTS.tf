resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_DFCLIENTCONTRACTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DFCLIENTCONTRACTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTCONTRACTS

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
	name = "AUTHSTATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AUTHTYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "IDNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKLYMAXHOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "MONTHLYMAXHOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "PAYORSOURCE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BILLCODESVALUES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATIONVALUES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "SERVICEAREA"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "OLDAUTHORIZEDHOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "CASENUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CASEWORKERMANAGER"
	type = "VARCHAR(50)"
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
	name = "DATEADDED"
	type = "DATE"
	nullable = true
}


column {
	name = "DATECHANGED"
	type = "DATE"
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

