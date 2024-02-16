resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_OFFICE_OFFICES_REPL_27" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "OFFICE_OFFICES_REPL_27"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL_27

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICELEVELID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERALTAXNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HICFA33B"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCYZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULTCOORDINATORID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USEADDRESSFORINVOICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USEADDRESSFORCLINICALDOC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONEXUSPASSWORD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNTINGNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNTNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMSSPELLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMSINDAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VALIDATESCHEDULEOVERTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMINUSEREMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLIST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTSTARTASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTCANCELLEDASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTMD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTMDSTARTASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTMDCANCELLEDASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LIVEINOTMINS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVEROVERTIMEMINS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LIVEINOTAFTERMINS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNBALANCEDTOLERANCEMINUTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISDEFAULT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MOBILEFOBVERIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MOBILEGPSVISITVERIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GPSTOLERANCERANGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERINSERVICEOVERLAPS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONEXUSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIQUEURLID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUITAXJURISDICTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPENDDOWN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPENDDOWNPERIODMONTHS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPENDDOWNPROCESSDAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBERVALIDATIONEXPDISPLAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBERVALIDATIONEXP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBERVALIDATIONEXPMSG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISPLAYMDORDERAIDETABAS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIVATECONTRACTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSPORTATIONBYWALKING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSPORTATIONBYDRIVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSPORTATIONBYPUBLIC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERABSENCEOVERLAPS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BEACONVERIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MASTERWEEKROLLOVERTIMEFRAME"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERVERIFICATIONLISTSTARTASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERVERIFICATIONLISTCANCELASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENABLEPHYSICIANVERIFICATIONLIST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIANVERIFICATIONLISTSTARTASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIANVERIFICATIONLISTCANCELASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASESVIEW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASESREQUESTACCEPT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASEREQUESTLIMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASEREQUESTLIMITVALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALCULATEANDPAYOFFDUTYTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAXODTMINUTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLOWCONSECUTIVESHIFTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARYIDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENABLEMOBILEAPPOFFLINESUPPORT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MOBILEOFFLINESUPPORTSYNCHPERIOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENABLEAUTOADJUSTSCHEDULE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTUPDATEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTUPDATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTUPDATEDUTCDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

