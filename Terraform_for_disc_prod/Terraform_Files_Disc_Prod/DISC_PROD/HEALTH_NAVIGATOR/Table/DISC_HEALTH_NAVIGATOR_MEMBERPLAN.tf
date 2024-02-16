resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_MEMBERPLAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "MEMBERPLAN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.MEMBERPLAN

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
	name = "STATUS"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "ISSUERNUMBER"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "GROUPNUMBER"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "PLANID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PRIMARYCAREPHYSICIAN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MEMBERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PRIMARYSECONDARYTERTIARY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "SUBSCRIBERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RELATIONSHIPTOSUBSCRIBER"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MEMBERNUMBER"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "SOURCESYSTEM"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "EFFECTIVETO"
	type = "DATE"
	nullable = true
}


column {
	name = "AFFILIATION"
	type = "VARCHAR(64)"
	nullable = true
}

}

