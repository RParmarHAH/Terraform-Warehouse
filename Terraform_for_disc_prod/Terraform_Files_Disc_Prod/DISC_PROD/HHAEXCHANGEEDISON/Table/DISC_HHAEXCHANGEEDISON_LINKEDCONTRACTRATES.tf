resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_LINKEDCONTRACTRATES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "LINKEDCONTRACTRATES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.LINKEDCONTRACTRATES

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

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
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "VENDORRATEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FROMDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TODATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "SERVICECATEGORY"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICETYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RATEAMOUNT"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "RATETYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ALLOWPROVIDEREDITBILLINGRATES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UNITS"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "MINHR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISNONBILLABLE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISEXPANDCOLLAPSVISIBLE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
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

