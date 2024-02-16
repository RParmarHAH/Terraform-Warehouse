resource "snowflake_table" "DISC_PUBLIC_SANDATA_SCHEDULE_CLIENTS_TEMP_20230522" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "SANDATA_SCHEDULE_CLIENTS_TEMP_20230522"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.SANDATA_SCHEDULE_CLIENTS_TEMP_20230522

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTSCHEDHDRID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTSCHEDDTLID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNITTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COPAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DURATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEDUNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONSUMPTIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDAT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEDAT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HASHEDROWVALUES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

