resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PAYROLLDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PAYROLLDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PAYROLLDETAILS

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
	name = "PROLLD_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PROLLD_PAYROLLBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_CHECKTRANSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLD_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_PAYROLLCOMPANYEMPLOYEEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_SCHEDULEEXPENSEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_SHIFTNO"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PROLLD_BRANCHHOLIDAYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_HOLIDAYMULTIPLIER"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLD_HOLIDAYADDITION"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_SERVICEENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLD_SERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLD_SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLD_NOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PROLLD_DEDUCTIONEARNING"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PROLLD_RATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_RATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLD_RATEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_UNITS"
	type = "NUMBER(18,8)"
	nullable = true
}


column {
	name = "PROLLD_PAYUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PROLLD_OT_DAYUNITS"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "PROLLD_OT_DAYMULTIPLIER"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "PROLLD_OTDAYRATETYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLD_OT_WEEKUNITS"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "PROLLD_OT_WEEKMULTIPLIER"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "PROLLD_OTWEEKRATETYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLD_EARNCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_OVERRIDEDEPARTMENT"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PROLLD_OVERRIDEDIVISION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_OVERRIDEBRANCH"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_OVERRIDESTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_OVERRIDELOCAL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_JOB"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_VACATION"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_LOAN"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_FEE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_OTHER"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_MISC"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_HOLIDAY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_ADVANCE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_AMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_SOURCETS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROLLD_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLD_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLD_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLD_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROLLD_OTWEEKLYHOURS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLD_PAYOT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLD_WEEKSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLD_WEEKENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLD_OTADJUSTEDUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLD_OTADJUSTEDRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_TOTALAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_PAYROLLADJID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_TOTALPAYMENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_ADDON"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_PRIMARYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLD_ADDONRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLD_TOTALDETAILAMOUNT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLD_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLD_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLD_ISEXPENSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROLLD_CAREXCLUDEOT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROLLD_BRANCHID"
	type = "NUMBER(10,0)"
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

