resource "snowflake_table" "DISC_SANDATAIMPORT_SANDATA_PAYMENTDETAILS_20231117" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "SANDATA_PAYMENTDETAILS_20231117"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.SANDATA_PAYMENTDETAILS_20231117

    -- Purpose : Discovery Data Population

    -- Project : SANDATAIMPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DETAILID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYMENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICEDETAILID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENTAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

