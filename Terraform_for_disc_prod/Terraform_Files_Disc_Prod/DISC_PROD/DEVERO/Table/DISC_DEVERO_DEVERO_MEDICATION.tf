resource "snowflake_table" "DISC_DEVERO_DEVERO_MEDICATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_MEDICATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_MEDICATION

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
	name = "PATIENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_MEDICATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEQ_NUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NDC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_CREATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_MODIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DC_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TEACH_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ROUTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLASSIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INDICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_HOSPICE_COVERED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_CHANGE_IN_COVERAGE"
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

