resource "snowflake_table" "DISC_ADP_ANSWERCARE_PAYROLL_DETAIL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "ANSWERCARE_PAYROLL_DETAIL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.ANSWERCARE_PAYROLL_DETAIL

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
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FILE_NUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POSITION_ID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ASSIGNMENT_ID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TAX_ID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ASSOCIATE_ID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKED_IN_COST_NUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKED_IN_STATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKED_IN_PROVINCE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKED_IN_DEPARTMENT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOME_DEPARTMENT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "REHIRE_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "BUSINESS_UNIT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "NAICS_WORKER_COMP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKER_CATEGORY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RATE_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_FREQUENCY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "BATCH_NUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "YEAR"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WEEK_NO"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_NUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DIST_NO"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PERIOD_BEGINNING_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PERIOD_ENDING_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CHECK_VOUCHER_NUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GROSS_PAY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TAKE_HOME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT___CK1_CHECKING_1"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT___CK2_CHECKING_2"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DIRECT_DEPOSIT___SV1_SAVINGS_1"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "NET_PAY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "REGULAR_HOURS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OVERTIME_HOURS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS____HOL_HOLIDAY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS____PAS_PASSPORT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDITIONAL_HOURS____POT_PASSPORT_OT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_HOURS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_EARNINGS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MEDICARE___EMPLOYEE_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MEDICARE___EMPLOYER_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MEDICARE___EMPLOYER_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY___EMPLOYER_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY___EMPLOYER_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKED_IN_LOCAL___EMPLOYEE_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FEDERAL_INCOME___EMPLOYEE_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKED_IN_STATE___EMPLOYEE_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FUTA___EMPLOYER_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FUTA___EMPLOYER_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SUI_SDI___EMPLOYER_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SUI_SDI___EMPLOYER_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_EMPLOYEE_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_EMPLOYER_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_TAXABLE_BENEFITS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_VOLUNTARY_DEDUCTIONS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_MEMOS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION___70_BANKRUPTCY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION___73_GARNISHMENT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION___75_SUPPORT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION___MIL_MILEAGE_REIMB"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "VOLUNTARY_DEDUCTION___MIS_MISCELLANEOUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY___EMPLOYEE_TAXABLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS____BON_BONUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS____HOL_HOLIDAY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS____PAS_PASSPORT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDITIONAL_EARNINGS____POT_PASSPORT_OT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FEDERAL_INCOME___EMPLOYEE_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MEDICARE___EMPLOYEE_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY___EMPLOYEE_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKED_IN_LOCAL___EMPLOYEE_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WORKED_IN_STATE___EMPLOYEE_TAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "REGULAR_EARNINGS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OVERTIME_EARNINGS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYCODES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(30)"
	nullable = true
}

}

