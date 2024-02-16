resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CAREGIVERCOMPLIANCEEXPITEMS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CAREGIVERCOMPLIANCEEXPITEMS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREGIVERCOMPLIANCEEXPITEMS_REPL

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
	name = "CAREGIVERCOMPLIANCEEXPITEMID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "EXPIRATIONITEMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXPIRATIONITEM"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXPIRATIONITEMTYPE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "COMPLIANCEEXPITEMRESULTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RESULT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DATECOMPLETED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COMPLIANT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DUEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCANGUID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "SCANFILENAME"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDBYUSER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEDBYUSER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCORE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PARENTEXPIRATIONITEMID"
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

