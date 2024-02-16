resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PLANOFCAREMEDICATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PLANOFCAREMEDICATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PLANOFCAREMEDICATIONS

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
	name = "POCMED_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "POCMED_POCID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCMED_ORDERDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_DISCONTINUEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_NEWCHANGE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "POCMED_MEDID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMED_DOSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCMED_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCMED_FREQUENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMED_ROUTEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMED_HOURS_1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_HOURS_2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_HOURS_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_HOURS_4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_HOURS_5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_HOURS_6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_PHYSICIANID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCMED_NOTES"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "POCMED_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCMED_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCMED_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCMED_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "POCMED_OASISMEDNAME"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "POCMED_SEQUENCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCMED_ASSESSMENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCMED_GUID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "POCMED_TYPE"
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

