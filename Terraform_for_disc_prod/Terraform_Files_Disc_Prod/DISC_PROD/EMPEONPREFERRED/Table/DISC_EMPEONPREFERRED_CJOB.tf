resource "snowflake_table" "DISC_EMPEONPREFERRED_CJOB" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "CJOB"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.CJOB

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
	name = "JOBCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OVERRIDESHIFT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OVERRIDERATECODE"
	type = "VARCHAR(10)"
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
	name = "CERTIFIEDJOB"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RATEMULTIPLIER"
	type = "NUMBER(14,6)"
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
	name = "CMSLABORJOBCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OBSOLETE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FEDEIN"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FINALFILINGQ"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FINALFILINGY"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "LOCALTAXCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LOCALTAXID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SITWFREQ"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATEEIN"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUIRATE"
	type = "NUMBER(4,3)"
	nullable = true
}


column {
	name = "SUITAXID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUBJECTWP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PBJCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HPPDTYPE"
	type = "VARCHAR(10)"
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

