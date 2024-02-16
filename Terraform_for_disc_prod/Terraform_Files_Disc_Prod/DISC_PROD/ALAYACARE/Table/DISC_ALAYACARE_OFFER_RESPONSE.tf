resource "snowflake_table" "DISC_ALAYACARE_OFFER_RESPONSE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "OFFER_RESPONSE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.OFFER_RESPONSE

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
	name = "RESP_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFER_GUID_TO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFER_STATUS_UPDATE_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFER_CREATION_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RESP_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RESP_UPDATE_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFER_DUE_DATE_ID"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFER_STATUS_UPDATE_DATE_ID"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFER_CREATION_DATE_ID"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESP_UPDATE_DATE_ID"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFER_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESP_COMMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESP_ACTIVE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RESP_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESP_RECEIVED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "REC_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

