resource "snowflake_table" "DISC_DEVERO_HIST_DEVERO_PATIENT_PROFILE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "HIST_DEVERO_PATIENT_PROFILE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.HIST_DEVERO_PATIENT_PROFILE

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
	name = "FORM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_MODIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_XML"
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

