resource "snowflake_table" "DISC_BI_REPOSITORY_HIST_LOCATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	name = "HIST_LOCATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.BI_REPOSITORY.HIST_LOCATIONS

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
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SYSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXTERNALLOCATIONID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LOCSYS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DF_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAYROLLFREQ"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYROLLBASEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EVVLIVE"
	type = "DATE"
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

