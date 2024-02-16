resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_MEDICATIONSTATEMENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "MEDICATIONSTATEMENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.MEDICATIONSTATEMENT

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
	name = "IS_VISIBLE_ON_PATIENT_CARD__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PARENTMEDICATIONSTATEMENTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "MEDICATIONCODEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "MEDICATIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASSERTIONDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DELIVERYSETTING"
	type = "VARCHAR(40)"
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
	name = "ENDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SOURCESYSTEMIDENTIFIER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MEDICATIONREASONID"
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
	name = "STATEMENTSOURCEID"
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
	name = "PROCEDUREID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUSREASONCODEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREOBSERVATIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "STARTDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MEDICATIONREQUESTID"
	type = "VARCHAR(18)"
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


column {
	name = "MEDICATIONREASONCODEID"
	type = "VARCHAR(18)"
	nullable = true
}

}

