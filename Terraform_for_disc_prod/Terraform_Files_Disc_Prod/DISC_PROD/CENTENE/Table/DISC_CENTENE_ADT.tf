resource "snowflake_table" "DISC_CENTENE_ADT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CENTENE"
	name = "ADT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CENTENE.ADT

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
	name = "MEDICAID_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MBI"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RECIPIENT_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEMBER_COUNTY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEMBER_ZIP_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEMBER_LAST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEMBER_FIRST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DOB"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FACILITY_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FACILITY_TAX_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FACILITY_NPI"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEMBER_PCP_FNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEMBER_PCP_LNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PCP_NPI"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADMITTING_MD_FNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADMITTING_MD_LNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADMITTING_MD_NPI"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADMIT_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DISCHARGE_DISPOSITION"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "ADMIT_DT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DSCHRG_DT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DISCHRG_DX"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADMIT_DX"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CHC_PLAN_CD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "LOAD_DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "USER_AUTH"
	type = "VARCHAR(32)"
	nullable = false
}

}

