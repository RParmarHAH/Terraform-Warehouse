resource "snowflake_table" "DISC_DEVERO_DEVERO_BILLDETAILSTAT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_BILLDETAILSTAT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_BILLDETAILSTAT

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
	name = "EMPLOYEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


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
	name = "CHGDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHARGENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLOW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Time"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLQTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTQTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTPAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINCLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACT"
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

