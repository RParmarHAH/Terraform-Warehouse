resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_ACTIVITIES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_ACTIVITIES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_ACTIVITIES

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
	name = "ACT_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ACT_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACT_STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACT_ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACT_ACTIVITYCATEGORYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACT_ACTIVITYTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACT_ACTIVITYRESULTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACT_SUBJECT"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "ACT_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACT_ACTIVITYSHARELEVELID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACT_RECURRENCEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ACT_ISRECURRINGAPPOINTMENTROOT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACT_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACT_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACT_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACT_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACT_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACT_FOLLOWUPDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACT_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACT_DISMISS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACT_REMINDERNOTES"
	type = "VARCHAR(2048)"
	nullable = true
}


column {
	name = "ACT_ASSOCIATEDCOSTS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ACT_LETTERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACT_DISPLAYONCALENDAR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACT_STARTOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ACT_ENDOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ACT_TIMEZONEID"
	type = "NUMBER(5,0)"
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

