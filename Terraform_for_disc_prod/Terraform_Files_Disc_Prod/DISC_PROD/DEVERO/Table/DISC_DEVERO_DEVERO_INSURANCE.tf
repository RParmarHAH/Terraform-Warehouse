resource "snowflake_table" "DISC_DEVERO_DEVERO_INSURANCE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_INSURANCE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_INSURANCE

    -- Purpose : Discovery Data Population

    -- Project : DEVERO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INSURANCE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUIRES_THERAPY_COMPLIANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PDGM_EFFECTIVE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUIRES_EVV"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_MODIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
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

