resource "snowflake_table" "DISC_CCSI_BRANCH_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "BRANCH_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.BRANCH_MAPPING

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
	name = "SRNO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TOLL_FREE_PHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(30)"
	nullable = true
}

}

