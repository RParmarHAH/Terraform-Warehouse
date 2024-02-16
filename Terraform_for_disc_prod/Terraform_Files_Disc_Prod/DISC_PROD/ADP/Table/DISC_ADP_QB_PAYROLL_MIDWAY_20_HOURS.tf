resource "snowflake_table" "DISC_ADP_QB_PAYROLL_MIDWAY_20_HOURS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "QB_PAYROLL_MIDWAY_20_HOURS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.QB_PAYROLL_MIDWAY_20_HOURS

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
	name = "COMPANY"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HOURS_TOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_REGULAR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_SK_SOC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_OT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_SICK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_BONUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_VAC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_SAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_OTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_PERDIEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_ALLOW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_REIMB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_MEDICAL_EXPENSES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_SK_RCT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_ON_CALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_TAXABLE_PER_DIEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_NON_SK_SOC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_OTHER_SN"
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

