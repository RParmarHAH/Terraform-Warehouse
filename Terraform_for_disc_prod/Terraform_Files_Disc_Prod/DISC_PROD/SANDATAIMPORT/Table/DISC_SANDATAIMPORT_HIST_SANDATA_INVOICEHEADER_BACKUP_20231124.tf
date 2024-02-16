resource "snowflake_table" "DISC_SANDATAIMPORT_HIST_SANDATA_INVOICEHEADER_BACKUP_20231124" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "HIST_SANDATA_INVOICEHEADER_BACKUP_20231124"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.HIST_SANDATA_INVOICEHEADER_BACKUP_20231124

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
	name = "INVOICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PERIODID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTHORIZATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUSID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "STATUSCHANGEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "INVOICEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DATEFROM"
	type = "DATE"
	nullable = true
}


column {
	name = "DATETO"
	type = "DATE"
	nullable = true
}


column {
	name = "REFERENCENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINALAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ADJUSTEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BALANCE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "CSCODE"
	type = "VARCHAR(2)"
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

