resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_SCHEDULERECURRENCE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_SCHEDULERECURRENCE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_SCHEDULERECURRENCE

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SCHREC_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "SCHREC_DESCRIPTION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SCHREC_OCCURRENCEDURATION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHREC_OCCURRENCESTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHREC_PATTERNDAYOFMONTH"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_PATTERNDAYSOFWEEK"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_PATTERNFREQUENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_PATTERNINTERVAL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHREC_PATTERNMONTHOFYEAR"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_PATTERNOCCURRENCEOFDAYINMONTH"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_PATTERNTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_RANGEENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHREC_RANGELIMIT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_RANGEMAXOCCURRENCES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHREC_RANGEMAXFREQUENCY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHREC_RANGESTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHREC_ROOTAPPOINTMENT"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHREC_ORIGINALSTARTDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHREC_ORIGINATEDFROMID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHREC_ORIGINTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_TIMEZONEID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCHREC_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHREC_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHREC_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHREC_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHREC_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCHREC_FIRSTDAYOFWEEK"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHREC_LASTGENDATE"
	type = "DATE"
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

