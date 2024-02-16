resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_PAYROLL_BATCH_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "PAYROLL_BATCH_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PAYROLL_BATCH_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

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
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "BATCHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEEKSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WEEKEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TOTALHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTALOTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTALAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTALOTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "QBEXPORTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ADJHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCHSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PRIOROTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PRIORHOLIDAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTALHOLIDAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PRIOROTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRIORHOLIDAYHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTALHOLIDAYHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SKILLTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYROLLSETUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CURRENTEXPENSEAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PRIOREXPENSEAMOUNT"
	type = "NUMBER(18,2)"
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
	name = "PAYROLLDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYROLLUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MINVISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MAXVISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CURRENTMILEAGEAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PRIORMILEAGEAMOUNT"
	type = "NUMBER(18,2)"
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
	name = "LASTMODIFIEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TRAVELTIMETOTALHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMETOTALOTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMETOTALAMOUNT"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "TRAVELTIMETOTALOTAMOUNT"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "TRAVELTIMEADJAMOUNT"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "TRAVELTIMEADJHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMEPRIOROTAMOUNT"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "TRAVELTIMEPRIOROTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMETOTALHOLIDAYHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMETOTALHOLIDAYAMOUNT"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "TRAVELTIMEPRIORHOLIDAYHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMEPRIORHOLIDAYAMOUNT"
	type = "NUMBER(18,6)"
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

