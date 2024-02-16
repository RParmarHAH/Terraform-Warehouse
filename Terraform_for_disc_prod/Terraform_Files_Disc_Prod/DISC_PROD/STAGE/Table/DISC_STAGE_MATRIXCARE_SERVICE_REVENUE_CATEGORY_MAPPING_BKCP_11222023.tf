resource "snowflake_table" "DISC_STAGE_MATRIXCARE_SERVICE_REVENUE_CATEGORY_MAPPING_BKCP_11222023" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "MATRIXCARE_SERVICE_REVENUE_CATEGORY_MAPPING_BKCP_11222023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.MATRIXCARE_SERVICE_REVENUE_CATEGORY_MAPPING_BKCP_11222023

    -- Purpose : Discovery Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SVCC_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SVCC_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SVCC_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_LINE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICE_LINE_SUBCATEGORY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICE_LINE_SUBCATEGORY_NAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "BILLABLE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYABLE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MILEAGE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}

}

