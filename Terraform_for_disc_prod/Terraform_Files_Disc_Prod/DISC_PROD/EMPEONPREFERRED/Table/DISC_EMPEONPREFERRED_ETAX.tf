resource "snowflake_table" "DISC_EMPEONPREFERRED_ETAX" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "ETAX"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.ETAX

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
	name = "CO"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FILINGSTATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXEMPTIONS"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "EXEMPTIONS2"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "OVERRIDETAXCALC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULTTAX"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RECIPROCAL"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ADDITIONALAMOUNT"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "ADDITIONALPERCENTAGE"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "LOWWAGECREDIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPECIALCHECKCALC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "NUMBER(3,0)"
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
	name = "PERCENTOFGROSS"
	type = "NUMBER(9,6)"
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
	name = "ADDLTAXDATA1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERINCOMEAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OTHERDEDUCTIONAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OTHERCREDITAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ADDLTAXOPTION1"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDLTAXOPTION2"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDLTAXOPTION3"
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

