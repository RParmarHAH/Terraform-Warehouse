resource "snowflake_table" "DW_PUBLIC_CROSSWALK_EXTERNAL_UPDATES_TRACKING_HOURLY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "CROSSWALK_EXTERNAL_UPDATES_TRACKING_HOURLY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.CROSSWALK_EXTERNAL_UPDATES_TRACKING_HOURLY

    -- Purpose : 

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ENTERPRISE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMS_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMS_SYSTEM_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "AMS_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORKDAY_INTERNAL_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OLD_VALUES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

