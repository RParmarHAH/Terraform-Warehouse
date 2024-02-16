resource "snowflake_table" "DISC_ASR_ASR_TASKS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_TASKS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_TASKS

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
	name = "TASKID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENTTASKID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASKNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASKDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTTASKID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAXTASKCOMPLETIONHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEGATEEARNINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASKTAG"
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

