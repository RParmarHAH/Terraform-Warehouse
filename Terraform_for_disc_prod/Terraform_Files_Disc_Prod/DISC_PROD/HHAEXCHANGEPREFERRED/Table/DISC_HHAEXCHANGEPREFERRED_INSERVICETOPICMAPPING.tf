resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_INSERVICETOPICMAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "INSERVICETOPICMAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.INSERVICETOPICMAPPING

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

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
	name = "INSERVICETOPICID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INSERVICEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TOPICID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
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

