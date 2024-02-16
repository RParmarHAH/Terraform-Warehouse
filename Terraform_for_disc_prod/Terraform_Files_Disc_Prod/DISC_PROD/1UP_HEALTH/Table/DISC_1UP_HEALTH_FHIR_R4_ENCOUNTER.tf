resource "snowflake_table" "DISC_1UP_HEALTH_FHIR_R4_ENCOUNTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "FHIR_R4_ENCOUNTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.1UP_HEALTH.FHIR_R4_ENCOUNTER

    -- Purpose : Discovery Data Population

    -- Project : 1UP_HEALTH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ENCOUNTER_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ONEUP_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLASSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLASSDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSIONTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPEDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ATTENDER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMITTER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONSULTANT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERIODSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIODEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADMITSOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "READMISSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPECIALCOURTSEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPECIALARRANGEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGEDISPOSITIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGEDISPOSITIONDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEPROVIDERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEPROVIDERREFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METAEVENTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METAMESSAGETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METASOURCERECORDID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METAEVENTTIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "METAPROCESSTIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "METAPROCESSCLIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METASOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "METALASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

