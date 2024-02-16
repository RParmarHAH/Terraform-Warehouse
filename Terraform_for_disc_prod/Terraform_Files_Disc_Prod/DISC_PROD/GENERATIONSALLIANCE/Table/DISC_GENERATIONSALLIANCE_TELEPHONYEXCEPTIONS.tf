resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TELEPHONYEXCEPTIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TELEPHONYEXCEPTIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TELEPHONYEXCEPTIONS

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
	name = "SCHEDULEEXCEPTIONID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "EXCEPTIONID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "INT_PATTIID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACKNOWLEDGED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RESOLUTIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXCEPTIONNOTE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
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

