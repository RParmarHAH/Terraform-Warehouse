resource "snowflake_table" "DISC_GENERATIONSALLIANCE_SCHEDULESIGNATURE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "SCHEDULESIGNATURE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.SCHEDULESIGNATURE

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SCHEDULESIGNATUREID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CHARTINGID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHARTINGTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLIENTSIGN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERSIGN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTSIGNDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERSIGNDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERVOICEURL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENTVOICEURL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SIGNEDSCHEDULESTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNEDSCHEDULEEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERSIGNATUREMODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLIENTSIGNATUREMODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SERVICEAPPROVAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TIMETASKAPPPROVAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SIGNATUREMETHOD"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

