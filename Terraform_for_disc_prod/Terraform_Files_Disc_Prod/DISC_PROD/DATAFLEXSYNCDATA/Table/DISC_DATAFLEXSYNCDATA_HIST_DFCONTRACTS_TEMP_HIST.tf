resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_HIST_DFCONTRACTS_TEMP_HIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "HIST_DFCONTRACTS_TEMP_HIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.HIST_DFCONTRACTS_TEMP_HIST

    -- Purpose : Discovery Data Population

    -- Project : DATAFLEXSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DBNAME"
	type = "VARCHAR(12)"
	nullable = false
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYMENTMETHOD"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BILLPERSONCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "RATE1"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "RATE2"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "RATEEFFECTIVEDATE1"
	type = "DATE"
	nullable = true
}


column {
	name = "RATEEFFECTIVEDATE2"
	type = "DATE"
	nullable = true
}


column {
	name = "BILLABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISMEDWAIVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OVERHEADRATE1"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "OVERHEADRATE2"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "ISSKILLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLEDBYQUARTERHOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USEBILLCODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLLCODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BILLBYHALFHOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LISTRATE1"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "LISTRATE2"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "DEFAULTBILLCODE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ISMILEAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWQUARTERHOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYTRAVELS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYORCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEBATCH"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "UPDATEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYINUNITS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYINDOLLARS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYINDOLLARPAYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYINDOLLARRATE"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "ISEVV"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REVENUECATEGORY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RATE3"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "RATE4"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "RATEEFFECTIVEDATE3"
	type = "DATE"
	nullable = true
}


column {
	name = "RATEEFFECTIVEDATE4"
	type = "DATE"
	nullable = true
}


column {
	name = "LISTRATE3"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "LISTRATE4"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "PAYTRAVELSCODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "REVENUESUBCATEGORY"
	type = "VARCHAR(10)"
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


column {
	name = "CPTHPCSCODE"
	type = "VARCHAR(40)"
	nullable = true
}

}

