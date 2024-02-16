resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CAREPLANCATEGORY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CAREPLANCATEGORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CAREPLANCATEGORY

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CATEGORYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CATEGORYNAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SORTORDER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SELECTIONTYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBEROFQUESTIONS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NUMBEROFTEXTAREAS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREPLANTEMPLATEID"
	type = "NUMBER(10,0)"
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

