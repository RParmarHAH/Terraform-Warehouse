resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_TELEPHONYCALLS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_TELEPHONYCALLS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_TELEPHONYCALLS

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
	name = "TCL_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "TCL_TELEPHONYACCOUNTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TCL_PURPOSE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TCL_CAREGIVERTELEPHONYID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "TCL_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TCL_CAREGIVERMATCHSTATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TCL_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TCL_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TCL_CLIENTMATCHSTATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TCL_PHONENUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TCL_SERVERCALLID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TCL_CALLTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TCL_STATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "TCL_SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TCL_COMPLETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TCL_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TCL_HIDDEN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TCL_CLIENTTELEPHONYID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "TCL_FLAGS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TCL_OVERFLOW"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TCL_CLIENTNAMELIST"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TCL_LOCATION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TCL_ACCURACY"
	type = "NUMBER(6,3)"
	nullable = true
}


column {
	name = "TCL_EVENTTYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TCL_OVERRIDDEN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TCL_CLIENTLOCATION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TCL_CERTIFYCORRECT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TCL_CERTIFYNOTES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TCL_OVERRIDETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TCL_OVERRIDETIMEUTCOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TCL_OVERRIDETIMEZONEID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TCL_MACHINEIPADDRESS"
	type = "VARCHAR(50)"
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

