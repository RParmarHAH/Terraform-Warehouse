resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_DIAGNOSIS_REASON_INTERVENTION__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "DIAGNOSIS_REASON_INTERVENTION__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.DIAGNOSIS_REASON_INTERVENTION__C

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
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTH_CONDITION__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REASON_INTERVENTION__C"
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
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

