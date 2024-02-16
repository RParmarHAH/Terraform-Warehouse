resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CONTRACTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CONTRACTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CONTRACTS

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
	name = "CONTRACTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CHHAID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "AUTHORIZATIONREQUIRED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "VALIDATEPAPERDUTYSHEET"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REQUIREDCOMPLIANCE"
	type = "VARCHAR(24)"
	nullable = true
}


column {
	name = "CONTACTPERSON"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GENERALEMAIL"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "PAYMENTTERMS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "QBEXPORTCONTRACTNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "QBEXPORTTERMS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "QBACCOUNTINGNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "QBTERMSSPELLED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "QBACCOUNTNUMBER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "QBTERMSINDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "ISREASONREQUIRED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WAGEPARITY"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "AUTOMATICALLYFLAGASTS"
	type = "VARCHAR(53)"
	nullable = true
}


column {
	name = "CUSTOMROLLOVER"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "BILLLINKINGUNRECOGNIZEDNUMBER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "AUTOSELECTTIMESHEETREQUIREDFORUNRECOGNIZEDNUMBER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILLTIMESHEETNOTAPPROVED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ISVNSCONTRACT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TIMELYFILINGLIMIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DUTYSHEETTIMETYPE"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "DUTYSHEETGROUPBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DUTYSHEETDISPLAYBILLEDHOURS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DUTYSHEETDISPLAYDATEOFBIRTH"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DUTYSHEETDISPLAYMEDICAIDNUMBER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "AUDITVISITVERIFICATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "AUDITVISITDATEANDTIME"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "AUDITVISITSUPERVISOR"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CONTRACTTYPENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUTHORIZATIONWEEKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTHORIZATIONWEEK"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LINKEDCONTRACTPAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLINGCONFIGURATIONROUNDINGMINSDURATION"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BILLINGCONFIGURATIONROUNDINGMINSBY"
	type = "VARCHAR(7)"
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

