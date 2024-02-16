resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_IDENTIFIER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "IDENTIFIER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.IDENTIFIER

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
	name = "IDENTIFIERKEY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IDVALUE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PARENTRECORDID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ISSUINGAUTHORITYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IDTYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "SL_EXTERNAL_ID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SOURCESYSTEMIDENTIFIER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SOURCESYSTEMMODIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SOURCESYSTEM"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "IDUSAGETYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EFFECTIVEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

