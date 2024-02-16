resource "snowflake_table" "DISC_MOLINA_HIST_MOLINA_FULL_ROSTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MOLINA"
	name = "HIST_MOLINA_FULL_ROSTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MOLINA.HIST_MOLINA_FULL_ROSTER

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
	name = "PARTNER_ID"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "MM"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "MEMID"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "MEDICAID_ID"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "MEMBER_FIRST_NAME"
	type = "VARCHAR(40)"
	nullable = false
}


column {
	name = "MEMBER_LAST_NAME"
	type = "VARCHAR(40)"
	nullable = false
}


column {
	name = "DOB"
	type = "DATE"
	nullable = false
}


column {
	name = "SEX"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AGE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ETHINICITY"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "MEMBER_ZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIA_ZIP"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EC_PRODUCT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LOB"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "YEAR_MONTH"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "YR"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOMEHEALTH_NPI"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "HOMEHEALTH_NAME"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "HOMEHEALTH_ADD"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "HOMEHEALTH_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOMEHEALTH_STATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOMEHEALTH_ZIP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOMEHEALTH_COUNTY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "AMT_PAID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEDICAL_COST_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IP_ADMITS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IP_BED_DAYS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IP_PAID_AMT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LTC_BED_DAYS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LTC_AMOUNTPAID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "READMIT_COUNT_SAME_DIAG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "READMIT_COUNT_ANY_DIAG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ED_VISITS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ED_PAID_AMT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PREVENTIVE_VISIT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PREVENTIVE_VISIT_AMT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CUSTODIAL_ADMITS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CUSTODIAL_PAID_AMT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ED_VISITS_TO_IP_ADMIT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ED_VISITS_TO_IP_ADMIT_PID_AMT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CASE_MANAGER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CURRENT_CASE_MANAGER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REDETERMINATION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "IN_CASE_MGMT"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "UTIL_TREND"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PCP_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AAP_NUM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "AAP_DENOM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "BCS_NUM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "BCS_DENOM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CBP_NUM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CBP_DENOM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "AAP_NUM_PYCM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "AAP_DENOM_PYCM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "BCS_NUM_PYCM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "BCS_DENOM_PYCM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CBP_NUM_PYCM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CBP_DENOM_PYCM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "AAP_NUM_PYEM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "AAP_DENOM_PYEM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "BCS_NUM_PYEM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "BCS_DENOM_PYEM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CBP_NUM_PYEM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CBP_DENOM_PYEM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "SPD_DENOM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "SPD_NUM"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "ROLLING12M_RISKSCORE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEMBERSHIPCOUNT_FLAG"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PNEU_VACCINE"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "FLU_VACCINE"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "MEMBER_COUNTY"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PCP_PHONE"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PCP_ADDRESS1"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PCP_ADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PCP_CITY"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PCP_STATE"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PCP_ZIP"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PARTNER_FILENAME"
	type = "VARCHAR(60)"
	nullable = false
}


column {
	name = "LOADDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(50)"
	nullable = true
}

}

