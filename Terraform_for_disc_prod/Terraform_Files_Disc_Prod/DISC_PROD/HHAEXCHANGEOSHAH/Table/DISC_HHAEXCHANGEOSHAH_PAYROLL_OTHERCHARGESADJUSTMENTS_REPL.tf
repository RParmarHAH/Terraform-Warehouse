resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_PAYROLL_OTHERCHARGESADJUSTMENTS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "PAYROLL_OTHERCHARGESADJUSTMENTS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.PAYROLL_OTHERCHARGESADJUSTMENTS_REPL

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
	nullable = true
}


column {
	name = "PAYROLLOTHERCHARGESADJUSTMENTID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PAYROLLOTHERCHARGESDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVEREXPENSEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTHERCHARGEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "REGULARHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYRATE2"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "PAYRATECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RATETYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYROLLWEEKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHARGETYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHARGETYPENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OTHERCHARGESADJUSTMENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "WAGEPARITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATCHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TRAVELTIMEDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTAMOUNT"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "OTPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTPAYRATE"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "OTPAYRATECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTPAYRATE2"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "HOLIDAYHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HOLIDAYAMOUNT"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATE"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATE2"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "MILEAGEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
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

