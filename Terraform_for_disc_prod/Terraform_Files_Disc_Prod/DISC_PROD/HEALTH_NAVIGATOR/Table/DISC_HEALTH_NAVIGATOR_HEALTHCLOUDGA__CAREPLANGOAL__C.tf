resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_HEALTHCLOUDGA__CAREPLANGOAL__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "HEALTHCLOUDGA__CAREPLANGOAL__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.HEALTHCLOUDGA__CAREPLANGOAL__C

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
	name = "HEALTHCLOUDGA__PRIORITY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CATEGORY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SORTORDER__C"
	type = "NUMBER(15,2)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DESCRIPTION__C"
	type = "VARCHAR(32768)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANPROBLEM__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "COMPLETED_DATE_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "TIME_OPEN_IN_DAYS__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLAN__C"
	type = "VARCHAR(18)"
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
	name = "ACCOUNT__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANTEMPLATE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PROGRESS__C"
	type = "NUMBER(18,4)"
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


column {
	name = "HEALTHCLOUDGA__ACTIVITYDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "TIME_OPEN__C"
	type = "NUMBER(18,2)"
	nullable = true
}

}

