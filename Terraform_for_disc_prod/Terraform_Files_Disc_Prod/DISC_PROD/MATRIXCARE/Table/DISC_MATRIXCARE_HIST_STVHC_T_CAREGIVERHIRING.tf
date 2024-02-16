resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_CAREGIVERHIRING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_CAREGIVERHIRING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_CAREGIVERHIRING

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CARHR_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "CARHR_CARID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CARHR_APPLIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_INTERVIEWDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_HIREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_ORIENTATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_POSITION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CARHR_SEPARATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_SEPARATIONREASON"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CARHR_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CARHR_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CARHR_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CARHR_STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_INTERVIEWSTAFFID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CARHR_INTERVIEWSCHEDULED_ACTIVITYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CARHR_REFERRALDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_REFERRALTAKENBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CARHR_REFERRALENTITYTYPEID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CARHR_REFERRALENTITYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CARHR_REFERRALCONTACTJOINID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CARHR_REFERRALCAMPAIGNID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CARHR_STAFFID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CARHR_REFERRALNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CARHR_REFERRALTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CARHR_CAREGIVERSEPARATIONREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CARHR_REFERRALTAKENBYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CARHR_FIRSTSERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARHR_LASTSERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
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

