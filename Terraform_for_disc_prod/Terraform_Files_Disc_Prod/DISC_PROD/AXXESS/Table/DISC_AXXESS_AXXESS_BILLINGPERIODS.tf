resource "snowflake_table" "DISC_AXXESS_AXXESS_BILLINGPERIODS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_BILLINGPERIODS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_BILLINGPERIODS

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
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ID"
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
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_PATIENT_DELETED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_PERIOD_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASEMIX_WEIGHT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHRG_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LUPA_THRESHOLD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICAL_GROUPING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMORBIDITY_LEVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMORBIDITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUNCTIONAL_SCORE_LEVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUNCTIONAL_SCORE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_CLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_SN_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_PT_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_OT_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_ST_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_PTA_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_DIETICIAN_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_HHA_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_COTA_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_MSW_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_LPN_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_TIMING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINAL_CLAIM_CASH_RECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGED_CLAIM_CASH_RECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RAP_CASH_RECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINAL_CLAIM_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGED_CLAIM_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RAP_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_ADMISSION_PERIOD_DISCHARGED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_ADMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_RECERT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_EPISODE_ACTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_OF_CARE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUAL_HIPPS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUAL_PROSPECTIVE_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXPECTED_BILLING_PERIOD_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXPECTED_LUPA_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIPPS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORIGINAL_PROSPECTIVE_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULE_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASEMIX_EXPECTED_AMOUNT"
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

