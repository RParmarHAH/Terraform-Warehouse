resource "snowflake_table" "DISC_ALAYACARE_REQUISITION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "REQUISITION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.REQUISITION

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
	name = "REQUISITION_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REQUISITION_CREATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REQUISITION_REVISION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REQUISITION_CREATION_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REQUISITION_REVISION_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RECEIVE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "QUANTITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ADDITIONAL_INFORMATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
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

