resource "snowflake_table" "DISC_ADP_OPALPAYROLL_OLD" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "OPALPAYROLL_OLD"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.OPALPAYROLL_OLD

    -- Purpose : Discovery Data Population

    -- Project : ADP

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSIGNMENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSOCIATE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_COST_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_PROVINCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_DEPARTMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOME_DEPARTMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REHIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAICS_WORKERS_COMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKER_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BATCH_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "YEAR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEK_NO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLL_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIST_NO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERIOD_BEGINNING_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERIOD_ENDING_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECK_VOUCHER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAKE_HOME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_CK1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_CK2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_CK3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_CK4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_CK5"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_SV1_SAVINGS_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_SV2_SAVINGS_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NET_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGULAR_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERTIME_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__FLO_HH_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__GEN_GENERAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__EL_C19_LEAVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__AP2_AP_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__AP_AP_CW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__DE2_DEI_CW_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__DEI_DEI_CW_REG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__GOT_GENERAL_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__H_HOLIDAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__HH2_HH_HOL_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__HLO_HOLIDAY_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__MG_M_AMP_G"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__MGO_M_AMP_G_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__O_OTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__OP_OP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__OR2_ORIENTATION_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__OR_ORIENTATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PAP_PAP_PW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__P2A_P2A_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PD2_DEI_PW_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PDE_DEI_PW_REG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PH2_PW_HOL_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PH_PW_HOL_REG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PMG_PW_M_AMP_G"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PN2_PW_TRN_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PO2_PW_OR_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PO_PW_OR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__POP_OP_PW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PR2_PW_TRAV_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PTN_PW_TRAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PTR_PW_TRAVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PTT_PW_T_AMP_T"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PW_PW_REG_HRS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PWO_PW_OT_HRS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PWS_PW_SICK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__S_SICK_LEAVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__TNO_TRAINING_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__TR_TRAVEL_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__TRN_TRAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__TRO_TRAVEL_TIME_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__TT_TIME__AMP__TROUBLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__TTO_TIME_AMP_TRBLE_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__VST_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGULAR_EARNINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERTIME_EARNINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__AP2_AP_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__AP_AP_CW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__B_BONUS_GEN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__P2A_P2A_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__HH2_HH_HOL_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__EL_C19_LEAVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__FLO_HH_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__GEN_GENERAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__GOT_GENERAL_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__C_COMMISSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__O_OTHEREA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__OC_ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__RB_REFERRAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__SEV_SEVERANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__BSO_SIGNING_BONUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__DE2_DEI_CW_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__DEI_DEI_CW_REG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__HAZ_HAZARD_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__H_HOLIDAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__HLO_HOLIDAY_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__OR2_ORIENTATION_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__MG_M_AMP_G"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__MGO_M_AMP_G_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__O_OTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__OP_OP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__OR_ORIENTATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PAP_PAP_PW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PDE_DEI_PW_REG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PD2_DEI_PW_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PH2_PW_HOL_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PH_PW_HOL_REG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PMG_PW_M_AMP_G"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PN2_PW_TRN_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PO2_PW_OR_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PO_PW_OR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PR2_PW_TRAV_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__POP_OP_PW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PTN_PW_TRAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PTR_PW_TRAVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PTT_PW_T_AMP_T"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PW_PW_REG_HRS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PWO_PW_OT_HRS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__PWS_PW_SICK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__S_SICK_LEAVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__TNO_TRAINING_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__TR_TRAVEL_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__TRN_TRAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__TRO_TRAVEL_TIME_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__TT_TIME__AMP__TROUBLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__TTO_TIME_AMP_TRBLE_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS__VST_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_EARNINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERAL_INCOME_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LIVED_IN_LOCAL_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LIVED_IN_STATE_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_SDI_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_LOCAL_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_STATE_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCAL_4_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCAL_5_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_SURTAX_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAMILY_LEAVE_INSURANCE_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_EMPLOYER_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_EMPLOYER_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_SURTAX_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_EMPLOYER_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_EMPLOYER_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_LOCAL_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LIVED_IN_LOCAL_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERAL_INCOME_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_SDI_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_STATE_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LIVED_IN_STATE_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUTA_EMPLOYER_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUTA_EMPLOYER_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCAL_4_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCAL_5_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_SDI_EMPLOYER_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_SDI_EMPLOYER_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAMILY_LEAVE_INSURANCE_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAMILY_LEAVE_INSURANCE_EMPLOYER_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAMILY_LEAVE_INSURANCE_EMPLOYER_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_EMPLOYER_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUI_EMPLOYER_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SDI_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SDI_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SDI_EMPLOYER_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_EMPLOYER_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_TAXABLE_BENEFITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_401_401K"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_4LN_401K_LOAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_66_TAX_LEVY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_67_TAX_LEVY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_68_TAX_LEVY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_73_GARNISHMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_CC_401KCOMM_BONUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_CK1_CHECKING_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_60_GARNISHMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_61_TAX_LEVY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_62_TAX_LEVY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_63_TAX_LEVY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_64_TAX_LEVY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_74_GARNISHMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_75_SUPPORT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_76_SUPPORT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_CPR_CPR_CERT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_AD_ADVANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_70"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_74"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_75"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_76"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_77"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_78"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_DDR_DD_RETURN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_DEN_DEN125_P"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_HSA_HSA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_FP_FP_REIMB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_MED_MED125_P"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_MIS_MISC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_ML_EXP_MILEAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_PPD_EXP_PPD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_QFN_EXP_QFERON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_NQB_NON_QUAL_BON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_NQC_NON_QUAL_COMM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_NQR_NON_QUAL_REG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_OAD_OPTIONAL_AD_AMP_D"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_OLC_OPTLIFECHILD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_OLI_OPTIONAL_LIFE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_OLS_OPTIONAL_LIFE_S"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_RI_EXPENSE_REI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_ST_STOP_PAYMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_TSP_OTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_TA_TAX_ADJUSTM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION_VIS_VISION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_VOLUNTARY_DEDUCTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_B_HLTH_PLAN_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_K_ER_MATCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_NQD_NON_QUAL_DEFF"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_NQM_NON_QUAL_MATCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_X_MAX_ELIG_COMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_MEMOS"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

