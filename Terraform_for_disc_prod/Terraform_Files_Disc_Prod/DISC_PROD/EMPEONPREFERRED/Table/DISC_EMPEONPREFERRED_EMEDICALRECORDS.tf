resource "snowflake_table" "DISC_EMPEONPREFERRED_EMEDICALRECORDS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "EMEDICALRECORDS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.EMEDICALRECORDS

    -- Purpose : Discovery Data Population

    -- Project : EMPEONPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "MEDICALRECORDID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DATECOMPLETED"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPIRATIONDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLASSCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROVIDER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DECLINED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RESULT"
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

