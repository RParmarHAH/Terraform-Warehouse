resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_ACTIVITYENTITIES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_ACTIVITYENTITIES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_ACTIVITYENTITIES

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
	name = "ACTENT_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ACTENT_RECORDTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ACTENT_RECORDID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ACTENT_ACTIVITIESID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ACTENT_NOTIFY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTENT_PRINT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTENT_DISMISS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTENT_REMINDERDISMISSEDBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTENT_REMINDERDISMISSDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTENT_FOLLOWUPDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTENT_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTENT_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTENT_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTENT_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTENT_TS"
	type = "VARCHAR(100)"
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

