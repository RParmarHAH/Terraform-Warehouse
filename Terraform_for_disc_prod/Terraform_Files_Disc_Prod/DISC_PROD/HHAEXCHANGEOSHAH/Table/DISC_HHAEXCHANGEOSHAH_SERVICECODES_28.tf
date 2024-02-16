resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_SERVICECODES_28" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "SERVICECODES_28"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.SERVICECODES_28

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICECODEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATETYPETEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCIPLINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MUTUAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLOWPATIENTSHIFTOVERLAP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BYPASSPREBILLINGVALIDATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BYPASSBILLINGREVIEWVALIDATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DELAYREASONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYRATES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOLIDAYCODETOWEEKDAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKDAYEXPORTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYEXPORTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKDAYREVENUECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYREVENUECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKDAYTAXONOMYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYTAXONOMYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKDAYHCPCSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYHCPCSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKDAYGLCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKENDHOLIDAYGLCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AREATYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICECATEGORYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVENUECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

