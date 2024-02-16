resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_CAREGIVERTRAVELTIMEDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "CAREGIVERTRAVELTIMEDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.CAREGIVERTRAVELTIMEDETAILS

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
	name = "TRAVELTIMEDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERNAME"
	type = "VARCHAR(153)"
	nullable = true
}


column {
	name = "CAREGIVERCODE"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "TRAVELDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TRAVELSTARTDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TRAVELENDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TRAVELSTARTTIME"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "TRAVELENDTIME"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "TRANSPORTATIONMETHOD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OVERRIDEPAYRATE"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "NUMBER(22,6)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYAMOUNT"
	type = "NUMBER(38,6)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "CREATEDTYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYROLLBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYROLLBATCHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TRAVELTIMEBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TRAVELTIMEBATCHNUMBER"
	type = "VARCHAR(20)"
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

