resource "snowflake_table" "DISC_ASR_ASR_GENERATED_INTAKES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_GENERATED_INTAKES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_GENERATED_INTAKES

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICEVISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALENDAR_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DAY_NAME"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DERIVED_VISIT_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_VISIT_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CUSTOMERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITSTARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURSASSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKDAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECURRENCETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

