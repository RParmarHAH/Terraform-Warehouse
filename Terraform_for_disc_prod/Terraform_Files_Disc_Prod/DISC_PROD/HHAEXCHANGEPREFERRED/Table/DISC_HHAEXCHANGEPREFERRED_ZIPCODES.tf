resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_ZIPCODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "ZIPCODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.ZIPCODES

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ZIP"
	type = "FLOAT"
	nullable = true
}


column {
	name = "F2"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DECOMMISSIONED"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PRIMARY_CITY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ACCEPTABLE_CITIES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "UNACCEPTABLE_CITIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AREA_CODES"
	type = "FLOAT"
	nullable = true
}


column {
	name = "WORLD_REGION"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "IRS_ESTIMATED_POPULATION_2015"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EMAILS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COUNTYNAME"
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

