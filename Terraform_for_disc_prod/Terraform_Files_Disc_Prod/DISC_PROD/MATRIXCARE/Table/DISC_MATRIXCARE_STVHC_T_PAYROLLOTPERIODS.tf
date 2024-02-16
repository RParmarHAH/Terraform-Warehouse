resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_PAYROLLOTPERIODS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_PAYROLLOTPERIODS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_PAYROLLOTPERIODS

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OTP_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTP_PAYROLLBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTP_WEEKNUMBER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTP_WEEKYEAR"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTP_DAYNUMBER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTP_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTP_STARTDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTP_ENDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTP_TOTALOTELIGIBLEMINUTES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTP_TOTALOTELIGIBLEPAID"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OTP_BLENDEDRATE"
	type = "NUMBER(8,4)"
	nullable = true
}


column {
	name = "OTP_TOTALALLOCATEDOTMINUTES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTP_TOTALALLOCATEDOTPAID"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OTP_OTTHRESHOLDMINUTES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTP_OTCONFIG"
	type = "VARIANT"
	nullable = true
}


column {
	name = "OTP_ISWEEKRECORD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTP_PAYROLLTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTP_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTP_PARENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTP_HASLEGACYRECORDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTP_DRAFTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTP_WEEKSEQ"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTP_OTMULTIPLIER"
	type = "NUMBER(8,4)"
	nullable = true
}


column {
	name = "OTP_HASSEVENTHDAYOT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTP_WEEKOTPAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTP_TOTALMINUTES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
	type = "BOOLEAN"
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

