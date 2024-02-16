resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_SURVEYQUESTION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "SURVEYQUESTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.SURVEYQUESTION

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
	name = "VALIDATIONTYPE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "QUESTIONTYPE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PAGENAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PAGEDISPLAYORDER"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
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
	name = "SURVEYPAGEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ISDEPRECATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QUESTIONNAME"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SURVEYVERSIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "QUESTIONORDER"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "DEVELOPERNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

