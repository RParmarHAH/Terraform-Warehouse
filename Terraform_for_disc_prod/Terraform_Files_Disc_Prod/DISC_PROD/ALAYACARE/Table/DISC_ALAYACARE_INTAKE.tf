resource "snowflake_table" "DISC_ALAYACARE_INTAKE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "INTAKE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.INTAKE

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
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REFERRAL_SOURCE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REQUEST_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "OFFER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "RESPONSE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REFERRAL_TRANSMISSION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFER_TRANSMISSION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXPIRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROCESS_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REFUSAL_COMMENTS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INTAKE_SERVICE_TYPE_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INTAKE_SERVICE_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INTAKE_RISK_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REFERRAL_CASELOAD"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REFERRAL_POSTED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "REFERRAL_PROCESSED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ACCEPTED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "REFUSED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "EXPIRED"
	type = "NUMBER(1,0)"
	nullable = true
}

}

