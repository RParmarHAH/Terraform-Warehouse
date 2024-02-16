resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_ACCOUNTCONTACTRELATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "ACCOUNTCONTACTRELATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.ACCOUNTCONTACTRELATION

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
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACCOUNTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ROLES"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "CONTACTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARY__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ROLLUPS__C"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISDIRECT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARYGROUP__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

