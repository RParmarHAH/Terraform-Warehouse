resource "snowflake_table" "DISC_ASR_HIST_ASR_CUSTOMERSCOMMUNICATIONLOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_CUSTOMERSCOMMUNICATIONLOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_CUSTOMERSCOMMUNICATIONLOG

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORDID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDDATETIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTEXTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ITEMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDTEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDFROM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUSPENDEDFROM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUSPENDEDTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIONTAKEN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESOLVED"
	type = "VARCHAR(16777216)"
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
	type = "BOOLEAN"
	nullable = true
}

}

