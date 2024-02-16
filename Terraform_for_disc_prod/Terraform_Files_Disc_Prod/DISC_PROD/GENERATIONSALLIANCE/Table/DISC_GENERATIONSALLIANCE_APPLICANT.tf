resource "snowflake_table" "DISC_GENERATIONSALLIANCE_APPLICANT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "APPLICANT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.APPLICANT

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
	name = "SOCIALSECURITYNUM"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MIDDLEINIT"
	type = "VARCHAR(1)"
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
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "VALIDDRIVERSLICENSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SMOKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEIGHTRESTRICTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEIGHTLIMIT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CLASSIFICATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STATUSDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INACTIVEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "QUICKBOOKSID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CERTEXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFICATION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYOVERTIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEQBTSHEETS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PHONE1"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "BACKGROUNDCHECK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLASSNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INDEPENDENTCONTRACTOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELEPHONYID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DONOTREHIRE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INT_STATUSID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STR_REASON"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PAYCHEXID"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STR_GENDER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MESSAGEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TEXTMESSAGE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UNKNOWNSSN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COUNTYID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "STATELICENSENO"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ONLINEAPPLICATIONNO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "NUMBER(18,12)"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "NUMBER(18,12)"
	nullable = true
}


column {
	name = "GEOCODEUPDATESTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "GEOCODELASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GEOCODEUPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "APPLICATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "CELLPHONEPROVIDER"
	type = "VARCHAR(250)"
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

