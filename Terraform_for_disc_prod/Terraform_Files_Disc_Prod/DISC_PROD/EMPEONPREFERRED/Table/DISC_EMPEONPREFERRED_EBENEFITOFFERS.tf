resource "snowflake_table" "DISC_EMPEONPREFERRED_EBENEFITOFFERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "EBENEFITOFFERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.EBENEFITOFFERS

    -- Purpose : Discovery Data Population

    -- Project : EMPEONPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BENEFITOFFERID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EFFECTIVEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFERSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFEREND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEERESPONDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REJECTREASON"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "REJECTEDBYEMPLOYER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EVENTDETAILS"
	type = "VARCHAR(1000)"
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

