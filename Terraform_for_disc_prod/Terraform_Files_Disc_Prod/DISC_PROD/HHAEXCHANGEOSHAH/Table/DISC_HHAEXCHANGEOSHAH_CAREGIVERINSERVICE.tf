resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CAREGIVERINSERVICE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CAREGIVERINSERVICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CAREGIVERINSERVICE

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

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
	nullable = false
}


column {
	name = "CAREGIVERINSERVICEID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "INSERVICEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INSERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FROMTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "ENDTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "FROMENDTIME"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "TOPIC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "INSTRUCTOR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "HOURS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYROLLBILLED"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "NOSHOW"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NOSHOWTEXT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISSTATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ISSTATUSTEXT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BATCHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDBYUSER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATEDBYUSERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYRATEID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATECODE2"
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

