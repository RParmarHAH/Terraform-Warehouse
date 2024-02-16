resource "snowflake_table" "DISC_DEVERO_DEVERO_BILLPAYMENTLIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_BILLPAYMENTLIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_BILLPAYMENTLIST

    -- Purpose : Discovery Data Population

    -- Project : DEVERO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCESSED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REMITNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DCN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORIGIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
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

