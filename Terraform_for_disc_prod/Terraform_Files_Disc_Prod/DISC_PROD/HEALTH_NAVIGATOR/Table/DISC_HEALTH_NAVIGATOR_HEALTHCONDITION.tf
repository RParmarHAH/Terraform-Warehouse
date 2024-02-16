resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_HEALTHCONDITION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "HEALTHCONDITION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.HEALTHCONDITION

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
	name = "PROBLEMNAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ABATEMENTSTARTDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SITEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PROBLEMDESCRIPTION"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "STAGEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ICD10_CODE__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DIAGNOSTICSTATUS"
	type = "VARCHAR(40)"
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
	name = "CONDITIONCODEID"
	type = "VARCHAR(18)"
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
	name = "CONDITIONSTATUS"
	type = "VARCHAR(40)"
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


column {
	name = "ABATEMENTENDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

