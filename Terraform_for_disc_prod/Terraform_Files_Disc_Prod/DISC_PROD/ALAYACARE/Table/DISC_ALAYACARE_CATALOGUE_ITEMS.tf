resource "snowflake_table" "DISC_ALAYACARE_CATALOGUE_ITEMS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CATALOGUE_ITEMS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CATALOGUE_ITEMS

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
	name = "CATALOGUEITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_TYPE_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_TYPE_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_UNIT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_CATEGORY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_PRICE_PER_ITEM"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_BILLED_PER_ITEM"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CATALOGUE_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUE_OWNER_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_MAXIMUM_QUANTITY"
	type = "VARCHAR(250)"
	nullable = true
}

}

