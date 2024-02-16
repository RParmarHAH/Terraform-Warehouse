resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_OVERTIMESUMMARY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "OVERTIMESUMMARY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.OVERTIMESUMMARY

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
	name = "OVERTIMESUMMARYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AIDEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "WEEKSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WEEKENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "APPROVEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "APPROVEDBY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OTREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
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

