resource "snowflake_table" "DISC_GENERATIONSALLIANCE_SANTRAXOHLOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "SANTRAXOHLOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.SANTRAXOHLOG

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
	name = "SANTRAXOHLOGID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "LOGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ERRORS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "UUID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PAYOR"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PAYORPROGRAM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PROCEDURECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROVIDERID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REQUESTID"
	type = "VARCHAR(40)"
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

