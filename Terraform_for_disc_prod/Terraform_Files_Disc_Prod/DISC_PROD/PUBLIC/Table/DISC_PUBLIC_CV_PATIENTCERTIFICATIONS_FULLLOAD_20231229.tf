resource "snowflake_table" "DISC_PUBLIC_CV_PATIENTCERTIFICATIONS_FULLLOAD_20231229" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "CV_PATIENTCERTIFICATIONS_FULLLOAD_20231229"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.CV_PATIENTCERTIFICATIONS_FULLLOAD_20231229

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEQUENCE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFICATION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFICATION_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFICATION_FROM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFICATION_THRU"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FACILITY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLTO_STATUS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PLAN_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERT_TRAN_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENT__CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROVIDER_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DDL_CERT_STATUS_NEW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DDL_PORTAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NURSE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DDL_CERT_FORM_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
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

