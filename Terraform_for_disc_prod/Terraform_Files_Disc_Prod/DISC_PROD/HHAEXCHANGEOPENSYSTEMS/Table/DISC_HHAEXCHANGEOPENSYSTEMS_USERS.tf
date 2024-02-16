resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_USERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "USERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.USERS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USERID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "USERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ROLE"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "PENDINGPLACEMENTNOTIFICATIONS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLINICALPATHWAYONCALLUSER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ROLEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CANOVERRIDEOTLIMIT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLINICALUSER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DAYSTOSHOWOPENCASES"
	type = "NUMBER(3,0)"
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

