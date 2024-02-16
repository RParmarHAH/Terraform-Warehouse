resource "snowflake_table" "DISC_ALAYACARE_CLAIMS_HISTORICAL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLAIMS_HISTORICAL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLAIMS_HISTORICAL

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
	name = "CLAIM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REVISION_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILLCODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICED_AT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJUDICATION_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ISSUES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "UPDATE_FLOW"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REVENUE_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REVENUE_CODE_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PATIENT_DISCHARGE_STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLAIM_PRIORITY_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELAY_REASON_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROCEDURE_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROCEDURE_MODIFIER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "QUANTITY"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "TOTAL_BILLED"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "TOTAL_PAID"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "TOTAL_ADJUSTED"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "BALANCE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "REVISION_FROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

