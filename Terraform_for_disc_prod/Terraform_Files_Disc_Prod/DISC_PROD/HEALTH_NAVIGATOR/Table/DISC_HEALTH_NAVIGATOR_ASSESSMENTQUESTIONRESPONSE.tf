resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_ASSESSMENTQUESTIONRESPONSE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "ASSESSMENTQUESTIONRESPONSE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.ASSESSMENTQUESTIONRESPONSE

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
	name = "QUESTION_TEXT__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "PARENTASMTQUESTIONVERSIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISTRUEORFALSEVALUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
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
	name = "DATEVALUE"
	type = "DATE"
	nullable = true
}


column {
	name = "RESPONSEVALUE"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "DECIMALRESPONSEVALUE"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "TIMEVALUE"
	type = "VARCHAR(16777216)"
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
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESPONDENTTIMEZONE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RESPONSETYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASSESSMENTQUESTIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CHOICEVALUE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CURRENCYVALUE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "ASSESSMENTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESPONSETEXT"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "INTEGERRESPONSEVALUE"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

