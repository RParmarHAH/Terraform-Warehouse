resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_SURVEYFEED" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "SURVEYFEED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.SURVEYFEED

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
	name = "PARENTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "BESTCOMMENTID"
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
	name = "TITLE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "LINKURL"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "INSERTEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COMMENTCOUNT"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "RELATEDRECORDID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LIKECOUNT"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "BODY"
	type = "VARCHAR(10000)"
	nullable = true
}


column {
	name = "ISRICHTEXT"
	type = "BOOLEAN"
	nullable = true
}

}

