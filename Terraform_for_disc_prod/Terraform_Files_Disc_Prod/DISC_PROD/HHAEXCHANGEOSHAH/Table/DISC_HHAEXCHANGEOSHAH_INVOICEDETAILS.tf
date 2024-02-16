resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_INVOICEDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "INVOICEDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.INVOICEDETAILS

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
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICEDETAILID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "INVOICEHEADERID"
	type = "NUMBER(10,0)"
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
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHEDULESTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEENDTIME"
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
	name = "BILLEDHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLEDRATE"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "OVERTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OVERTIMERATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TRAVELTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMERATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BILLEDUNITS"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "THIRDPARTY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVSERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVPAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVRATETYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUTHORIZATIONNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NONBILLABLE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYMENTSTATUS"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "PAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "VARCHAR(1)"
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

