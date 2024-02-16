resource "snowflake_table" "DISC_WORKDAY_HIST_WORKER_IDENTIFICATION_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "HIST_WORKER_IDENTIFICATION_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.HIST_WORKER_IDENTIFICATION_DATA

    -- Purpose : Discovery Data Population

    -- Project : WORKDAY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IDENTIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ID_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISSUED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPIRATION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "VERIFICATION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LICENSE_CLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCESSED_TIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

