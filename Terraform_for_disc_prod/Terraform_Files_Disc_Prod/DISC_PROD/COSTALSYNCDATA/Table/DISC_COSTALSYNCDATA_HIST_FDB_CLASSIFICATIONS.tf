resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_FDB_CLASSIFICATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_FDB_CLASSIFICATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_FDB_CLASSIFICATIONS

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLASSID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DESCRIPTION1"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "DESCRIPTION2"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "DESCRIPTION3"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "DESCRIPTION4"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "DESCRIPTION5"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "DESCRIPTION6"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "ULTIMATECHILDIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DIRECTDRUGLINKIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PARENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FORMULARYLEVELIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PRESENTATIONSEQNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ULTIPARENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HIERARCHYLEVEL"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SORTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RETIREDIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "RETIREDDATE"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "ALTCODE"
	type = "VARCHAR(20)"
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

