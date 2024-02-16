resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_HEALTHCLOUDGA__CONTACTCONTACTRELATION__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "HEALTHCLOUDGA__CONTACTCONTACTRELATION__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.HEALTHCLOUDGA__CONTACTCONTACTRELATION__C

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
	name = "POWER_OF_ATTORNEY__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SL_EXTERNAL_ID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__EXTERNALID__C"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__STARTDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CONTACT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ENDDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__RELATEDCONTACT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCARE_AGENT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INVERSERELATIONSHIP__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ACTIVE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ROLE__C"
	type = "VARCHAR(18)"
	nullable = true
}

}

