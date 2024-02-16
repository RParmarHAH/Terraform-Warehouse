resource "snowflake_table" "DW_HAH_FACT_VISIT_EXCEPTION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_VISIT_EXCEPTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_VISIT_EXCEPTION

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "VISIT_EXCEPTION_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "VISIT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "EXCEPTION_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SERVICE_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "EXCEPTION_CODE"
	type = "VARCHAR(100)"
	nullable = false
	comment = "Code of the Error raised during the verification of visit"
}


column {
	name = "ACKNOWLEDGED_FLAG"
	type = "BOOLEAN"
	nullable = true
	comment = "Indicator if the exception was acknowledged"
}


column {
	name = "RESOLVED_FLAG"
	type = "BOOLEAN"
	nullable = true
	comment = "Indicator if the exception was resolved"
}


column {
	name = "REASON_CODE"
	type = "VARCHAR(200)"
	nullable = true
	comment = "Code of the reason due to which the exception happened"
}


column {
	name = "REASON_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RESOLUTION_CODE"
	type = "VARCHAR(500)"
	nullable = true
	comment = "Code of the resolution that was implemented to resolve the exception"
}


column {
	name = "RESOLUTION_NAME"
	type = "VARCHAR(500)"
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

