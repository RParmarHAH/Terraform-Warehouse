resource "snowflake_table" "DISC_DEVERO_DEVERO_AUTHORIZATIONDETAILREPORT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_AUTHORIZATIONDETAILREPORT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_AUTHORIZATIONDETAILREPORT

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
	name = "AGENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHSTARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCIPLINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITTOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLIEDTOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITSREMAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DAYSREMAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
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

