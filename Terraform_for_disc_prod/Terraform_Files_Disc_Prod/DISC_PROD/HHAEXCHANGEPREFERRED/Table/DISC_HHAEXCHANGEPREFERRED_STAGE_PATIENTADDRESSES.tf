resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_STAGE_PATIENTADDRESSES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "STAGE_PATIENTADDRESSES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTADDRESSES

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
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTADDRESSID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADDRESSLINE1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ADDRESSLINE2"
	type = "VARCHAR(55)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CROSSSTREET"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIMARYADDRESS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ADDRESSTYPES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "NUMBER(9,6)"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "NUMBER(9,6)"
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

