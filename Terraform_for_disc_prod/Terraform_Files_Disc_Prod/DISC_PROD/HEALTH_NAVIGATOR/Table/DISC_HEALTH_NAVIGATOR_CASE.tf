resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_CASE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "CASE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.CASE

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
	name = "ORIGIN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACCOUNTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEMMODIFIED__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SUPPLIEDNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "SUPPLIEDPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MASTERRECORDID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CONTACTMOBILE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCEAGENCYMEASUREID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DUEDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SORTORDER__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEMID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CABH__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ISESCALATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEM__C"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCEAGENCYMEASUREVERSION__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CABH_INDICATOR__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__FINANCIALVALUE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SUPPLIEDCOMPANY"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "SOURCEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARE_GAP_SUBTYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CONTACTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ISCLOSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CONTACTPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCEAGENCY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LANGUAGE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CASENUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CONTACTFAX"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PARENTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CASE_TEAM_MERGE_BATCH_RUN__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUBJECT"
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
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CONTACTEMAIL"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "CLOSEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

