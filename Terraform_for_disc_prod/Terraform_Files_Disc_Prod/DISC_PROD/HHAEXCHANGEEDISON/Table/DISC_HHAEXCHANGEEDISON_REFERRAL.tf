resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_REFERRAL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "REFERRAL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.REFERRAL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

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
	name = "REFERRALID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COORDINATOR_1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COORDINATOR_2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COORDINATOR_3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIORITYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SOURCEOFADMISSION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ACCEPTEDSERVICES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "LINKWITH"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MEDICARENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TEAM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BRANCH"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LANGUAGE1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LANGUAGE2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ALLOWDUPLICATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SERVICEREQUESTSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENTAWAREOFREFERRAL"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ALERTS"
	type = "VARCHAR(5000)"
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
	name = "ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CROSSSTREET"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHONE2DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE3"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHONE3DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIRECTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGADDRESS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "BILLINGFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGMIDDLENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLINGSTREET"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILLINGZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BILLINGCITY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BILLINGSTATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTRELATIONSHIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTLIVESWITHPATIENT"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTHAVEKEYS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTPHONE1"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTPHONE2"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2RELATIONSHIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2LIVES"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2HAVEKEYS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2PHONE1"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2PHONE2"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2ADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIORITYCODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EVACUATIONZONEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MOBILITYSTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EVACUATIONLOCATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTHEREVACUATIONLOCATION"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "EMERGENCYDESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ELECTRICEQUIPDEPENDENCY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RECEIVEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFERRALSTATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMMISSIONSTATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CALLERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CALLDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALLERPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CALLERNOTE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "REFERRALSOURCE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REFERRALCONTACT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INTAKEPERSONNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACCOUNTMANAGER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLINICALCOMMENTS"
	type = "VARCHAR(1500)"
	nullable = true
}


column {
	name = "ALLERGIES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PATIENTHICLAIMNO"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OFFICEID"
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

