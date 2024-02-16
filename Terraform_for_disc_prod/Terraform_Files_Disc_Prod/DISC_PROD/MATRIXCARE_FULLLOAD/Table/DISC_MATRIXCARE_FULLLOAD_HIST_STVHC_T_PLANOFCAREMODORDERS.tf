resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_PLANOFCAREMODORDERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_PLANOFCAREMODORDERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PLANOFCAREMODORDERS

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
	name = "POCMORD_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "POCMORD_POCID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCMORD_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMORD_TAKENBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCMORD_GIVENBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCMORD_DIAGNOSISID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMORD_PHYSICIANID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCMORD_SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMORD_ORDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCMORD_OCCURENCEPERPATTERNFREQUENCYMIN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCMORD_OCCURENCEPERPATTERNFREQUENCYMAX"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCMORD_PATTERNFREQUENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCMORD_PATTERNINTERVAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCMORD_RANGEMAXFREQUENCY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMORD_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCMORD_DUEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMORD_SENTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMORD_SECONDSENTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMORD_DATERECEIVED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMORD_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMORD_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCMORD_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMORD_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCMORD_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "POCMORD_SEQUENCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMORD_FREQUENCIES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "POCMORD_ASSESSMENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCMORD_ORDERPROCESSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMORD_ORDERSTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMORD_ORDERASSESSMENTHISTORYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCMORD_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMORD_RECEIVEDVIA"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCMORD_ORDERDATE"
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

