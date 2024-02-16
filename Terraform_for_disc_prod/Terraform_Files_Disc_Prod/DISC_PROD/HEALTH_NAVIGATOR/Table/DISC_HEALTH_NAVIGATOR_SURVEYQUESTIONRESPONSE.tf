resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_SURVEYQUESTIONRESPONSE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "SURVEYQUESTIONRESPONSE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.SURVEYQUESTIONRESPONSE

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
	name = "DATETIMEVALUE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESPONSEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RANK"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "ISTRUEORFALSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QUESTIONCHOICEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DATATYPE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESPONSESHORTTEXT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CHOICEVALUE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "NUMBERVALUE"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "QUESTIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DATEVALUE"
	type = "DATE"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESPONSEVALUE"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "SURVEYVERSIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "INVITATIONID"
	type = "VARCHAR(18)"
	nullable = true
}

}

