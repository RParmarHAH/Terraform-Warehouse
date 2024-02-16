resource "snowflake_table" "DISC_ADP_ALLIANCE_PAYCODE_SOURCE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "ALLIANCE_PAYCODE_SOURCE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.ALLIANCE_PAYCODE_SOURCE

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
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DEDUCTION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DEDUCTION_TYPE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULED"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "GROUP"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACCUMULATOR"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ARREARS"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "DISBURSED"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "VITALITY"
	type = "VARCHAR(2)"
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

