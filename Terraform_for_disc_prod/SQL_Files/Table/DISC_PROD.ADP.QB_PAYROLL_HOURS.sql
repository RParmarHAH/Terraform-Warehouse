CREATE OR REPLACE TABLE DISC_PROD.ADP.QB_PAYROLL_HOURS (
	COMPANY VARCHAR(13),
	NAME VARCHAR(16777216),
	SSN VARCHAR(16777216),
	TYPE VARCHAR(16777216),
	DATE VARCHAR(16777216),
	EMPLOYEE_WAGES_TAXES_AND_ADJUSTMENTS VARCHAR(16777216),
	GROSS_PAY VARCHAR(16777216),
	ADMIN_SALARY VARCHAR(16777216),
	NURSING_SALARY VARCHAR(16777216),
	OFFICERS_SALARIES VARCHAR(16777216),
	ADMIN_HOURLY VARCHAR(16777216),
	ADMIN_OT VARCHAR(16777216),
	HHA_INS_PRV VARCHAR(16777216),
	HHA_INS_PRV_BK_PAY VARCHAR(16777216),
	HHA_INS_PRV_OT VARCHAR(16777216),
	HHA_MEDICAID VARCHAR(16777216),
	HHA_MEDICAID_BACK_PAY VARCHAR(16777216),
	HHA_MEDICAID_OT VARCHAR(16777216),
	HHA_MEDICARE VARCHAR(16777216),
	HHA_MEDICARE_OT VARCHAR(16777216),
	PTA VARCHAR(16777216),
	TOTAL_GROSS_PAY VARCHAR(16777216),
	DEDUCTIONS_FROM_GROSS_PAY VARCHAR(16777216),
	DENTAL_INSURANCE_PRE_TAX VARCHAR(16777216),
	HEALTH_INSURANCE_PRE_TAX VARCHAR(16777216),
	VISION_INSURANCE_PRE_TAX VARCHAR(16777216),
	TOTAL_DEDUCTIONS_FROM_GROSS_PAY VARCHAR(16777216),
	ADJUSTED_GROSS_PAY VARCHAR(16777216),
	TAXES_WITHHELD VARCHAR(16777216),
	FEDERAL_W_H VARCHAR(16777216),
	MEDICARE_W_H VARCHAR(16777216),
	SOCIAL_SECURITY_W_H VARCHAR(16777216),
	MEDICARE_EMPLOYEE_ADDL_TAX VARCHAR(16777216),
	TOTAL_TAXES_WITHHELD VARCHAR(16777216),
	DEDUCTIONS_FROM_NET_PAY VARCHAR(16777216),
	CHILD_SPOUSAL_SUPPORT VARCHAR(16777216),
	LIFE_INSURANCE VARCHAR(16777216),
	TESTING_DEDUCTION VARCHAR(16777216),
	TOTAL_DEDUCTIONS_FROM_NET_PAY VARCHAR(16777216),
	NET_PAY VARCHAR(16777216),
	FEDERAL_UNEMPLOYMENT VARCHAR(16777216),
	MEDICARE_COMPANY VARCHAR(16777216),
	FL_UNEMPLOYMENT_COMPANY VARCHAR(16777216),
	COVID_19_PAY VARCHAR(16777216),
	HHA_HOURLY VARCHAR(16777216),
	HHA_HOURLY_OT VARCHAR(16777216),
	LPN_SNV VARCHAR(16777216),
	ON_CALL VARCHAR(16777216),
	PTO VARCHAR(16777216),
	TRAVEL_TIME VARCHAR(16777216),
	NURSE_BONUS VARCHAR(16777216),
	FEDERAL_WITHHOLDING VARCHAR(16777216),
	GARNISHMENT VARCHAR(16777216),
	CHILD_SUPPORT VARCHAR(16777216),
	MILEAGE_REIMBURSEMENT VARCHAR(16777216),
	REIMBURSEMENT VARCHAR(16777216),
	REIMBURSEMENT_CPR VARCHAR(16777216),
	PAY_START VARCHAR(16777216),
	PAY_END VARCHAR(16777216),
	CHK_DATE VARCHAR(16777216),
	CHK_NO VARCHAR(16777216),
	HOURS VARCHAR(16777216),
	GROSS VARCHAR(16777216),
	FED_W_H VARCHAR(16777216),
	SOC_SEC VARCHAR(16777216),
	MED_CARE VARCHAR(16777216),
	MED_CARE_ADDL VARCHAR(16777216),
	STATE_W_H VARCHAR(16777216),
	OTHER_TAX VARCHAR(16777216),
	PREMIUM_ONLY_PLAN VARCHAR(16777216),
	TOLEDO_MUNICIPAL_COURT VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);