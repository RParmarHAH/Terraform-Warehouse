resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_OFFICE_OFFICES_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "OFFICE_OFFICES_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL

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
	nullable = false
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICECODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "OFFICELEVELID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FEDERALTAXNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "HICFA33B"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "AGENCYZIPCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DEFAULTCOORDINATORID"
	type = "NUMBER(10,0)"
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
	name = "PHONE2"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "USEADDRESSFORINVOICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USEADDRESSFORCLINICALDOC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONEXUSPASSWORD"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "ACCOUNTINGNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ACCOUNTNUMBER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TERMSSPELLED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TERMSINDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VALIDATESCHEDULEOVERTIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADMINUSEREMAIL"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "EXCLUSIONLIST"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTSTARTASON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTCANCELLEDASON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTMD"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTMDSTARTASON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTMDCANCELLEDASON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LIVEINOTMINS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVEROVERTIMEMINS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LIVEINOTAFTERMINS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UNBALANCEDTOLERANCEMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISDEFAULT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MOBILEFOBVERIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MOBILEGPSVISITVERIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GPSTOLERANCERANGE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVERINSERVICEOVERLAPS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONEXUSCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "UNIQUEURLID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "SUITAXJURISDICTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SPENDDOWN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPENDDOWNPERIODMONTHS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SPENDDOWNPROCESSDAY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBERVALIDATIONEXPDISPLAY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBERVALIDATIONEXP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBERVALIDATIONEXPMSG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DISPLAYMDORDERAIDETABAS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIVATECONTRACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRANSPORTATIONBYWALKING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRANSPORTATIONBYDRIVING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRANSPORTATIONBYPUBLIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVERABSENCEOVERLAPS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BEACONVERIFICATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MASTERWEEKROLLOVERTIMEFRAME"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERVERIFICATIONLISTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIANVERIFICATIONLISTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENABLECAREGIVERVERIFICATIONLIST"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVERVERIFICATIONLISTSTARTASON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERVERIFICATIONLISTCANCELASON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENABLEPHYSICIANVERIFICATIONLIST"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PHYSICIANVERIFICATIONLISTSTARTASON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYSICIANVERIFICATIONLISTCANCELASON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTSTATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASESVIEW"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASESREQUESTACCEPT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASEREQUESTLIMIT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASEREQUESTLIMITVALUE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALCULATEANDPAYOFFDUTYTIME"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MAXODTMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ALLOWCONSECUTIVESHIFTS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SECONDARYIDENTIFIER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENABLEMOBILEAPPOFFLINESUPPORT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOBILEOFFLINESUPPORTSYNCHPERIOD"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ENABLEAUTOADJUSTSCHEDULE"
	type = "VARCHAR(10)"
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
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTUPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTUPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTUPDATEDUTCDATE"
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

