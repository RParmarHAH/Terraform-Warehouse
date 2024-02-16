resource "snowflake_table" "DW_HAH_FACT_APPLICANT_STATUS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_APPLICANT_STATUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_APPLICANT_STATUS

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "APPLICANT_STATUS_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "APPLICANT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "JOB_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "JOB_FAMILY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CANDIDATE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LINKED_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEND_TO_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRE_BOARDING_COMPLETION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_APPLIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONVERSATION_INPROGRESS_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INTERVIEW_SCHEDULED_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INTERVIEW_RESCHEDULED_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INTERVIEW_COMPLETED_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INTERVIEW_NO_AVAILABILITY_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INTERVIEW_NO_SHOW_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NUMBER_OF_TIMES_INTERVIEW_SCHEDULED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "APPLICATION_AND_BACKGROUND_CHECK_CONSENT_FORM_COMPLETE_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFERS_SENT_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFERS_ACCEPTED_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ONBOARDING_SENT_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ONBOARDING_COMPLETED_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ONBOARDING_COMPLETE_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRED_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REHIRE_DATETIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFER_DECLINED_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REJECTED_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REJECTION_REASON"
	type = "VARCHAR(75)"
	nullable = true
}


column {
	name = "MOST_RECENT_STAGE_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "APPLICANT_STATUS"
	type = "VARCHAR(110)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISPOSITION_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIOR_STATUS"
	type = "VARCHAR(110)"
	nullable = true
}


column {
	name = "PRIOR_STATUS_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(400)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BRANCH_STATE_CODE"
	type = "VARCHAR(40)"
	nullable = true
}

}

