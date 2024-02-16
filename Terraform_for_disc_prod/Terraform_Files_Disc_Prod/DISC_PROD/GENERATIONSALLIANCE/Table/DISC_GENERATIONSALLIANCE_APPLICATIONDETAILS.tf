resource "snowflake_table" "DISC_GENERATIONSALLIANCE_APPLICATIONDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "APPLICATIONDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.APPLICATIONDETAILS

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
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "APPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HAVECAR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NOCAROPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DRIVINGLISCENSE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LICENSEEXPIRATION"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "WEEKLYWORKINGHOURS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WORKATNIGHT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WORKATWEEKENDS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WILLINGLIVEIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYMENTDESIRED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LEGALLYAUTHORIZED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AVAILIABLESTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMENOTWORKING"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CERTIFICATIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANIONSHIP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DRESSING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEALPREPARATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRANSFERRING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOUSEKEEPING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCONTINENCECARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATHING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEMENTIA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDITIONALSKILLS"
	type = "VARCHAR(300)"
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
	name = "CLASSNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EO_DISCLAIMERS"
	type = "VARCHAR(1000)"
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

