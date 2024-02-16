resource "snowflake_table" "DISC_GENERATIONSALLIANCE_SERVICEINQUIRY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "SERVICEINQUIRY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.SERVICEINQUIRY

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
	name = "INQNO"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
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
	name = "EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALTERNATEPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HEARDTHROUGH"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RELATIONSHIP"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RECEPIENTCITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RECEPIENTSTATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RECEPIENTZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "RECEPIENTLOCATION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASSISTANCENEEDED"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RECEPTIVENESS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HELPWITHIN"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SUBMITTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IMPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIDDEN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BESTTTC"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RECEIPIENTFIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "RECEIPIENTLASTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LOCATION"
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

