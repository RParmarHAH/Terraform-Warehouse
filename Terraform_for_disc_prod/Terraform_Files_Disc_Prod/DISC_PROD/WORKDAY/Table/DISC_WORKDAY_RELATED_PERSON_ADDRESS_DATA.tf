resource "snowflake_table" "DISC_WORKDAY_RELATED_PERSON_ADDRESS_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "RELATED_PERSON_ADDRESS_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.RELATED_PERSON_ADDRESS_DATA

    -- Purpose : Discovery Data Population

    -- Project : WORKDAY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RELATED_PERSON_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_LINE_DATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_LINE_DATA_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MUNICIPALITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBREGION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSTAL_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_IS_PUBLIC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_PRIMARY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LANDING_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCESSED_TIMESTAMP"
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


column {
	name = "FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

