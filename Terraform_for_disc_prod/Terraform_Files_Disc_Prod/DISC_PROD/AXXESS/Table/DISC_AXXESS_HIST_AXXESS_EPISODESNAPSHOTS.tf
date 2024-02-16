resource "snowflake_table" "DISC_AXXESS_HIST_AXXESS_EPISODESNAPSHOTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "HIST_AXXESS_EPISODESNAPSHOTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.HIST_AXXESS_EPISODESNAPSHOTS

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
	name = "PAYOR_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_PRIMARY_INSURANCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UTN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_DISCHARGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_DISCHARGE_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_PENDING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_ADMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_OF_CARE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_RECERT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_LUPA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_RESUMPTION_OF_CARE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_SUPPLY_COST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LABOR_COST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NON_VISIT_LABOR_COST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILEAGE_COST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NON_VISIT_MILEAGE_COST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTO_CALCULATED_MILEAGE_COST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTO_CALCULATED_TRAVEL_TIME_COST"
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
	name = "CASE_MANAGER_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASE_MANAGER_LAST_NAME"
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
	name = "IS_DISCHARGED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_TIMING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SURCHARGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_CLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_DISCHARGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_LENGTH_OF_STAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_ADMISSION_PERIOD_DISCHARGED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_PATIENT_DELETED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_PRIMARY_INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MISSED_MSW_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MISSED_SN_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MISSED_THERAPY_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CNA_HHA_CLINICIAN_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LPN_CLINICIAN_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RN_CLINICIAN_VISIT_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASE_MANAGER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_RELATIONSHIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIC_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MBI_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_FACSIMILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECOND_UTN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRIAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_PLAN_OF_CARE_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVALUATION_THERAPY_POC_OTHER_NOTE_ORDERS_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVALUATION_THERAPY_POC_OTHER_NOTE_ORDERS_UNSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FACE_TO_FACE_ORDERS_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FACE_TO_FACE_ORDERS_UNSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_PLAN_OF_CARE_ORDERS_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_PLAN_OF_CARE_ORDERS_UNSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_ORDERS_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_ORDERS_UNSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PLAN_OF_CARE_ORDERS_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PLAN_OF_CARE_ORDERS_UNSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PLAN_OF_CARE_STANDALONE_ORDERS_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PLAN_OF_CARE_STANDALONE_ORDERS_UNSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_ORDERS_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_ORDERS_UNSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PLAN_OF_CARE_ORDER_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PLAN_OF_CARE_RECEIVED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEATH_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEATH_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEATH_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_NON_VISIT_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_NON_VISIT_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_NON_VISIT_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FOLLOWUP_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FOLLOWUP_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FOLLOWUP_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECERT_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECERT_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECERT_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESUMPTION_OF_CARE_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESUMPTION_OF_CARE_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESUMPTION_OF_CARE_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_OF_CARE_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_OF_CARE_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_OF_CARE_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSFER_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSFER_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSFER_DISCHARGE_ASSESSMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSFER_DISCHARGE_COMPLETED_BY_CLINICIAN_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSFER_DISCHARGE_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSFER_EXPORTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOSPITALIZATION_REASONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POLICY_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_VISIT_AUTHORIZATION_REQUIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICAL_MANAGER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_CLINICIAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESSLINE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESSLINE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_GROUP_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHER_PHYSICIAN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFYING_PHYSICIAN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRING_PHYSICIAN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_INSURANCE_ID"
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

