resource "snowflake_table" "DISC_GENERATIONSALLIANCE_APPNOTIFICATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "APPNOTIFICATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.APPNOTIFICATION

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "APPNOTIFICATIONID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "USERTYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "USERID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "APPREGID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SUBJECT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BODY"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "SENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOTIFICATIONTYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NOTIFICATIONSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ERROR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RESOLVED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FROMADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USEREMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MODULENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INT_SCHEDULEID"
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

