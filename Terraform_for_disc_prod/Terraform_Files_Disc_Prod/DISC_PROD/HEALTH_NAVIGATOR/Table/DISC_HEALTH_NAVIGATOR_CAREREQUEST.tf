resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_CAREREQUEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "CAREREQUEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.CAREREQUEST

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
	name = "REOPENEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DECISIONREASON"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DECISIONDAYSREMAINING"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "RESOLUTIONNOTES"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MEMBERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SERVICEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CAREREQUESTCASEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "REQUESTINGPRACTITIONERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "REOPENREASON"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DECISIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EFFECTIVEFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DUEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EFFECTIVETO"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESOLUTIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADMISSIONTYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CLINICALCASETYPE"
	type = "VARCHAR(40)"
	nullable = true
}

}

