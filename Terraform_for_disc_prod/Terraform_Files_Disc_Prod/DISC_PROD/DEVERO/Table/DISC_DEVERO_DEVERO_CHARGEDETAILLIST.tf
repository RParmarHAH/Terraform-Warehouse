resource "snowflake_table" "DISC_DEVERO_DEVERO_CHARGEDETAILLIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_CHARGEDETAILLIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_CHARGEDETAILLIST

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
	name = "PATIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHARGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHGDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "QTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMESERVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_AMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILL_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILL_AMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARGIN_PERCENTAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARGIN_DOLLAR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIM_INS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FOREIGN_CODE"
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

