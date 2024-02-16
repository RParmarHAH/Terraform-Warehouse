resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_ASSESSMENTQUESTIONVERSION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "ASSESSMENTQUESTIONVERSION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.ASSESSMENTQUESTIONVERSION

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
	name = "DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ACTIVATIONDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISOPTIONSOURCERESPONSEVALUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QUESTION_SECTION__C"
	type = "VARCHAR(255)"
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
	name = "DEACTIVATIONDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATATYPE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "QUESTIONTEXT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ADDITIONALINFORMATION"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HELPTEXT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "VERSIONNUMBER"
	type = "NUMBER(9,0)"
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
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RESPONSEVALUES"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "QUESTION_SECTION_SUB_TYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}

}

