resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CAREBRIDGELOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CAREBRIDGELOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CAREBRIDGELOG

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
	name = "LOGID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "LOGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ERRORS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOGFILENAME"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "EXPORTEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPORTEDON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REQUESTDATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPOINTMENTSTATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "HASERRORS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLEDUNITS"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "CLAIM1STATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLAIM1INVOICENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIM1PAYERCLAIMNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIM1STATUSDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLAIM1DATELASTCHECKED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLAIM1PAYERSTATUSCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIM1PAYERSTATUSDESCRIPTION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLAIM2STATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLAIM2INVOICENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIM2PAYERCLAIMNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIM2STATUSDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLAIM2DATELASTCHECKED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLAIM2PAYERSTATUSCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIM2PAYERSTATUSDESCRIPTION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TRANSACTIONID"
	type = "VARCHAR(40)"
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

