resource "snowflake_table" "DISC_ZENDESK_USER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "USER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.USER

    -- Purpose : Discovery Data Population

    -- Project : ZENDESK

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SOURCE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "VARIANT"
	nullable = true
}


column {
	name = "USER_FIELDS_EMPLOYEE_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "USER_FIELDS_WORKDAY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ROLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_EMPLOYEE_ID_TEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_ZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IANA_TIME_ZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHARED_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCALE_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "LOCALE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORGANIZATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VERIFIED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALIAS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHARED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SHARED_AGENT"
	type = "VARIANT"
	nullable = true
}


column {
	name = "LAST_LOGIN_AT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TWO_FACTOR_AUTH_ENABLED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SIGNATURE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ROLE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOM_ROLE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODERATOR"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_RESTRICTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONLY_PRIVATE_COMMENTS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "RESTRICTED_AGENT"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SUSPENDED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "DEFAULT_GROUP_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REPORT_CSV"
	type = "VARIANT"
	nullable = true
}


column {
	name = "USER_FIELDS_ADMIN_OR_CAREGIVER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_AMS_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_BRANCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_CELL_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_DEPARTMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_DIRECT_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_EXTENSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_HIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_HOME_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_PAYROLL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_PAYROLL_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_PERSONAL_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_FIELDS_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO_CONTENT_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO_CONTENT_URL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO_DELETED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PHOTO_FILE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO_HEIGHT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PHOTO_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PHOTO_INLINE"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PHOTO_MAPPED_CONTENT_URL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO_SIZE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PHOTO_THUMBNAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO_URL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO_WIDTH"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "URL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(9,0)"
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
	type = "NUMBER(1,0)"
	nullable = true
}

}

