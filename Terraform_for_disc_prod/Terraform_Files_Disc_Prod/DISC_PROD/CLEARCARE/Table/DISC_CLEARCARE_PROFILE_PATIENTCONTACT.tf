resource "snowflake_table" "DISC_CLEARCARE_PROFILE_PATIENTCONTACT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "PROFILE_PATIENTCONTACT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.PROFILE_PATIENTCONTACT

    -- Purpose : Discovery Data Population

    -- Project : CLEARCARE

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
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTACT_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PRIMARY_CONTACT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RELATION_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SAVE_ME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROVIDER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAMILY_ROOM_INVITE_MEMBERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_CREATE_TODOS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_SCHEDULE_EVENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_MANAGE_MEDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_CONTACT_ADMINS_CAREGIVERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_ADMINISTRATOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_SHOW_INVOICES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EPAYER_CONTACT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_IS_ACCESSIBLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMAIL_INVOICES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_SHOW_AUTHS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRINT_ON_CARE_PLAN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARE_PLAN_PRINT_ORDER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FRANCHISOR_ID"
	type = "NUMBER(38,0)"
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

