resource "snowflake_table" "DISC_ALAYACARE_SERVICE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "SERVICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.SERVICE

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_ADDRESS_OVERRIDDEN"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_REVISION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICE_EPISODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CONTACT_ID_VALUES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_BILLING_CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_STATUS_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_INSTRUCTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUNDING_METHODOLOGY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSIGNED_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REASON_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_DATAFLEX_CONTRACT_IDS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFILE_MEDICAID_PRIOR_AUTHORIZATION_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_STATUS_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICE_STATUS_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICE_PROJECTED_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICE_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WORKFLOW_STEP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_BILL_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_LAST_VISIT_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICE_FIRST_VISIT_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICE_VISIT_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LENGTH_OF_STAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CREATION_FIRST_VISIT_DAYS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_FACILITY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "SERVICE_ADD_TO_ASSOCIATED_EMPLOYEE"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "SERVICE_HAS_ACTIVITY_CODE"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "SERVICE_SEQUENCE_BY_CLIENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PERCENTAGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYMENT_METHOD_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENT_METHOD_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REASON_CODE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENT_DIAGNOSIS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_CARE_PLAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_CREATE_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_CREATE_USER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_DISPLAY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_FUNDING_METHODOLOGY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_GUID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDDEPTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDMASTERACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDPAYROLLITEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDSERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IS_ADDRESS_OVERRIDDEN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IS_DISABLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IS_PROVIDED_ON_HOLD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_PROGRAM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_SCHEDULE_RULE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_SERVICE_INSTRUCTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_SERVICE_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_STATUS_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_TIMEZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_UPDATE_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_UPDATE_USER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_WORKFLOW_STEP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GUID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

