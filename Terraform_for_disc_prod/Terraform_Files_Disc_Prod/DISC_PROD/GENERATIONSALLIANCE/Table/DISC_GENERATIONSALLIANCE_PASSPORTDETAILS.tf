resource "snowflake_table" "DISC_GENERATIONSALLIANCE_PASSPORTDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "PASSPORTDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.PASSPORTDETAILS

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
	name = "PASSID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "INVOICEDETAILID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "BILLABLEDETAILID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "INVOICEID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "UNITSBILLED"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "AMOUNTBILLED"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "COSTPERUNIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVOICEDETAILCOMMENTS"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "SERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
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

