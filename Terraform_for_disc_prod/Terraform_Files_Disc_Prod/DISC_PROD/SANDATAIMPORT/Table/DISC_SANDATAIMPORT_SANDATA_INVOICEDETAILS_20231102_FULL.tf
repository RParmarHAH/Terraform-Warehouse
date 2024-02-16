resource "snowflake_table" "DISC_SANDATAIMPORT_SANDATA_INVOICEDETAILS_20231102_FULL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "SANDATA_INVOICEDETAILS_20231102_FULL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEDETAILS_20231102_FULL

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
	name = "INVOICELINEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUSID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATEFROM"
	type = "DATE"
	nullable = true
}


column {
	name = "DATETHRU"
	type = "DATE"
	nullable = true
}


column {
	name = "DURATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNITTYPEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HCPCS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODIFIERS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NETAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REASONCODES"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

