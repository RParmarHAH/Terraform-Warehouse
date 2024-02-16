resource "snowflake_table" "DISC_BI_REPOSITORY_EXTERNALIDS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	name = "EXTERNALIDS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.BI_REPOSITORY.EXTERNALIDS

    -- Purpose : Discovery Data Population

    -- Project : BI_REPOSITORY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SYSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LOCSYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TYP"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DBNAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INTIDSTR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LSTNAM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FSTNAM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MDLNAM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXTSYSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXTIDTYP"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EFFBEGDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EFFENDDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IGNORE"
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
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

