resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_PAYROLLBATCHDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "PAYROLLBATCHDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.PAYROLLBATCHDETAILS

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
	name = "AUTOID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCHNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BATCHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERFIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERLASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERSSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MRNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REGULARHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REGULARPAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "REGULARPAYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGULARAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OVERTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OVERTIMEPAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OVERTIMEAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOLIDAYHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOLIDAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORIGINALPAYTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLLWEEKENDINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DIFFERENTIALHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DIFFERENTIALRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "DIFFERENTIALAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BILLINGSERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SSVCID"
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

