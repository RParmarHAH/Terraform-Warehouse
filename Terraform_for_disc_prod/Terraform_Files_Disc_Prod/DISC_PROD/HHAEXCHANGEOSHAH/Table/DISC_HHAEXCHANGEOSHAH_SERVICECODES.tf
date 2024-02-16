resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_SERVICECODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "SERVICECODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.SERVICECODES

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
	name = "SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RATETYPETEXT"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "DISCIPLINE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CONTRACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISITTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MUTUAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ALLOWPATIENTSHIFTOVERLAP"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BYPASSPREBILLINGVALIDATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BYPASSBILLINGREVIEWVALIDATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "LOCATIONCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DELAYREASONCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYRATES"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "HOLIDAYCODETOWEEKDAY"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WEEKDAYEXPORTCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYEXPORTCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKDAYREVENUECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYREVENUECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKDAYTAXONOMYCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYTAXONOMYCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKDAYHCPCSCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYHCPCSCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKDAYGLCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYGLCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AREATYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICECATEGORYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REVENUECODE"
	type = "VARCHAR(50)"
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

