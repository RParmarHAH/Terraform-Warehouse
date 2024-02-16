resource "snowflake_table" "DISC_SANDATAIMPORT_HIST_SANDATA_PAYORS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "HIST_SANDATA_PAYORS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.HIST_SANDATA_PAYORS

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
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
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
	name = "BILLMETHOD"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRANSPORT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ISAUTHREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEEKENDING"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "USESEVV"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SANTRAXACCT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HASHEDROWVALUES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BATCHID"
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

