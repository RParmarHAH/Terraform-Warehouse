resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_CASETEAMROLE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "CASETEAMROLE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.CASETEAMROLE

    -- Purpose : Discovery Data Population

    -- Project : HEALTH_NAVIGATOR

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
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PREFERENCESVISIBLEINCSP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ACCESSLEVEL"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

