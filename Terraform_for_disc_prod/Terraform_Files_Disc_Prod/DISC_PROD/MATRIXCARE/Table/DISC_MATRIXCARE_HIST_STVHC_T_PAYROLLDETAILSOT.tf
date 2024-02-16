resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PAYROLLDETAILSOT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PAYROLLDETAILSOT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PAYROLLDETAILSOT

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
	name = "PROLLDOT_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PROLLDOT_PAYROLLBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLDOT_BATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLDOT_RECORDID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLDOT_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLDOT_SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLDOT_RATIOOFHOURSINCLUDEDINWEEK"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_WEEKLYTOTALHOURSFOROT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_BLENDEDRATE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_PRORATEOTAMOUNT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_PRORATEOTHOURS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_PORTIONFORBLENDEDRATE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_WEEKLYHOURSLIMIT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLDOT_PRORATEFOROTEXEMPT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_ACTUALHOURS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_PAYAMOUNT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_TOTALWEEKPAYAMOUNT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_WEEKLYHOURS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_ACCUMWEEKLYHOURS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_ACCUMDAILYHOURS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_NOTWORKINGHRS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLDOT_ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLDOT_SCHEDULEDURATION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_WEEKNUM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLDOT_WEEKSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLDOT_WEEKENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLDOT_DAYNO"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLDOT_DAYSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLDOT_DAYENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLDOT_DAILYTOTALHOURS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_DAILYOTUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_DAILYOTLIMIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLDOT_TOTALDAILYOTUNITSPERWEEK"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_WEEKLYOTUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_OTMULTIPLIER"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_RATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLDOT_UNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_ISWEEKLY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLDOT_HASSEVENDAYOT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROLLDOT_TOTALPAY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLDOT_DAILYOTORDER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PROLLDOT_RANKED"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PROLLDOT_ADJUSTMENTHRS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_ADJUSTMENTAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLDOT_WEEKLYHOURSFOROT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_DAILYHOURSFOROT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROLLDOT_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLDOT_BATCHTS"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLDOT_ISEXPENSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROLLDOT_RECORDTOTALPAYMENT"
	type = "NUMBER(38,6)"
	nullable = true
}


column {
	name = "PROLLDOT_OTPAYMENT"
	type = "NUMBER(38,6)"
	nullable = true
}


column {
	name = "PROLLDOT_OTUNITS"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "PROLLDOT_RECORDUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLDOT_PAYROLLTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLDOT_PAYROLLADJID"
	type = "NUMBER(19,0)"
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

