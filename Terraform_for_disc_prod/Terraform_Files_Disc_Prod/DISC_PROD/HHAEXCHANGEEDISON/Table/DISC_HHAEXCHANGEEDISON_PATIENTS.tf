resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_PATIENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "PATIENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.PATIENTS

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
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MRNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PRIORITYCODE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ACCEPTEDSERVICES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MEDICARENUMBER"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(55)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP5"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CROSSSTREET"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "DIRECTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE2DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE3DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WAGEPARITY"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WAGEPARITYFROMDATE1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WAGEPARITYTODATE1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WAGEPARITYFROMDATE2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WAGEPARITYTODATE2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISALTERNATEBILLING"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGMIDDLENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGSTREET"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGZIPCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1RELATIONSHIPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1RELATIONSHIPNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1RELATIONSHIPOTHER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1LIVESWITHPARENT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1HAVEKEYS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1PHONE1"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1PHONE2"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2RELATIONSHIPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2RELATIONSHIPNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2RELATIONSHIPOTHER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2LIVESWITHPARENT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2HAVEKEYS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2PHONE1"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2PHONE2"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2ADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MOBILITYSTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EVACUATIONZONEID"
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
	name = "ELECTRICEQUIPMENTDEPENDENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYPREPAREDNESSDESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NURSEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COORDINATORS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLUSTER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ISMUTUALLINKED"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "MUTUALLINKPATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ISPRIMARYPATIENT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SERVICESTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROJECTEDDCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SOURCEOFADMISSIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TEAMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ALERT"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "REFERRALMASTERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALRECEIVEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFERRALSOURCEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALSTATUS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "REFERRALLOSTREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALLOSTREASONNOTE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "COMMISSIONSTATUS"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "REFERRALCONTACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALINTAKEPERSONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACCOUNTMANAGERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REQUESTSPECIALAGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REQUESTGENDER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REQUESTPRIMARYLANGUAGE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REQUESTSECONDARYLANGUAGE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REQUESTOTHER"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "EVVREQUIRED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BRANCHNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PAYERCOORDINATORS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PROFILEHEADERALERT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOMEPHONELOCATIONADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "HOMEPHONE2LOCATIONADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "HOMEPHONE3LOCATIONADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OFFICEADMISSIONID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USEPAPERSHEET"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VALIDATEPAPERDUTYSHEET"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LINKEDPATIENT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYERPRIORITYCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROVIDERPRIORITYCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RACE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(100)"
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

