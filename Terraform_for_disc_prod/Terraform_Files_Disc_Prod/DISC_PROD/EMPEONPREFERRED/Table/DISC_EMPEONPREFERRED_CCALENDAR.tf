resource "snowflake_table" "DISC_EMPEONPREFERRED_CCALENDAR" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "CCALENDAR"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.CCALENDAR

    -- Purpose : Discovery Data Population

    -- Project : EMPEONPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "CHECKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROCESSGROUP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PERIODBEGIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIODEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALENDARID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PERIODBEGUNUSERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULEDPROCESSDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTUALPROCESSDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROCESSUSERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROCESS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYROLLNOTES"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "STARTPAYROLLJOBID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "PROCESSPAYROLLJOBID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ONHOLD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROCESSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PACKEDUSERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PACKEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INTRANSITTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELIVEREDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELIVERYTRACKING"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "DELIVEREDBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TIMECLOCKIMPORTJOBID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "SUBMITPAYROLLJOBID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "BLOCKBILLING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOCKAGENCY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOCKTRANSFERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOCKACH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOCKTAXDEPOSITS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOCKACCRUALS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DELETEPRIORDEP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALENDARSCHEDULEID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "SEQUENCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BLOCKREPORTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOCKCHECKS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROCESSFINISHTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALCULATINGSTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TIMEACTUALPROCESSDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEAPPROVEDBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TIMEEXCLUDE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIMEPROCESSEDBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TIMESTATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TIMECALCSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALCULATINGJOBID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ISCONVERSION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISADJUSTMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIMEONLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHIPPINGSETTINGS"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "BLOCKARREARBATCH"
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

