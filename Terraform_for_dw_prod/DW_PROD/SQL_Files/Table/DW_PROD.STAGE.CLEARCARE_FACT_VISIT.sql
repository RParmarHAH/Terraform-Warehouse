CREATE OR REPLACE TABLE DW_PROD.STAGE.CLEARCARE_FACT_VISIT (
	VISIT_KEY VARCHAR(32) NOT NULL,
	REPORT_DATE DATE NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	CONTRACT_KEY VARCHAR(32) NOT NULL,
	SCHEDULED_EMPLOYEE_KEY VARCHAR(32),
	EMPLOYEE_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SUPERVISOR_KEY VARCHAR(32) NOT NULL,
	INVOICE_KEY VARCHAR(32),
	PAYROLL_KEY VARCHAR(32),
	CLIENT_SERVICE_KEY VARCHAR(32),
	PARTNER_CONTRACT_SERVICE_KEY VARCHAR(32),
	BILLING_KEY VARCHAR(32),
	SERVICE_DATE DATE NOT NULL,
	PAYROLL_DATE DATE,
	BRANCH_NAME VARCHAR(100),
	CLIENT_NUMBER NUMBER(38,0),
	CONTRACT_CODE VARCHAR(50),
	SCHEDULED_EMPLOYEE_ID VARCHAR(50),
	EMPLOYEE_ID VARCHAR(50),
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SUPERVISOR_CODE VARCHAR(50),
	INVOICE_ID VARCHAR(50),
	CHEQUE_NUMBER VARCHAR(50),
	CLEAN_SHIFT_FLAG BOOLEAN NOT NULL,
	SCHEDULE_STATUS_CODE VARCHAR(50),
	SCHEDULE_STATUS_NAME VARCHAR(100),
	SCHEDULE_STATUS_DESCRIPTION VARCHAR(500),
	VISIT_STATUS_CODE VARCHAR(50),
	VISIT_STATUS_NAME VARCHAR(100),
	VISIT_STATUS_DESCRIPTION VARCHAR(500),
	INVOICE_STATUS_CODE VARCHAR(50),
	INVOICE_STATUS_NAME VARCHAR(100),
	INVOICE_STATUS_DESCRIPTION VARCHAR(500),
	PAYROLL_STATUS_CODE VARCHAR(50),
	PAYROLL_STATUS_NAME VARCHAR(100),
	PAYROLL_STATUS_DESCRIPTION VARCHAR(500),
	CANCEL_REASON_CODE VARCHAR(20) COMMENT 'Reason code for schedule cancellation',
	CANCEL_REASON_DESCRIPTION VARCHAR(100),
	CANCEL_REASON_NOTES VARCHAR(16777216),
	EXCEPTION_REASON_INDICATOR VARCHAR(10) NOT NULL DEFAULT 'NO',
	RESOLUTION_CODE VARCHAR(20),
	RESOLUTION_DESCRIPTION VARCHAR(100),
	REJECTION_CODE VARCHAR(20),
	REJECTION_DESCRIPTION VARCHAR(500),
	BILL_CODE VARCHAR(50),
	BILL_RATE NUMBER(15,3),
	BILL_UNITS_SERVED NUMBER(38,3),
	BILL_UNIT_TYPE VARCHAR(15),
	OVERHEAD_RATE NUMBER(15,3),
	SCHEDULE_TIMEIN TIME(9),
	SCHEDULE_TIMEOUT TIME(9),
	SCHEDULE_DURATION NUMBER(6,2),
	ACTUAL_TIMEIN TIME(9),
	ACTUAL_TIMEOUT TIME(9),
	ACTUAL_DURATION NUMBER(6,2),
	ADJUSTED_TIMEIN TIME(9),
	ADJUSTED_TIMEOUT TIME(9),
	ADJUSTED_DURATION NUMBER(6,2),
	HOURS_SERVED NUMBER(38,3),
	COMMENTS VARCHAR(5000),
	IS_EVV_FLAG VARCHAR(1),
	TIMESHEET_TYPE VARCHAR(1),
	TRACKING_ID NUMBER(38,0),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	CONFIRMED_FLAG VARCHAR(10)
);