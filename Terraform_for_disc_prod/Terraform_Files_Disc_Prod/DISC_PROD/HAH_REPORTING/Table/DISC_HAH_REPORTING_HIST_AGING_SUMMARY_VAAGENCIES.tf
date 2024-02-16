resource "snowflake_table" "DISC_HAH_REPORTING_HIST_AGING_SUMMARY_VAAGENCIES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAH_REPORTING"
	name = "HIST_AGING_SUMMARY_VAAGENCIES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HAH_REPORTING.HIST_AGING_SUMMARY_VAAGENCIES

    -- Purpose : Discovery Data Population

    -- Project : HAH_REPORTING

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "NAME"
	type = "VARCHAR(200)"
	nullable = false
}


column {
	name = "ADDRESSLINE1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESSLINE2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESSLINE3"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESSLINE4"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESSLINE5"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESSLINE6"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXTRAKEYWORDS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DFSTATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AGENCYTYPE"
	type = "VARCHAR(10)"
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

