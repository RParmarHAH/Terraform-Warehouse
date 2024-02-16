resource "snowflake_table" "DISC_SANDATAEXCHANGE_DFIMPORT_DATAFLEXTIMESHEETS_TEST_20231227" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAEXCHANGE"
	name = "DFIMPORT_DATAFLEXTIMESHEETS_TEST_20231227"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAEXCHANGE.DFIMPORT_DATAFLEXTIMESHEETS_TEST_20231227

    -- Purpose : Discovery Data Population

    -- Project : SANDATAEXCHANGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "IMPORTTASKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OPERATION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "KEY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISVALID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SAVEDTODATAFLEX"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "REFNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRACKINGID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PAYROLLDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WEEKENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFICENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUPERVISORCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "EVVCODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TYPECODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CHANGEDBYCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "AUDITNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SEQUENCENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
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

