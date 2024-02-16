resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_BILLINGCHECKS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "BILLINGCHECKS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.BILLINGCHECKS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

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
	name = "CHECKID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PAYERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEPOSITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHECKAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "APPLIEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "REMIANINGAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYMENTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "APPLYFROMCREDITAMOUNT"
	type = "NUMBER(38,2)"
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

