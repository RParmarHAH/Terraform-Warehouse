resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_RATES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_RATES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_RATES

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RATE_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "RATE_OVERRIDETYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RATE_RATETYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RATE_SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RATE_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RATE_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RATE_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "RATE_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "RATE_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "RATE_RATE1"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RATE_RATE2"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RATE_RATE3"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RATE_RATE4"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RATE_RATE5"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RATE_RATE6"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RATE_UNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "RATE_UNITSPECIFIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RATE_NOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RATE_EFFECTIVESTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RATE_EFFECTIVEENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RATE_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RATE_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RATE_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RATE_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RATE_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RATE_OTRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
	type = "BOOLEAN"
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

