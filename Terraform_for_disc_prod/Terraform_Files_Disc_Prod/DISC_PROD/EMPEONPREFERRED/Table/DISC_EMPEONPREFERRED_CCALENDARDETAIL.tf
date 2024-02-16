resource "snowflake_table" "DISC_EMPEONPREFERRED_CCALENDARDETAIL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "CCALENDARDETAIL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.CCALENDARDETAIL

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
	name = "DESCRIPTION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LASTEDITEDBY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LASTEDITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "APPROVEDBY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "APPROVEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EDITEDBY"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "PERIODBEGIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIODEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYGROUP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLFILTER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUTOPAYEMPLOYEES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTOPOSTRECURRING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULTCHECKATTRIBUTES"
	type = "VARCHAR(10)"
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
	name = "CALENDARSCHEDULEDETAILID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "SEQUENCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USERVERIFIEDRESULTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERVIEWEDREGISTER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DATACHANGEDAFTERREGISTERVIEWED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUDITPROCESSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYENTRYCOMPLETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTOINCLUDEEMPLOYEES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUDITPROCESSING"
	type = "BOOLEAN"
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

