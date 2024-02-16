resource "snowflake_table" "DISC_BI_REPOSITORY_HIST_SANDATAVISITS_TEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	name = "HIST_SANDATAVISITS_TEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.BI_REPOSITORY.HIST_SANDATAVISITS_TEST

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
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "AGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHEDULEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "SERVICEID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "EVVTIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVVTIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVVDURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "SCHEDULEDTIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDTIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDDURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "PAYORNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ADMISSIONTYPE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHARTID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CLIENTLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENTFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENTMIDDLEINITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STAFFAGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STAFFFIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFMIDDLEINITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADDEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDEDFILENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTUPDATEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTUPDATEDFILENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PLANID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VERIFICATIONTYPE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "NUMBER(10,0)"
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

