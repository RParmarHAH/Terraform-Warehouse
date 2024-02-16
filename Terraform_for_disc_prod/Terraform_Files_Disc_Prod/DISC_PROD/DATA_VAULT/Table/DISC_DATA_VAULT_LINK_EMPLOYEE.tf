resource "snowflake_table" "DISC_DATA_VAULT_LINK_EMPLOYEE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_VAULT"
	name = "LINK_EMPLOYEE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_VAULT.LINK_EMPLOYEE

    -- Purpose : Discovery Data Population

    -- Project : DATA_VAULT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "LINK_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "HASH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEM_DB"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
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
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

