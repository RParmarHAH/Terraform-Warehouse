resource "snowflake_table" "DISC_EMPEONPREFERRED_CCALENDARDETAILIMPORT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "CCALENDARDETAILIMPORT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.CCALENDARDETAILIMPORT

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
	name = "CO"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "CALENDARID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "BATCH"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICEGUID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "JOB"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "QUEUEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "QUEUEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "GUIDFIELD"
	type = "VARCHAR(36)"
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
	name = "IMPORTPROPS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IMPORTFILENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "IMPORTFILESIZE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "IMPORTFILECREATIONDATE"
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

