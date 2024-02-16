resource "snowflake_table" "DISC_EMPEONEDISON_EDEP" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "EDEP"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.EDEP

    -- Purpose : Discovery Data Population

    -- Project : EMPEONEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DEPENDENTID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TELEPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RELATIONSHIP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SEX"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SMOKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "GUIDFIELD"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEMOFRECORD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SYSTEMOFRECORDIDENTIFIER"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "DISABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STUDENT"
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

