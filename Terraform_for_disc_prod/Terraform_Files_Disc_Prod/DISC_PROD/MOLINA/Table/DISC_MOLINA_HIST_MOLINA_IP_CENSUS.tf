resource "snowflake_table" "DISC_MOLINA_HIST_MOLINA_IP_CENSUS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MOLINA"
	name = "HIST_MOLINA_IP_CENSUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MOLINA.HIST_MOLINA_IP_CENSUS

    -- Purpose : Discovery Data Population

    -- Project : MOLINA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PARTNER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHGROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHCATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TEMPLATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_NO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "RATE_GROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBER_COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBER_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRODUCT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBER_ATTRIBUTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MONTHS_ELIGIBLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICALREVIEWER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMITDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DSDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "RECEIPTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "APPROVED_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DENIED_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "READMIT_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERTO_PROVIDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_DIAG_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_DIAG_DESC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ELIGIBLE_TVH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CSS_FLAG1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSIGNED_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASE_MANAGER1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_CM_ASSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOC_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_TOC_ASSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UTC_FLAG_90_DAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASE_ACUITY_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAM_PARTICIPATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MISSING_HRA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IP_ADMIT_6M"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ED_VISIT_6M"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREVENTIVEVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOP100HCIPMEMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOSPITAL_PAID_AMT_6M"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFESSIONAL_PAID_AMT_6M"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RX_PAID_AMT_6M"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_PAID_AMT_6M"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MLR_6M"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANCER_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHF_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COPD_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASTHMA_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIABETES_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BH_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPRESSION_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SICKLECELL_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSPLANT_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIVAIDS_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HEPC_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_CDC_HBA1C_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_CDC_EYE_EXAM_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_CDC_NEPHROPATHY_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_BREAST_CANCER_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_IET_INITIATION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_IET_ENGAGEMENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_W15_15MONTH_6VISITS_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_W34_3TO6RS_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_PPC_PRENATAL_STATUS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_PPC_POSTPARTUM_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_WCC_BMI_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_AMB_ED_VISITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_ABA_BMI_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_AAP_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_APM_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_AMM_ACUTE_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_AMM_CONT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_CIS_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_FUH_7_STATUS_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_FUH_30_STATUS_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_MMA_50_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Q_MMA_75_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYTOTIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_PAYTO_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARTNER_FILENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOADDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

