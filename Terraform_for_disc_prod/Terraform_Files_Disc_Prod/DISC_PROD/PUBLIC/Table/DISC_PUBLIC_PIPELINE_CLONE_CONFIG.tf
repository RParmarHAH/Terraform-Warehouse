resource "snowflake_table" "DISC_PUBLIC_PIPELINE_CLONE_CONFIG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "PIPELINE_CLONE_CONFIG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.PIPELINE_CLONE_CONFIG

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
	nullable = true
}


column {
	name = "SOURCESYSTEM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SOURCETYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TASKNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TASKGROUP"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "QUERY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENVIRONMENT"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "FLAG"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RUNTYPEFLAG"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LASTRUNDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSERTED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ORDER_BY"
	type = "NUMBER(38,0)"
	nullable = true
}

}

