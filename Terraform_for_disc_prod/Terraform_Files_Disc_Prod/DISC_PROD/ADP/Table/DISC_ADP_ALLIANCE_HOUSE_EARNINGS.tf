resource "snowflake_table" "DISC_ADP_ALLIANCE_HOUSE_EARNINGS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "ALLIANCE_HOUSE_EARNINGS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.ALLIANCE_HOUSE_EARNINGS

    -- Purpose : Discovery Data Population

    -- Project : ADP

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_EARNINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLASSIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULT_FIELD_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHORT_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHORT_DESCRIPTION_FR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCUMULATORS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INCLUDE_IN_TOTAL_HOURS_WORKED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_AND_ATTENDANCE_PAY_CODES"
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
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "DATE"
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

