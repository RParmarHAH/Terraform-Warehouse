resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_REFERRALSUBMISSIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "REFERRALSUBMISSIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.REFERRALSUBMISSIONS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

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
	name = "REFERRALSUBMISSIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUBMITTEDTO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUBMITTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FOLLOWUPDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REJECTEDSUBMISSIONREASON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NOTE"
	type = "VARCHAR(1500)"
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

