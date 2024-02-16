resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_REFERRALDIAGNOSIS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "REFERRALDIAGNOSIS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.REFERRALDIAGNOSIS

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
	name = "REFERRALDIAGNOSISID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ICD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DIAGNOSISDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATETYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PRIMARYREFERRALDIAGNOSIS"
	type = "VARCHAR(3)"
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

