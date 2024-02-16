resource "snowflake_table" "DISC_RISKONNECT_HIST_WORK_STATUS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "HIST_WORK_STATUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.HIST_WORK_STATUS

    -- Purpose : Discovery Data Population

    -- Project : RISKONNECT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONNECTIONRECEIVEDID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONNECTIONSENTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTIVE_OR_COMPLETED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTIVITY_TYPE_DETAILS__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ACTIVITY_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADJUSTMENT_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADJUSTMENT_HOURS__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ADJUSTMENT_REASON__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLAIMANT_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DATETIME_AWAY__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATETIME_RETURN__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_BEGIN__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_END__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NET_TOTAL_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RETURN_TO_UNRESTRICTED_WORK__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TOTAL_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WORK_STATUS_COMMENT__C"
	type = "VARCHAR(50000)"
	nullable = true
}


column {
	name = "HIDDEN_CHECKBOX__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIDDEN_TOTAL_DAYS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VOID__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENTRY_DATE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TPA_CHECK__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TPA_LOST_DAYS_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORK_STATUS_TRACKING__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DID_EE_RTW__C"
	type = "VARCHAR(50)"
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

}

