resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_VISIT_2__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "VISIT_2__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.VISIT_2__C

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
	name = "ASSIGNED_TO__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOTE__C"
	type = "VARCHAR(32768)"
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
	name = "SUB_TYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "START_DATE_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_DATE_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MODALITY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "STATUS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

