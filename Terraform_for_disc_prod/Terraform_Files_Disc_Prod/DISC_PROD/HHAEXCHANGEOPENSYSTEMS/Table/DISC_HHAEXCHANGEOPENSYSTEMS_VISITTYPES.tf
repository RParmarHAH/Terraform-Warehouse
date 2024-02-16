resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_VISITTYPES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "VISITTYPES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.VISITTYPES

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

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
	name = "VISITTYPEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ABBREVIATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AGENCYTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DOCTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOCSUBTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MASTERVISITTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WITHMDORDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "VISITTYPENAME"
	type = "VARCHAR(400)"
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

