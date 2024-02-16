resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_ACCOUNTTEAMMEMBER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "ACCOUNTTEAMMEMBER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.ACCOUNTTEAMMEMBER

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
	name = "CASEACCESSLEVEL"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "TEAMMEMBERROLE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ACCOUNTACCESSLEVEL"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONTACTACCESSLEVEL"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "OPPORTUNITYACCESSLEVEL"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHOTOURL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ACTIVE__C"
	type = "BOOLEAN"
	nullable = true
}

}

