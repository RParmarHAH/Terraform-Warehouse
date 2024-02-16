resource "snowflake_table" "DISC_ALAYACARE_SERVICE_LABEL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "SERVICE_LABEL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.SERVICE_LABEL

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
	name = "SERVICE_LABEL_VALUE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LABEL_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LABEL_NAME_VALUE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_CUSTOM_LABEL_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_CUSTOM_LABEL_IDFUNDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_CUSTOM_LABEL_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_CUSTOM_LABEL_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_CUSTOM_LABEL_VALUE_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_CUSTOM_LABEL_VALUE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_CUSTOM_LABEL_VALUE_IDLABEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_CUSTOM_LABEL_VALUE_VALUE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_DISPLAY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_EXTERNAL_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_FUNDING_METHODOLOGY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDDEPTCODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDPAYROLLITEM"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDPROFILE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDSERVICECODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IDSTATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IS_ADDRESS_OVERRIDDEN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IS_DISABLED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_IS_PROVIDED_ON_HOLD"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_PROGRAM_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_SCHEDULE_RULE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_SERVICE_INSTRUCTIONS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_SERVICE_NOTES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_STATUS_REASON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_TIMEZONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_LOCATION_WORKFLOW_STEP"
	type = "VARCHAR(250)"
	nullable = true
}

}

