resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_TRAVELTIMETRIPHEADER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "TRAVELTIMETRIPHEADER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.TRAVELTIMETRIPHEADER

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

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
	name = "TRAVELTIMEBATCHID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "BATCHNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BATCHSTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TRAVELRECORDSCALCULATED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMECREATED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMENOTCREATED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCHPROCESSEDDATEUTC"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BATCHPROCESSEDBY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "USERID"
	type = "NUMBER(10,0)"
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

