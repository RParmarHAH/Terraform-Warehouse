resource "snowflake_table" "DISC_EMPEONEDISON_SYS_IPV6_DATABASE_FIREWALL_RULES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "SYS_IPV6_DATABASE_FIREWALL_RULES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.SYS_IPV6_DATABASE_FIREWALL_RULES

    -- Purpose : Discovery Data Population

    -- Project : EMPEONEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "NAME"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "START_IPV6_ADDRESS"
	type = "VARCHAR(45)"
	nullable = true
}


column {
	name = "END_IPV6_ADDRESS"
	type = "VARCHAR(45)"
	nullable = true
}


column {
	name = "CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MODIFY_DATE"
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

