resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_CLINICALENCOUNTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "CLINICALENCOUNTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.CLINICALENCOUNTER

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
	name = "CATEGORY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "READMISSIONCODEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DESTINATIONORGANIZATIONID"
	type = "VARCHAR(18)"
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
	name = "DURATIONUNITID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "STARTDATE"
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
	name = "SERVICETYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "SOURCESYSTEMIDENTIFIER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SOURCESYSTEMMODIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PRIORITYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DESTINATIONFACILITYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DISCHARGEDISPOSITIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PREADMISSIONIDENTIFIERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "TYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "DIETPREFERENCE"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PREVIOUSORGANIZATIONID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SL_EXTERNAL_ID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLINICAL_ENCOUNTER_DETAILS__C"
	type = "VARCHAR(32768)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SPECIALCOURTESY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FACILITYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ADMISSIONSOURCE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARE_GAP__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PREVIOUSFACILITYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RELATEDCLINICALENCOUNTERID"
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

}

