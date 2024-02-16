resource "snowflake_table" "DISC_AXXESS_AXXESS_TASKDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_TASKDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_TASKDETAILS

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ACCOUNT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_MIDDLE_INITIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_DISCIPLINE_TASK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSIGNED_TO_WORKER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSIGNED_WORKER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_DISCIPLINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVENT_STARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVENT_ENDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_START"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_END"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_STARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISPAYABLE_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISBILLABLE_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ISORDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ISVISITPAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ISALLDAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ISMISSEDVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ISCAREPERIOD_DISCHARGED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ISCAREPERIOD_ACTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_ISDEPRECATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MISSED_VISIT_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_START"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_END"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AVAILABLE_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_UNIT_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_FREQUENCY_OF_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_OCCURRENCE_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DAYS_AUTH_RESTRICTEDTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_TOTAL_LUNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_DISCIPLINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_ISDEPRECATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_STARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_ENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_INVOICE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASH_RECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENT_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEGATIVE_ADJUSTMENT_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NET_RECEIVABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT_ISDEPRECATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ZIP_CODE_FOUR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ISMAIN_OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ISDEPRECATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_INSURANCE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_REFERRAL_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_MEDICAID_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ISHOSPITALIZED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ISNONMEDICAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DISCHARGEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DIAGNOSISID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_START"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_END"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_STARTOFCARE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_CASEMANAGER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_ISACTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_ISDISCHARGED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREPERIOD_ISLINKEDTODISCHARGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_DISCHARGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_DISCHARGE_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_ISDEPRECATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_ISNONMEDICAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_REFERRALID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STARTOFCARE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISVERIFIED_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_DISCHARGE_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUAL_SCHEDULED_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DAYS_AUTH_RESTRICTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ISDEPRECATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZED_TASK_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_BILL_RATE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
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

