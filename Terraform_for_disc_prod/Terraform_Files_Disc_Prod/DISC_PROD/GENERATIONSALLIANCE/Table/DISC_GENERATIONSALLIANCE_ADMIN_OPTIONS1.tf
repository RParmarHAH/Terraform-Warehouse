resource "snowflake_table" "DISC_GENERATIONSALLIANCE_ADMIN_OPTIONS1" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "ADMIN_OPTIONS1"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.ADMIN_OPTIONS1

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANYNAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "BIT_ONLINEAPPLICATIONENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ONLINESERVICEENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ONLINEAPPLICATIONEMAILS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "APPLICATIONURLTOREDIRECT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "APPLICATIONCUSTOMMESSAGE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SERVICEURLTOREDIRECT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SERVICECUSTOMMESSAGE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ONLINESERVICEEMAILS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "BIT_ENABLEDAILYSCHEDULEREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USEREMAILFORSCHEDULEREMINDERSUMMARY"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "EMAILACCOUNT_SCHEDULEREMINDER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BITCONVICTEDCRIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CERTIFICATIONTEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BITREQUIRESSN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BITREMOVEEODISCLAIMER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BITEMERGENCYCONTACTINFO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EO_DISCLAIMER"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "BIT_INCLUDECGAPPNOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_INCLUDECGTEXTNOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

