resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_DFTIMESHEETS_HISTORY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DFTIMESHEETS_HISTORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.DFTIMESHEETS_HISTORY

    -- Purpose : Discovery Data Population

    -- Project : DATAFLEXSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DBNAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REFERENCENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEEKENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYROLLDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVIEWED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUBMITTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MILEAGE"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "MILEAGEBILLED"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "HOURVALUES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDFLAG"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BILLEDSUPPLEMENTNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HIGHSUPPLEMENTNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAIDFLAG"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEBATCH"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "UPDATEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFCENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUPERVISORCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CHANGEDBY"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CHANGEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUDITTRAILNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SEQENCENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRACKINGID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISEVV"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TIMESHEETTYPE"
	type = "VARCHAR(1)"
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

