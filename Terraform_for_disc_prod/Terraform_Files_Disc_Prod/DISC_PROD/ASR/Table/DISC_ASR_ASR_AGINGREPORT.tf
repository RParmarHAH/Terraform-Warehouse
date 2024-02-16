resource "snowflake_table" "DISC_ASR_ASR_AGINGREPORT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_AGINGREPORT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_AGINGREPORT

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
	name = "INVOICE_NO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEGMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_SERVICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICE_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECEIVED_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENT_POSITIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENT_NEGATIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BALANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "31-60"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "61-90"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "91-120"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "120+"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERSOURCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAIDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGCODEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPOSITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEVISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEVISITACTUALID"
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

