resource "snowflake_table" "DISC_ADP_ALLIANCE_PAYROLL_DETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "ALLIANCE_PAYROLL_DETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.ALLIANCE_PAYROLL_DETAILS

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
	name = "DIRECT_DEPOSIT_CK1_CHECKING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_CK2_CHECKING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_CK3_CHECKING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_CK4_CHECKING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_HSC_HSA_CHECKING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_HSS_HSA_SAVINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_SV1_SAVINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT_SV2_SAVINGS"
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
	name = "ADDITIONAL_HOURS__1FE_FF_PSL_EE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__500_SICK_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__COR_CORP_PTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__OVP_OVERPAYMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__PTO_AGN_PTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__SI1_SICK_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__SIP_SICK_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS__TOH_PTO_HOURLY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERTIME_EARNINGS"
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
	name = "WORKED_IN_STATE_EMPLOYEE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_SURTAX_EMPLOYEE_TAX"
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
	name = "FEDERAL_INCOME_EMPLOYEE_TAXABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKED_IN_STATE_EMPLOYEE_TAXABLE"
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
	name = "MEMO_CAL_CAL_ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_D"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_GRO_ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_HHL_HOLLAND_ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_H_KHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_J_ELIGIBLE_COMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_MIL_MILEAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_MSA_MSK_ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_N_KMATCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_ONT_ONLINE_TRAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_REF_BONUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_STC_ST_JOE_ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_TB_TB_TEST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_MEMOS"
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
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "DATE"
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


column {
	name = "PAYCODES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

