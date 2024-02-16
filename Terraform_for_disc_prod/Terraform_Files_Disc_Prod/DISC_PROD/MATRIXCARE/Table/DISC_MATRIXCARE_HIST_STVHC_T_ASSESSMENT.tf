resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_ASSESSMENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_ASSESSMENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_ASSESSMENT

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
	name = "ASMT_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "ASMT_ADMISSIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ASMT_POCID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ASMT_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ASMT_STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASMT_ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASMT_PROCESSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ASMT_STATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ASMT_USERASSESSMENTDATA"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ASMT_OASISASSESSMENTDATA"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ASMT_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASMT_CONFIGURATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ASMT_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASMT_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASMT_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASMT_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASMT_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ASMT_COPIEDFROMASSESSMENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ASMT_BATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ASMT_INTEGRATEDASSESSMENTDATA"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ASMT_SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ASMT_CLIENTINQUIRYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ASMT_IDENTIFIERENCRYPTED"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ASMT_ACTIVITYID"
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

