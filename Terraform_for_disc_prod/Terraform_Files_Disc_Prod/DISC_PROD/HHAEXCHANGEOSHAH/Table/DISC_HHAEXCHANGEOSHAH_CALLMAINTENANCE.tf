resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CALLMAINTENANCE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CALLMAINTENANCE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CALLMAINTENANCE

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
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MAINTENANCEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ASSIGNMENTID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CALLERID"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "DIALEDNUMBER"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CALLTYPE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "CALLTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALLDURATION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DUTYSHEET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DUTIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLUNIQUEID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EVVSOURCE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVVTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVVDEVICEID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVVTOKENID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVVCALLTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVVPATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "GPSDISTANCE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
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

