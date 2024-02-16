resource "snowflake_table" "DISC_CENTENE_CENTENE_FULL_ROSTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CENTENE"
	name = "CENTENE_FULL_ROSTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CENTENE.CENTENE_FULL_ROSTER

    -- Purpose : Discovery Data Population

    -- Project : CENTENE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PARTNER_ID"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "MEDICAID_NBR"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "MEMBER_CURR_CK"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "SC_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DOB"
	type = "DATE"
	nullable = false
}


column {
	name = "ELIG_START_DT"
	type = "DATE"
	nullable = true
}


column {
	name = "DUAL_IND"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WELLCARE_IND"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WELLCARE_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAS_PROVIDER_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PAS_PROVIDER_TIN"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAS_PROVIDER_NP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RISK_SCORE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INPAT_COUNT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMERG_COUNT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MA_IR"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PAS_UNITS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ROLLING_6M_ER_VIS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ROLLING_2MORE_ER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PROGRAM_STATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INSERT_DT"
	type = "DATE"
	nullable = true
}


column {
	name = "PARTNER_FILENAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "LOADDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(50)"
	nullable = true
}

}

