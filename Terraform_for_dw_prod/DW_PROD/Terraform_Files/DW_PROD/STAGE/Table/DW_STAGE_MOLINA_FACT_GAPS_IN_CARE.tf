resource "snowflake_table" "DW_STAGE_MOLINA_FACT_GAPS_IN_CARE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "MOLINA_FACT_GAPS_IN_CARE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.MOLINA_FACT_GAPS_IN_CARE

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "GAP_IN_CARE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "PARTNER_CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "BREAST_CANCER_SCREENING_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BREAST_CANCER_SCREENING_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CERVICAL_CANCER_SCREENING_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CERVICAL_CANCER_SCREENING_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COLORECTAL_CANCER_SCREENING_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COLORECTAL_CANCER_SCREENING_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARE_FOR_OLDER_ADULTS_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARE_FOR_OLDER_ADULTS_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONTROLLING_HIGH_BLOOD_PRESSURE_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONTROLLING_HIGH_BLOOD_PRESSURE_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATIN_THERAPY_FOR_CARDIOVASCULAR_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATIN_THERAPY_FOR_CARDIOVASCULAR_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEMOGLOBIN_A1C_CONTROL_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEMOGLOBIN_A1C_CONTROL_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOOD_PRESSURE_CONTROL_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOOD_PRESSURE_CONTROL_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EYE_EXAM_FOR_DIABETICS_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EYE_EXAM_FOR_DIABETICS_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "KIDNEY_HEALTH_FOR_DIABETICS_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "KIDNEY_HEALTH_FOR_DIABETICS_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATIN_THERAPY_FOR_DIABETICS_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATIN_THERAPY_FOR_DIABETICS_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OSTEOPOROSIS_MGMT_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OSTEOPOROSIS_MGMT_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OSTEOPOROSIS_SCREENING_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OSTEOPOROSIS_SCREENING_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADVANCED_CARE_PLANNING_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADVANCED_CARE_PLANNING_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRANSITIONS_OF_CARE_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRANSITIONS_OF_CARE_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADULT_ACCESS_TO_PREVENTIVE_AMBULATORY_HEALTH_SERVICES_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADULT_ACCESS_TO_PREVENTIVE_AMBULATORY_HEALTH_SERVICES_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICATION_ADHERENCE_FOR_DIABETES_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICATION_ADHERENCE_FOR_DIABETES_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICATION_ADHERENCE_FOR_HYPERTENSION_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICATION_ADHERENCE_FOR_HYPERTENSION_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICATION_ADHERENCE_FOR_CHOLESTROL_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICATION_ADHERENCE_FOR_CHOLESTROL_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ANNUAL_WELLNESS_VISIT_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ANNUAL_WELLNESS_VISIT_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FLU_VACCINE_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FLU_VACCINE_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ANNUAL_DENTIST_VISIT_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ANNUAL_DENTIST_VISIT_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COVID_19_VACCINE_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COVID_19_VACCINE_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PNEUMONIA_VACCINE_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PNEUMONIA_VACCINE_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TDAP_VACCINE_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TDAP_VACCINE_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHINGLES_VACCINE_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHINGLES_VACCINE_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ANNUAL_EYE_EXAM_ELIGIBILITY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ANNUAL_EYE_EXAM_GAP_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

