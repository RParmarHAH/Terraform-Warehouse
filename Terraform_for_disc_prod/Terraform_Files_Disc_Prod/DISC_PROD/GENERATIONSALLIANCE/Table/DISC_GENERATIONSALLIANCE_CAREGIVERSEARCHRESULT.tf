resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CAREGIVERSEARCHRESULT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CAREGIVERSEARCHRESULT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CAREGIVERSEARCHRESULT

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
	name = "CGSEARCHRESULTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICEREQUESTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLASSIFICATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLASSNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MESSAGEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTYID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DATEFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATETHRU"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENTNEEDS"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "DAYS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "AVAILABLEPERCENTAGE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MATCHCGSKILLSTOCLIENTNEEDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDEAPPLICANT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOWSCHDULEHOUR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REPORTNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SELECTEDCOLUMNS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "ISMINTIMEBETWEENSHIFTSENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MINTIMEBETWEENSHIFTS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SHOWOTALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROXIMITY"
	type = "NUMBER(10,0)"
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

