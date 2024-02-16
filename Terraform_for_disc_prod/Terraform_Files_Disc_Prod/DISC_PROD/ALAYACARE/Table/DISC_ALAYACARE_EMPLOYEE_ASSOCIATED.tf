resource "snowflake_table" "DISC_ALAYACARE_EMPLOYEE_ASSOCIATED" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYEE_ASSOCIATED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYEE_ASSOCIATED

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
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ASSOCIATION_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CONTINUITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_IDACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_IDBILLITEM"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_IDPAYROLLITEM"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_IDUSER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ASSOCIATION_START_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_DISPLAY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_GEOFENCE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_IDACCOUNTTYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_IDPROFILE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_IDSTATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_PHONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}

}

