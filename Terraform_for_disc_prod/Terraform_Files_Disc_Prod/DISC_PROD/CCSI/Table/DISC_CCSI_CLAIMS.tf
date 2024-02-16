resource "snowflake_table" "DISC_CCSI_CLAIMS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "CLAIMS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.CLAIMS

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "VARCHAR(9999999)"
	nullable = true
}


column {
	name = "INJURY_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REPORT_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMPLOYEE_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ACTIVITY_WHEN_INJURED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DIRECT_CAUSE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PART_OF_BODY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INCURRED_MED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INCURRED_INDM"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DATE_HIRED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TOTAL_INCURRED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SUBRO"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ADJUSTER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SUPERVISOR"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DOCTOR"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ATTORNEY_FEES"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ATTORNEY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INVOLVED_CLIENT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "HCA_DATE_OF_BIRTH"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RESVMED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RESVINDM"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMP_TERMINATION_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WAGES_LOST"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MONITOR_CODE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MORE_COMMENTS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COMMENTS1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COMMENTS2"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COMMENTS3"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COMMENTS4"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COMMENTS5"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ZONE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TOTAL_RESERVED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TYPE_OF_INJURY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMP_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZONE1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLIENT_CAUSED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLAIM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REPORTED_TO_CARRIER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CARRIER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MISSED_WORK_DAYS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FIRST_MISSED_DAY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LAST_DAY_WORKED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ESTIMATED_RETURN_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RELEASED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LIGHT_DUTY_OFFERED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LIGHT_DUTY_BEGAN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLASS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LAST_INFO_RECEIVED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BACK_TO_WORK_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "WORKING"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPECTED_TO_RETURN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ISSUES"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MORE_NOTES"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MORE_NOTES1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MORE_NOTES2"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MORE_NOTES3"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "HOT_CASE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(200)"
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
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

