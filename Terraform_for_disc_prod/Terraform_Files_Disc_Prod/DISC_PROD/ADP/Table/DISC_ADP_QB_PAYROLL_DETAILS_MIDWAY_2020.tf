resource "snowflake_table" "DISC_ADP_QB_PAYROLL_DETAILS_MIDWAY_2020" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "QB_PAYROLL_DETAILS_MIDWAY_2020"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.QB_PAYROLL_DETAILS_MIDWAY_2020

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
	name = "COMPANY"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HOURS_HHA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_NURSE_MEETING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_MILEAGE_GAS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_FMLA_EXP_PAID_LEAVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_REGULAR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_SK_SOC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_SICK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_BONUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_VAC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_SAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_OTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_PERDIEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_REIMB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_MEDICAL_EXPENSES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_SK_RCT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_TAXABLE_PER_DIEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_NON_SK_SOC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_OTHER_SN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_HHA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_NURSE_MEETING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_MILEAGE_GAS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY_FMLA_EXP_PAID_LEAVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRETAX_DEDUCTIONS_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTED_GROSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHER_PAY_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_DEDUCTIONS_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_FIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_MED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_OH_PIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_SCH_DIST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TAXES_SCH_DIST_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_AFTERTAX_DEDUCTIONS_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_AFTERTAX_DEDUCTIONS_BCI_CPR__FIRST_AID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_AFTERTAX_DEDUCTIONS_TABLET_DATA_OVER_USAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_AFTERTAX_DEDUCTIONS_SIGN_ON_BONUS_ADVANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_AFTERTAX_DEDUCTIONS_MANSFIELD_MUNICIPAL_COURT_CASE_2019CVF02359"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NET_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYER_TAXES_CONTRIBUTIONS_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYER_TAXES_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYER_TAXES_FUTA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYER_TAXES_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYER_TAXES_MED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYER_TAXES_OH_SUI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYER_TAXES_FMLA_EXPANSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANY_CONTRIBUTIONS_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_PAYROLL_COST"
	type = "VARCHAR(16777216)"
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

