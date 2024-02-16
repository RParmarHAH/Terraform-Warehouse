resource "snowflake_table" "DISC_CCSI_OTHERINV" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "OTHERINV"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.OTHERINV

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILLING_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "DATE_OF_SERVICE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TYPE_OF_SERVICE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AMOUNT_BILLED"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RESPONSIBLE_PARTY"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "DATE_PAID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CHECK_NUMBER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AMOUNT_PAID"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "BALANCE_DUE"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "UNITS_PROVIDED"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "DESK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_DATE1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_BY1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_BY1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "OLD_SSN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AREA"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPLOADED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHECK1"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "AMOUNT1"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "PAYMENT_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHECK2"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AMOUNT2"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "DATE_PAID2"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHECK3"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AMOUNT3"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "DATE_PAID3"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BALANCE"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(200)"
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
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

