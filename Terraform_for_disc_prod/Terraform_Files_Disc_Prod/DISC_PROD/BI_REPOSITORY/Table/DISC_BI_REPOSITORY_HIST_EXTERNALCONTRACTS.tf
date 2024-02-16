resource "snowflake_table" "DISC_BI_REPOSITORY_HIST_EXTERNALCONTRACTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	name = "HIST_EXTERNALCONTRACTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.BI_REPOSITORY.HIST_EXTERNALCONTRACTS

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
	nullable = false
}


column {
	name = "DBNAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INTCOD"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "EXTSYSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EXTID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AUTHMGMT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTHTYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AAACOD"
	type = "VARCHAR(20)"
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

