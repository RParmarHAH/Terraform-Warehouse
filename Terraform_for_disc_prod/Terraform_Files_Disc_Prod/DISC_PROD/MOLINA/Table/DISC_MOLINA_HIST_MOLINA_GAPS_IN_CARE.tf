resource "snowflake_table" "DISC_MOLINA_HIST_MOLINA_GAPS_IN_CARE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MOLINA"
	name = "HIST_MOLINA_GAPS_IN_CARE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MOLINA.HIST_MOLINA_GAPS_IN_CARE

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
	name = "MM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBER_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBER_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHINICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBER_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIA_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EC_PRODUCT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "YEAR_MONTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "YR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEHEALTH_NPI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEHEALTH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEHEALTH_ADD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEHEALTH_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEHEALTH_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEHEALTH_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEHEALTH_COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMT_PAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAL_COST_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IP_ADMITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IP_BED_DAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IP_PAID_AMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LTC_BED_DAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LTC_AMOUNTPAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "READMIT_COUNT_SAME_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "READMIT_COUNT_ANY_DIAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ED_VISITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ED_PAID_AMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREVENTIVE_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREVENTIVE_VISIT_AMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTODIAL_ADMITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTODIAL_PAID_AMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ED_VISITS_TO_IP_ADMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ED_VISITS_TO_IP_ADMIT_PAID_AMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASE_MANAGER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_CASE_MANAGER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REDETERMINATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IN_CASE_MGMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UTIL_TREND"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AAP_NUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AAP_DENOM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BCS_NUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BCS_DENOM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CBP_NUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CBP_DENOM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AAP_NUM_PYCM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AAP_DENOM_PYCM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BCS_NUM_PYCM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BCS_DENOM_PYCM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CBP_NUM_PYCM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CBP_DENOM_PYCM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AAP_NUM_PYEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AAP_DENOM_PYEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BCS_NUM_PYEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BCS_DENOM_PYEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CBP_NUM_PYEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CBP_DENOM_PYEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPD_DENOM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPD_NUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ROLLING12M_RISKSCORE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBERSHIPCOUNT_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PNEU_VACCINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FLU_VACCINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBER_COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCP_ZIP"
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

