resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_PAYROLLOTALLOCATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_PAYROLLOTALLOCATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_PAYROLLOTALLOCATIONS

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
	name = "OTA_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTA_PERIODSHIFTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTA_ALLOCATIONSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTA_ALLOCATIONENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTA_RULEID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTA_MULTIPLIER"
	type = "NUMBER(8,4)"
	nullable = true
}


column {
	name = "OTA_TOTALALLOCATEDMINUTES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTA_TOTALALLOCATEDOTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OTA_DRAFTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTA_RULEOTTYPEID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTA_LEGACYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OTA_SEQ"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTA_THRESHOLDMINUTES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTA_OTPAYROLLDETAILSID"
	type = "NUMBER(19,0)"
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

