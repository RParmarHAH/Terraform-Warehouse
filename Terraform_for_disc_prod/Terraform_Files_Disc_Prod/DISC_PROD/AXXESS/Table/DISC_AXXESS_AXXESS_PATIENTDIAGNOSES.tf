resource "snowflake_table" "DISC_AXXESS_AXXESS_PATIENTDIAGNOSES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_PATIENTDIAGNOSES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_PATIENTDIAGNOSES

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
	name = "PATIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_INSURANCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_DIAGNOSIS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_DIAGNOSIS_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_DIAGNOSIS_SEVERITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_2_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_2_SEVERITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_3_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_3_SEVERITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_4_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_4_SEVERITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_5"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_5_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_5_SEVERITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_6"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_6_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_6_SEVERITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_7"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_7_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_7_SEVERITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_8"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_8_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIAGNOSIS_8_SEVERITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_ID"
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

