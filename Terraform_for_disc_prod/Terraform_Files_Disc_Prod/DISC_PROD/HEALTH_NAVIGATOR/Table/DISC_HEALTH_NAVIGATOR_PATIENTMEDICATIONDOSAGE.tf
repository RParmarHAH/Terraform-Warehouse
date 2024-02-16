resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_PATIENTMEDICATIONDOSAGE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "PATIENTMEDICATIONDOSAGE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.PATIENTMEDICATIONDOSAGE

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
	name = "SITEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DOSAGEUNITID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DOSAGERATEUNITID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DOSAGEDEFINITIONTYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PATIENTINSTRUCTION"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "ISASNEEDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "METHODID"
	type = "VARCHAR(18)"
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
	name = "DOSEPREREQUISITEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SOURCESYSTEMMODIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DOSAGEQUANTITYDENOMINATOR"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PARENTRECORDID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMINGID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DOSAGERATENUMERATOR"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "ROUTEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SEQUENCE"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "ADDITIONALINSTRUCTION"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DOSAGERATETYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DOSAGEQUANTITYTYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DOSAGERATEDENOMINATOR"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "DOSAGEQUANTITYNUMERATOR"
	type = "NUMBER(6,2)"
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
	name = "SOURCESYSTEM"
	type = "VARCHAR(64)"
	nullable = true
}

}

