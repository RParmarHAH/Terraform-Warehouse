resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_SCHEDULESHIFT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_SCHEDULESHIFT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_SCHEDULESHIFT

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
	name = "SCHSH_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHSH_SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHSH_EXPENSEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHSH_STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHSH_ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHSH_NO"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCHSH_HOLLIDAYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHSH_HOLLIDAYADD"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "SCHSH_HOLLIDAYMULT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHSH_RATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHSH_RATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHSH_UNIT"
	type = "NUMBER(18,8)"
	nullable = true
}


column {
	name = "SCHSH_UNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCHSH_RATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHSH_OTUNIT"
	type = "NUMBER(8,4)"
	nullable = true
}


column {
	name = "SCHSH_OTMULTI"
	type = "NUMBER(8,4)"
	nullable = true
}


column {
	name = "SCHSH_BALANCE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHSH_DRAFTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHSH_CONTRACTRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHSH_CONTRACTRATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHSH_CONTRACTRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHSH_COBINVOICEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHSH_SCHEDULEPAYERSCHECKSUM"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHSH_MANAGECOB"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHSH_OTRATE"
	type = "NUMBER(18,8)"
	nullable = true
}


column {
	name = "SCHSH_OTCALCTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHSH_OTRATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHSH_OTUNITSSUBTRACT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHSH_TOTALCHARGE"
	type = "NUMBER(36,12)"
	nullable = true
}


column {
	name = "SCHSH_SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHSH_SCHEDULESERVICEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHSH_BATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHSH_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHSH_SEQUENCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHSH_SHIFTCOUNT"
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

