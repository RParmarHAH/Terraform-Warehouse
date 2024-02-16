resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_PAYROLLOTPERIODSHIFTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_PAYROLLOTPERIODSHIFTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_PAYROLLOTPERIODSHIFTS

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
	name = "OTS_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTS_PERIODID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTS_PAYROLLDETAILSID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTS_PERIODSHIFTSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTS_PERIODSHIFTENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTS_PERIODSHIFTELIGIBLEPAY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OTS_SEQ"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTS_DURATION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTS_LEGACYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTS_DRAFTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTS_ACCUMULATEDDURATION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTS_OTELIGIBLEMINUTES"
	type = "NUMBER(5,0)"
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

