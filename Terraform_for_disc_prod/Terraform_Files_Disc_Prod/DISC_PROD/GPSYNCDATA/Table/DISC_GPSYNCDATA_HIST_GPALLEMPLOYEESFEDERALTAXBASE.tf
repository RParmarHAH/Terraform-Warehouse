resource "snowflake_table" "DISC_GPSYNCDATA_HIST_GPALLEMPLOYEESFEDERALTAXBASE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_GPALLEMPLOYEESFEDERALTAXBASE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_GPALLEMPLOYEESFEDERALTAXBASE

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(15)"
	nullable = false
}


column {
	name = "FEDERALFILINGSTATUSCODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FEDERALFILINGSTATUSNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FEDERALMARITALSTATUS"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "FEDERALEXEMPT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FEDERALWITHHOLDING"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "ADDITIONALWITHHOLDING"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "ESTIMATEDWITHHOLDING"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LOCALTAXCODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "TAXWITHHOLDINGSTATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MARRIEDWITHHOLDINGASSINGLE"
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

