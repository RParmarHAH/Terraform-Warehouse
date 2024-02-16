resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_QUALTRICS_DIRECTORY_CONTACTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "QUALTRICS_DIRECTORY_CONTACTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_DIRECTORY_CONTACTS

    -- Purpose : Discovery Data Population

    -- Project : QUALTRICS_SURVEYS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CONTACTID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EXTREF"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LANGUAGE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNSUBSCRIBED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMBEDDEDDATA"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

