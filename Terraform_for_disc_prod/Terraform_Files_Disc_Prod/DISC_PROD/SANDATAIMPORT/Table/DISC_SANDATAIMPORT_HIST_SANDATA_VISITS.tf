resource "snowflake_table" "DISC_SANDATAIMPORT_HIST_SANDATA_VISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "HIST_SANDATA_VISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.HIST_SANDATA_VISITS

    -- Purpose : Discovery Data Population

    -- Project : SANDATAIMPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFFIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFMI"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STAFFLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STAFFAGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFOTHERID2"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "STAFFAPI"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFTEAMID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "CLIENTFIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CLIENTMI"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLIENTLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENTCHARTID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CLIENTOTHERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENTCUSTOMID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIENTADMITTYPE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OLDSCHEDID"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EVENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "SERVICEID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "TIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTUALDURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "PROPOSEDSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPOSEDEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPOSEDDURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "ADJUSTEDTIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJUSTEDTIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJUSTEDDURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "OVERRIDE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TASKID"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "TASKREADINGS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "TASKNOTES"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "TASKNOTESTYPE"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "REASONCODE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "REASONCODEDESCRIPTION"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PAYQUANTITY"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PAYTYPEID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "BILLQUANTITY"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "BILLTYPEID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "HCPCSCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MODIFIERS"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EVENTSTATUS"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "EVVCALL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MANUALCONFIRMATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HASHEDROWVALUES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BATCHID"
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

