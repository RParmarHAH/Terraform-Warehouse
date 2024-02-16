resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_PLANOFCAREORDERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_PLANOFCAREORDERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PLANOFCAREORDERS

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
	name = "POCORD_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "POCORD_ORDERDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCORD_POCID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCORD_SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCORD_ORDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCORD_OCCURENCEPERPATTERNFREQUENCYMIN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCORD_OCCURENCEPERPATTERNFREQUENCYMAX"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCORD_PATTERNFREQUENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCORD_PATTERNINTERVAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCORD_RANGEMAXFREQUENCY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCORD_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCORD_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCORD_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCORD_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCORD_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "POCORD_SEQUENCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCORD_FREQUENCIES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "POCORD_ASSESSMENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCORD_ORDERTIME"
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

