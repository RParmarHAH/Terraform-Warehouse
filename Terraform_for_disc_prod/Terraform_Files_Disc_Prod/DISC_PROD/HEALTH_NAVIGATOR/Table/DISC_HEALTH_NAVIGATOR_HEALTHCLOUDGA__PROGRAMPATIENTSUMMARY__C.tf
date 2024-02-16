resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_HEALTHCLOUDGA__PROGRAMPATIENTSUMMARY__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "HEALTHCLOUDGA__PROGRAMPATIENTSUMMARY__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.HEALTHCLOUDGA__PROGRAMPATIENTSUMMARY__C

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
	name = "HEALTHCLOUDGA__RISKSCORE__C"
	type = "NUMBER(8,3)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__NEWPATIENT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__NUMBEROFCONDITIONS__C"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ACCOUNT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PROGRAMPATIENTAFFILIATION__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ENROLLMENTTYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__UNIQUE__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__EFFECTIVEDATE__C"
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
	name = "HEALTHCLOUDGA__MOSTRECENT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__AGE__C"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MONTH__C"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TIMESPENT__C"
	type = "NUMBER(4,0)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__HCCCODES__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INSTITUTION__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__STAGE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__GENDER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__AGEBAND__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__LOWINCOME__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CONDITIONS__C"
	type = "VARCHAR(131072)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DISABILITYSTATUS__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__YEAR__C"
	type = "VARCHAR(4)"
	nullable = true
}

}

