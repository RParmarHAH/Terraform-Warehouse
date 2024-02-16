resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_ACTIVITYCATEGORIES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_ACTIVITYCATEGORIES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_ACTIVITYCATEGORIES

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ACTCAT_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTCAT_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTCAT_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTCAT_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTCAT_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTCAT_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTCAT_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACTCAT_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTCAT_LISTITEMTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ACTCAT_RPTGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTCAT_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTCAT_OVERRIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTCAT_DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ACTCAT_DISPLAYONCALENDAR"
	type = "BOOLEAN"
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

