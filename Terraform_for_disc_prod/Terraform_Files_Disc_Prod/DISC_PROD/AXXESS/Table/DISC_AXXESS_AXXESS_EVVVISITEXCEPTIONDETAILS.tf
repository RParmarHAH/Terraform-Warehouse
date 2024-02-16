resource "snowflake_table" "DISC_AXXESS_AXXESS_EVVVISITEXCEPTIONDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_EVVVISITEXCEPTIONDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_EVVVISITEXCEPTIONDETAILS

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TASK_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASK_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_END_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "END_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSIGNED_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTED_TIME_IN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTED_TIME_OUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCEPTION_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCEPTIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCEPTION_MESSAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_LOCATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROVIDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ADMINISTRATIVE_AREA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENT_SOURCE"
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

