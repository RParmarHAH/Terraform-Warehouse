resource "snowflake_table" "DISC_STAGE_ADAPTIVE_PAYCODE_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "ADAPTIVE_PAYCODE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.ADAPTIVE_PAYCODE_MAPPING

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
	name = "OFFICENO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "PAYCODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICETYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}

}

