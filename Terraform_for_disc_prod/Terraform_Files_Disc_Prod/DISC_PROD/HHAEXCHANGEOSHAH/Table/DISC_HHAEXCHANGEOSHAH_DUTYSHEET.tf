resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_DUTYSHEET" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "DUTYSHEET"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.DUTYSHEET

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DUTYSHEETID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCTASKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCTASKCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TASKNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CATEGORYNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDITIONALVALUE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "VISITPOCMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DUTYLISTSETUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DUTYLISTSETUPNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
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

