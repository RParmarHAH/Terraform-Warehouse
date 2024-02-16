resource "snowflake_table" "DISC_VIVENTIUM_EXPORTCHECKS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	name = "EXPORTCHECKS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.VIVENTIUM.EXPORTCHECKS

    -- Purpose : Discovery Data Population

    -- Project : VIVENTIUM

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEEKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVISIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "RUNNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERIODBEGINDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIODENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYMETHOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VOUCHERNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHECKORVOUCHERNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TOTALWORKEDHOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALHOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALGROSS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALDEDUCTIONS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALTAXES"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NETCHECKAMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NETDIRECTDEPOSITAMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALNET"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TAXES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TAXES_GROSSWAGES"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TAXES_TAXAMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TAXES_TAXCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXES_TAXABLEWAGES"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EARNINGS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "EARNINGS_EARNINGCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EARNINGS_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EARNINGS_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EARNINGS_CHARGEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EARNINGS_JOBCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_IN1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_OUT1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_IN2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_OUT2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_MEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_INTERNALMEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_COSTCENTERS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUCTIONS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "DEDUCTIONS_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "DEDUCTIONS_DEDUCTIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUCTIONS_MEMOONLY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUCTIONS_PAYEECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUCTIONS_PAYEEKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTERS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "COSTCENTERS_LEVEL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COSTCENTERS_LEVELCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTERS_COSTCENTERCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTERS_COSTCENTERDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTERS_GROUPCODE"
	type = "VARCHAR(16777216)"
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
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

