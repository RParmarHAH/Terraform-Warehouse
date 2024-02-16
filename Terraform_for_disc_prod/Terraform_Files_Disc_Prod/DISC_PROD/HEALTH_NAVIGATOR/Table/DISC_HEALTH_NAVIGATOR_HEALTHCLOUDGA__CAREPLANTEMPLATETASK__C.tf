resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_HEALTHCLOUDGA__CAREPLANTEMPLATETASK__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "HEALTHCLOUDGA__CAREPLANTEMPLATETASK__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.HEALTHCLOUDGA__CAREPLANTEMPLATETASK__C

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
	name = "HEALTHCLOUDGA__PRIORITY__C"
	type = "VARCHAR(255)"
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
	name = "HEALTHCLOUDGA__CATEGORY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SORTORDER__C"
	type = "NUMBER(15,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ASSIGNEDTO__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DESCRIPTION__C"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANTEMPLATEPROBLEM__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TYPE__C"
	type = "VARCHAR(255)"
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
	name = "HEALTHCLOUDGA__OFFSET__C"
	type = "NUMBER(15,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANTEMPLATE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANTEMPLATEGOAL__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ACTIVE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SUBJECT__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__STATUS__C"
	type = "VARCHAR(255)"
	nullable = true
}

}

