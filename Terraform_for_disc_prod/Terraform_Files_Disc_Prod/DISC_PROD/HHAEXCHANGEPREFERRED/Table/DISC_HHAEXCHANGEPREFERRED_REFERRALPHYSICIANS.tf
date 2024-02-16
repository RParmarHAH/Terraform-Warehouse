resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_REFERRALPHYSICIANS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "REFERRALPHYSICIANS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.REFERRALPHYSICIANS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALPHYSICIANID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYSICIANNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NOTE"
	type = "VARCHAR(3000)"
	nullable = true
}


column {
	name = "PRIMARYREFERRALPHYSICIAN"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PHONE1"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHONE3"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(15)"
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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

