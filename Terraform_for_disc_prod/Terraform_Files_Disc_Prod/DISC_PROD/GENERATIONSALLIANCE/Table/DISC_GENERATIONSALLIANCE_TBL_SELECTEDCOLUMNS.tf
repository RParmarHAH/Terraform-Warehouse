resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TBL_SELECTEDCOLUMNS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TBL_SELECTEDCOLUMNS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TBL_SELECTEDCOLUMNS

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INT_USERID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "BIT_LASTNAME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_FIRSTNAME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_MIDDLEINIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ADDRESS1"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ADDRESS2"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_CITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_COUNTY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_STATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ZIP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_VALIDDRIVERSLICENSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_SMOKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_WEIGHTRESTRICTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_WEIGHTLIMIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_CLASSIFICATIONID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_DATEOFBIRTH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_STATUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_STATUSDATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_INACTIVEDATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_EMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_PHONE1"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_PHONE2"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_BACKGROUNDCHECK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_CLASSNAME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_INDEPENDENTCONTRACTOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_TELEPHONYID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_DONOTREHIRE"
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

