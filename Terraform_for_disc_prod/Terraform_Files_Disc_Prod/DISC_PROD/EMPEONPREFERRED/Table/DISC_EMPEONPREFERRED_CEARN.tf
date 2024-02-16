resource "snowflake_table" "DISC_EMPEONPREFERRED_CEARN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "CEARN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.CEARN

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
	name = "ECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SHORTDESCRIPTION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EARNTYPE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "W2FIELD"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PRINTONCHECKSTUB"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MINIMUM"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "MAXIMUM"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "ANNUALMAXIMUM"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "OVERRIDERATE"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "ADDTORATE"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "RATEMULTIPLIER"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "OVERRIDESHIFT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "UNITDESCRIPTION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUTODROP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALCULATIONCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "UNITS"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "AGENCY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REDUCEAUTOPAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAXEXEMPT"
	type = "VARCHAR(7000)"
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
	name = "WORKED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OBSOLETE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLOCKWITHHOLDINGTAX"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HPPDTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ACAMEASUREMENT"
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

