resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CSVSCHEDULEIMPORT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CSVSCHEDULEIMPORT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CSVSCHEDULEIMPORT

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
	name = "CSVIMPORTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CSVIMPORTGUID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIENTTELEPHONYID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVERTELEPHONYID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DATEOFSERVICE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LOGIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LOGOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISSCHEDULECONFIRMED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MILEAGE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MESSAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IMPORTEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ISSUCCESS"
	type = "BOOLEAN"
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

