resource "snowflake_table" "DISC_EMPEONPREFERRED_EACCRUALBANK" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "EACCRUALBANK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.EACCRUALBANK

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
	name = "ID"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BANKCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CURRENTUSED"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "TOTALBALANCE"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "CURRENTACCRUED"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "OVERRIDE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OVERRIDE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OVERRIDE3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GUIDFIELD"
	type = "VARCHAR(36)"
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
	name = "AVAILABLEBALANCE"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "ACCRUALMAXOVERRIDE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BALANCEMAXOVERRIDE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CAPHOURSOVERRIDE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CARRYOVEROVERRIDE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RATEOVERRIDE"
	type = "NUMBER(18,8)"
	nullable = true
}


column {
	name = "USAGEMAXOVERRIDE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OVERRIDESTRATEGY"
	type = "VARCHAR(50)"
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

