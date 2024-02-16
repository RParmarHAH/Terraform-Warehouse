resource "snowflake_table" "DISC_ASR_ASR_PAYMENTSRECEIVED" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_PAYMENTSRECEIVED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_PAYMENTSRECEIVED

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PAYMENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAIDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REIMBAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIMSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNTRANID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGTRANSACTIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPOSITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIMNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENTPOS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENTNEG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEVISITACTUALID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENTSMEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGMEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEVISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERSOURCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGCODEID"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

