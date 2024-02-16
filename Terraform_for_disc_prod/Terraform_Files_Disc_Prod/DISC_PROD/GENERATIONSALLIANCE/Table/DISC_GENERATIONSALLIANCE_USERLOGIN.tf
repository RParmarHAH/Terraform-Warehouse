resource "snowflake_table" "DISC_GENERATIONSALLIANCE_USERLOGIN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "USERLOGIN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.USERLOGIN

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
	name = "USERLOGINID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "AGENCYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USERID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ROLEID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARENTTOKEN"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "REMOTEHOSTADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SESSIONSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SESSIONEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACCESSED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LOGGEDOUT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISQBSYNC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISMOBILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "APPVERSION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ISFORCEDLOGOUT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADMINNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "APPREGID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ISCONCURRENTLOGIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOGGEDOUTSOURCE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "DEVICEDETAILS"
	type = "VARCHAR(300)"
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

