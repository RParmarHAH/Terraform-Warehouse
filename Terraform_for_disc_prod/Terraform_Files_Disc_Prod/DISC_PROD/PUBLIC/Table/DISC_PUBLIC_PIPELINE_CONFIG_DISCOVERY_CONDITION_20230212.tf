resource "snowflake_table" "DISC_PUBLIC_PIPELINE_CONFIG_DISCOVERY_CONDITION_20230212" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "PIPELINE_CONFIG_DISCOVERY_CONDITION_20230212"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.PIPELINE_CONFIG_DISCOVERY_CONDITION_20230212

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
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SOURCESYSTEM"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "SCHEMANAME"
	type = "VARCHAR(500)"
	nullable = false
}


column {
	name = "TABLENAME"
	type = "VARCHAR(1000)"
	nullable = false
}


column {
	name = "DISCCONDITION"
	type = "VARCHAR(500)"
	nullable = false
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}

}

