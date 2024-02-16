resource "snowflake_table" "DISC_GPSYNCDATA_HIST_EMPLOYER_EDGE_PAYCODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_EMPLOYER_EDGE_PAYCODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_EMPLOYER_EDGE_PAYCODES

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANY_CODE"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "TYPE_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IN_USE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COUNT_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISHOMECARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISSKILLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISDD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATE"
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

