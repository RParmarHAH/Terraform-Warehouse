resource "snowflake_table" "DISC_PUBLIC_RCM_MO_DW_20230124" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "RCM_MO_DW_20230124"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.RCM_MO_DW_20230124

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INVOICE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYOR_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AMOUNT_OUTSTANDING"
	type = "NUMBER(38,3)"
	nullable = true
}

}

