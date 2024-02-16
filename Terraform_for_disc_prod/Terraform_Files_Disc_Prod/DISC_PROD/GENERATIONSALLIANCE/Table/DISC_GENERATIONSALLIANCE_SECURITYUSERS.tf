resource "snowflake_table" "DISC_GENERATIONSALLIANCE_SECURITYUSERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "SECURITYUSERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.SECURITYUSERS

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
	name = "USERNAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "USERPASSWORD"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STR_EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BIT_ALLCLASS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ALLLOCATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USERREFERENCEID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "INCORRECTATTEMPTS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "LASTFAILEDATTEMPT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PASSWORDRESETTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USERLANGUAGE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SANTRAXNOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "APPREGID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "HHAXNOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_MISSEDVISITNOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPASSWORDSTRONG"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TOUCHIDTOKEN"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISABLEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISABLEDREASON"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "DISABLEDDUETOPASSWORDATTEMPTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISMISSEDVISITAPPNOTIFICATIONENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISMISSEDVISITTEXTMESSAGEENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISMISSEDVISITEMAILENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SENDCGLOGINLOGOUTAPPNOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FORCEPASSWORDCHANGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USESENHANCEDPASSWORDHASH"
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

