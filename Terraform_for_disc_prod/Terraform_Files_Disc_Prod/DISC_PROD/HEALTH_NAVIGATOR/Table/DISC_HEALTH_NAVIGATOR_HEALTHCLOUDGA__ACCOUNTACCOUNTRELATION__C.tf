resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_HEALTHCLOUDGA__ACCOUNTACCOUNTRELATION__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "HEALTHCLOUDGA__ACCOUNTACCOUNTRELATION__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.HEALTHCLOUDGA__ACCOUNTACCOUNTRELATION__C

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
	name = "HEALTHCLOUDGA__EXTERNALID__C"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ACCOUNT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__STARTDATE__C"
	type = "DATE"
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


column {
	name = "HEALTHCLOUDGA__ENDDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "HEALTHCLOUDGA__RELATEDACCOUNT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ROLE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

