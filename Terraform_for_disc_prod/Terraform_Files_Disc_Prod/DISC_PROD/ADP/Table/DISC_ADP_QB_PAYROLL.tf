resource "snowflake_table" "DISC_ADP_QB_PAYROLL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "QB_PAYROLL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.QB_PAYROLL

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
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WAGES_TAXES_AND_ADJUSTMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMIN_SALARY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NURSING_SALARY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICERS_SALARIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMIN_HOURLY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMIN_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_INS_PRV"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_INS_PRV_BK_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_INS_PRV_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_MEDICAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_MEDICAID_BACK_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_MEDICAID_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_MEDICARE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_MEDICARE_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PTA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_GROSS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUCTIONS_FROM_GROSS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DENTAL_INSURANCE_PRE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HEALTH_INSURANCE_PRE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISION_INSURANCE_PRE_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_DEDUCTIONS_FROM_GROSS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTED_GROSS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXES_WITHHELD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERAL_W_H"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_W_H"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_W_H"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_EMPLOYEE_ADDL_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_TAXES_WITHHELD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUCTIONS_FROM_NET_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHILD_SPOUSAL_SUPPORT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LIFE_INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TESTING_DEDUCTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_DEDUCTIONS_FROM_NET_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NET_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERAL_UNEMPLOYMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_COMPANY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FL_UNEMPLOYMENT_COMPANY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COVID_19_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_HOURLY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_HOURLY_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LPN_SNV"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRAVEL_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NURSE_BONUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERAL_WITHHOLDING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GARNISHMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHILD_SUPPORT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILEAGE_REIMBURSEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REIMBURSEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REIMBURSEMENT_CPR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_START"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_END"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHK_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHK_NO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FED_W_H"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOC_SEC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MED_CARE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MED_CARE_ADDL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE_W_H"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHER_TAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREMIUM_ONLY_PLAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOLEDO_MUNICIPAL_COURT"
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

