resource "snowflake_table" "DISC_CCSI_MASTERCLIENT_LATEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "MASTERCLIENT_LATEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.MASTERCLIENT_LATEST

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
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CCU_CONTRACT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CCU_AGREEMENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CCU_PROGRAM_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_IDOA_NO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RELOOK_EARLY_WARNING_FLAG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DETERMINATION_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASSESSMENT_SCORE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INITIAL_SERVICE_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AVAIL_INCOME"
	type = "VARCHAR(10000)"
	nullable = true
}


column {
	name = "NUMBER_RECEIVING"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVED_BY_FAMILY_MEMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FEE_SCHEDULE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "A_TYPE_SERVICE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTION_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ACTION_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VENDOR_MAX"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VENDOR_FEIN_AG_PT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "UNUSED_3"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NSP_FLAG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UNUSED_6"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNUSED_4"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNUSED_14"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USED_FOR_AREA"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVU50_FLAG"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "UNUSED_6_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNUSED_4_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNUSED_14_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMBINED_CLIENT_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "UPDATE_FLAG"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SERVICE_1_UNITS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SERVICE_2_UNITS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SERVICE_3_UNITS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PHONE_NO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COPAY_Y_N_P"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "COPAY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "EMPLOYEE_NO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DESK_NO_ASSIGNED_SERV_COORD"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DOB"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SEX"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "COPAY_RESPONSIBLE_PARTY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RELATIONSHIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP_2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CASE_ACTION_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AREA"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIVATE_PAY_RATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FAMILY_REASON"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "MEDICAID_RECP_Y_N_P"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CCU_LOOKUP_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CCU_FEIN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCY_PHONE_CONTACT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCY_NAME_CONTACT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIVATE_PAY_BILLING_CYCLE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LAST_BILLING_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NEW_FIELD_OLD_SSN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HMKR_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CASE_MGR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CPT_NO_VET_MCO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIAG_NO_VET_MCO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MULTIPLE_CLIENT_FLAG"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CHOPPED_COMBINED_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MCO_AUTHORITY_ENDS_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LANGUAGE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RACE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHARED_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY_OPTED_OUT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SCHED"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CORP_FLAG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVU60"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTION_BY_USER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REGION_AREA"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CASE_MGR_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_ON"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATED_BY_2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UPDATED_ON"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UPDATED_BY_2"
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

