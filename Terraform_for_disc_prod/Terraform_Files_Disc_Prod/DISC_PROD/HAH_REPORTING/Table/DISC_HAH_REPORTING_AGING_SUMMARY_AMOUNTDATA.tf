resource "snowflake_table" "DISC_HAH_REPORTING_AGING_SUMMARY_AMOUNTDATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAH_REPORTING"
	name = "AGING_SUMMARY_AMOUNTDATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HAH_REPORTING.AGING_SUMMARY_AMOUNTDATA

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
	name = "LINEID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "DFDB"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "DATATYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMOUNTTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PERIOD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDITIONALITEMNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDITIONALITEM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREDITAPPLYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIODDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "CREDITAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "KEYHASH"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "KEYVALUE"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "SERVICEAREA"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "INVOICEBATCH"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTBILLOFFICE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "MOVEDTOCONTRACT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "IDOARECOUP"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "REGIONCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "REJECTIONCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WOREASON"
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

