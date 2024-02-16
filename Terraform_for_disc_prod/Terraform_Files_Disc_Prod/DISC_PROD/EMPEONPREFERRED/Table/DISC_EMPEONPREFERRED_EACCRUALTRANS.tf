resource "snowflake_table" "DISC_EMPEONPREFERRED_EACCRUALTRANS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "EACCRUALTRANS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.EACCRUALTRANS

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
	name = "GUIDFIELD"
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
	name = "AMOUNT"
	type = "NUMBER(14,4)"
	nullable = true
}


column {
	name = "POSTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYHIST"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "PAYHISTSUB"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTIONCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTIONTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "POSTORDER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEESBANKID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "BANKCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CALENDARID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "BASEAMOUNT"
	type = "NUMBER(14,4)"
	nullable = true
}


column {
	name = "ACCRUALRATE"
	type = "NUMBER(14,4)"
	nullable = true
}


column {
	name = "TRANSTYPE"
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

