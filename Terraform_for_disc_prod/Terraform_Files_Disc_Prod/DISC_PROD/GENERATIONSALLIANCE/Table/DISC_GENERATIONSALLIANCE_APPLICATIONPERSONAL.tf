resource "snowflake_table" "DISC_GENERATIONSALLIANCE_APPLICATIONPERSONAL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "APPLICATIONPERSONAL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.APPLICATIONPERSONAL

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
	name = "APPID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKPHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "CELLPHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATTHISADDRESS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COVICTEDCRIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NATUREOFCONVICTION"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "LIKEMOST"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "LIKELEAST"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "ECNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ECPHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "ECALTPHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "ECRELATIONSHIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ECADDRESS"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ECCITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ECSTATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ECZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MIDDLEINIT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CELLPHONEPROVIDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "POSTIONAPPLYINGFOR"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SIGNATUREDATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TEXTMESSAGE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFERREDBYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTHERREFERREDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SSNSTRONG"
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

