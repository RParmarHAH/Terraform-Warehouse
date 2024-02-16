resource "snowflake_table" "DISC_RISKONNECT_CLIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "CLIENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.CLIENT

    -- Purpose : Discovery Data Population

    -- Project : RISKONNECT

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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(5)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "TIMESTAMP_NTZ(5)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(5)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(5)"
	nullable = true
}


column {
	name = "CONNECTIONRECEIVEDID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONNECTIONSENTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPERVISOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP_CODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BIRTH_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "BEGIN_SERVICE_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "PHONE_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTIVE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IDOA_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACTS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAST_VISIT_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "X2ND_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "END_SERVICE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "GENDER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIAGNOSIS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NOTES__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_NAME3__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
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


column {
	name = "ETL_DELETED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

