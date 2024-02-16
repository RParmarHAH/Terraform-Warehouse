resource "snowflake_table" "DISC_STAGE_ADAPTIVE_CONTRACTCODE_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "ADAPTIVE_CONTRACTCODE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.ADAPTIVE_CONTRACTCODE_MAPPING

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
	name = "OFFCENO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DFDESCRIPTION"
	type = "VARCHAR(100)"
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
	name = "LASTWEEKEND"
	type = "DATE"
	nullable = true
}

}

