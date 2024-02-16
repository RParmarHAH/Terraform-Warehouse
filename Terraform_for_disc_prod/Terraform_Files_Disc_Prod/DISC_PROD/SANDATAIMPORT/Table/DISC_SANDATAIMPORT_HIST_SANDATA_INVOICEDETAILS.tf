resource "snowflake_table" "DISC_SANDATAIMPORT_HIST_SANDATA_INVOICEDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "HIST_SANDATA_INVOICEDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.HIST_SANDATA_INVOICEDETAILS

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
	name = "INVOICELINEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICEID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUSID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "DATEFROM"
	type = "DATE"
	nullable = true
}


column {
	name = "DATETHRU"
	type = "DATE"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNITTYPEID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "REVCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HCPCS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "POS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TOS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MODIFIERS"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "REFNO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NETAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "REASONCODES"
	type = "VARCHAR(250)"
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

