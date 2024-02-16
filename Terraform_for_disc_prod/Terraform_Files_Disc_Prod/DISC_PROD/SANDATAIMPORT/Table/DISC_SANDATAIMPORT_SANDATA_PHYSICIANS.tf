resource "snowflake_table" "DISC_SANDATAIMPORT_SANDATA_PHYSICIANS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "SANDATA_PHYSICIANS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.SANDATA_PHYSICIANS

    -- Purpose : Discovery Data Population

    -- Project : SANDATAIMPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PHYSICIANID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PERSON"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "MIDDLEINITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUFFIX"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "SEX"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "DOD"
	type = "DATE"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "APTNO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WORKPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MOBILEPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORGANIZATION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "API"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "UPIN"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTHERID1"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "OTHERID2"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LICENSENUMBER"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LICENSEEXPIRES"
	type = "DATE"
	nullable = true
}


column {
	name = "CREATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HASHEDROWVALUES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BATCHID"
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

