resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_CAREGIVEREXPENSES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "CAREGIVEREXPENSES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.CAREGIVEREXPENSES

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
	name = "CAREGIVEREXPENSEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXPENSETYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXPENSETYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPENSEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILLABLE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "QUANTITY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYABLE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "BILLEDRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BILLTOTALS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYTOTAL"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYROLLBATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYROLLBATCHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLEXPORTCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYEXPORTCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ENTRYDATE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
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

