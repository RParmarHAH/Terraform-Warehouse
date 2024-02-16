resource "snowflake_table" "DISC_SANDATAIMPORT_SANDATA_OVERNIGHT_VISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "SANDATA_OVERNIGHT_VISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.SANDATA_OVERNIGHT_VISITS

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
	name = "KEY_1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SEDID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CUST_NUM"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CHART_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MEDICAID_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "KEY_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HHAX_VISIT_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ADMIT_TYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYOR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PLAN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAREGIVER_STAFF"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CAREGIVER_FIRST_LAST"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COORDINATOR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NOTOKTOBILLREASONS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SERVICE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "IN_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OUT_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "QTY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "UNITS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AMT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COPAY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUPPLIES"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(50)"
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

