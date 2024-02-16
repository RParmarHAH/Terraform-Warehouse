resource "snowflake_table" "DISC_PUBLIC_DFIMPORT_DATAFLEXTIMESHEETS_FULLLOAD_20231227" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DFIMPORT_DATAFLEXTIMESHEETS_FULLLOAD_20231227"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.DFIMPORT_DATAFLEXTIMESHEETS_FULLLOAD_20231227

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTTASKID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISVALID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SAVEDTODATAFLEX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRACKINGID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLLDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICENO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPERVISORCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVVCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TYPECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHANGEDBYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUDITNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEQUENCENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

