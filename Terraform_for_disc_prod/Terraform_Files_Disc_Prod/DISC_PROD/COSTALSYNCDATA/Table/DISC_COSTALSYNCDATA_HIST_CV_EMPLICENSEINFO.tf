resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_EMPLICENSEINFO" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_EMPLICENSEINFO"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_EMPLICENSEINFO

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

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
	type = "VARCHAR(25)"
	nullable = false
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ENTRY_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NURSE_ID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "EMPLOYEE_LICENSE_NUMBER"
	type = "VARCHAR(15)"
	nullable = false
}


column {
	name = "LICENSE_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "LICENSE_NUMBER"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "LICENSE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATRT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END__DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "LICENSE_REQUIRED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NOTIFY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NOTIFICATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_NOTICE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IN_SERVICE_HRS_REQUIRED"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PRECEPT_HRS_REQUIRED"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PRECEPT_HRS_COMPLETED"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "DDL_LICENSE_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
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

