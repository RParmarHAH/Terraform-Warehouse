resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_ALLERGYINTOLERANCE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "ALLERGYINTOLERANCE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.ALLERGYINTOLERANCE

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
	name = "VERIFICATIONSTATUS"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "ALLERGY_INTOLERANCE_DETAILS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ONSETENDDATETIME"
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
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RECORDCREATORID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SOURCESYSTEMIDENTIFIER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ASSERTIONSOURCEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CODEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CLINICALENCOUNTERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SOURCESYSTEMMODIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(40)"
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
	name = "SEVERITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "LASTOCCURRENCEDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RECORDCREATIONDATETIME"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "ONSETSTARTDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SOURCESYSTEM"
	type = "VARCHAR(64)"
	nullable = true
}

}

