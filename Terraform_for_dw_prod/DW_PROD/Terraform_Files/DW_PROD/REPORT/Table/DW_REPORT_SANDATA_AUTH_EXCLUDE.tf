resource "snowflake_table" "DW_REPORT_SANDATA_AUTH_EXCLUDE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "SANDATA_AUTH_EXCLUDE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.SANDATA_AUTH_EXCLUDE

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED_NON_ADJUSTED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "CNT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "KEYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "KEYCNT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HHAX_PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "HHAX_CONTRACT_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HHAX_SERVICE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HHAX_PARTNER_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HHAX_CONTRACT_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HHAX_SERVICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HHAX_PARTNER_NAME"
	type = "VARCHAR(100)"
	nullable = true
}

}

