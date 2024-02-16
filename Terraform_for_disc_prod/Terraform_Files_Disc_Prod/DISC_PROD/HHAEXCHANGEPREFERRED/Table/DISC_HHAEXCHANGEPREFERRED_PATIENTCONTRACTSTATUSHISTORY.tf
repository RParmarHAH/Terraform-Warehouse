resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_PATIENTCONTRACTSTATUSHISTORY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "PATIENTCONTRACTSTATUSHISTORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.PATIENTCONTRACTSTATUSHISTORY

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
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTPLACEMENTLOGID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PLACEMENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOTE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(200)"
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

