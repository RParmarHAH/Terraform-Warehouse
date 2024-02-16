resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_PAYROLL_DETAILS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "PAYROLL_DETAILS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.PAYROLL_DETAILS_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

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
	name = "PAYROLLDETAILID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HEADERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITTIME"
	type = "VARCHAR(9)"
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
	name = "CONTRACTSERVICECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REGULARHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYAMOUNT"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "OTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTAMOUNT"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "PAYRATECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTPAYRATE"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "OTPAYRATECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACTSERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RATETYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INSERVICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICEDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYROLLWEEKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HOLIDAYHOURS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HOLIDAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DIFFERENTIALHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DIFFERENTIALRATE"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "DIFFERENTIALAMOUNT"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "HOLIDAYRATETYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WAGEPARITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICERATETYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYROLLSETUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATE2"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "OTPAYRATE2"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "HOLIDAYPAYRATE2"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERVACATIONID"
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
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

