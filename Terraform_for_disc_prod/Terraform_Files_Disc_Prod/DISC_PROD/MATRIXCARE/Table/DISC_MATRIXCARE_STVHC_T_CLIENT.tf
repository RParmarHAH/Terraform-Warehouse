resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_CLIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_CLIENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_CLIENT

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLI_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLI_TYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_MIDDLENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_STATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLI_ADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLI_ADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CLI_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_STATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLI_POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLI_COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_COUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLI_PHONETYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_RACEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_MARITALSTATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLI_TRAVEL_DIRECTIONS"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "CLI_EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_EMAIL2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CLI_BIRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLI_SEX"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLI_SUFFIX"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLI_DISASTERPLANCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLI_DISASTERPLANNOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLI_TELEPHONYID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "CLI_AUTHCHECK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_DEFAULTSERVICECODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_MASTSCHEDWEEKCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLI_MAIL_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLI_NOKNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_NOKPHONE1"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLI_NOKPHONE2"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLI_NOKRELATION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLI_HEPATIENTLIVESWITH"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_HEPETSINHOME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_HESMOKERSINHOME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_LPADVANCEDIRECTIVES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_LPLOCATIONOF"
	type = "VARCHAR(400)"
	nullable = true
}


column {
	name = "CLI_LPCOPYREQUESTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_LPLIVINGWILL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_LPCOPYOBTAINED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_LPHCSURROGATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_ACIHNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_ACIHGREETING"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_ACIHRELATION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLI_ACIHBIRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLI_REQUIRESORIENTATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLI_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLI_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLI_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_LEGACYBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_OASISINTERFACEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLI_SSN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLI_CALCUNIQUESSN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLI_UPLOADTELEPHONY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_ALLOWMASSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_INQUIRYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLI_SALUT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLI_POLST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_TELEPHONYALLOWCAREGIVERPHONE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLI_DISPLAYONCAREGIVERPORTAL"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CLI_HIC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLI_INVCPRINTLINE"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CLI_BILLINGOTCALCTYPE"
	type = "NUMBER(3,0)"
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
	name = "CLI_NICKNAME"
	type = "VARCHAR(32)"
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

