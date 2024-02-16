resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_MILEAGE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "MILEAGE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.MILEAGE

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
	name = "MILEAGEID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "MILEAGEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "MILES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHIFT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATETEXT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "CONTRACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BILLRATEAFTERBILLED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYRATEAFTERPAYROLL"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYROLLBATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYROLLBATCHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVOICEHEADERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AUTHORIZATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTHORIZATIONNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLLOTHERCHARGESDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYROLLOTHERCHARGESADJUSTMENTID"
	type = "NUMBER(19,0)"
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

