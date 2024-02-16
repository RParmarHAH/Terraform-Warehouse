resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_SURVEYQUESTIONSCORE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "SURVEYQUESTIONSCORE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.SURVEYQUESTIONSCORE

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
	name = "SURVEYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "QUESTIONSKIPPEDCOUNT"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "QUESTIONCHOICEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "QUESTIONDEVELOPERNAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RESPONSECOUNT"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "SURVEYINVITATIONID"
	type = "VARCHAR(18)"
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
	name = "SCORE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CUMULATIVESCORE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "QUESTIONID"
	type = "VARCHAR(18)"
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
	name = "RESPONSEVALUE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SURVEYVERSIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SCORETYPE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DATERESPONSE"
	type = "DATE"
	nullable = true
}

}

