resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_PATIENTS_27" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "PATIENTS_27"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.PATIENTS_27

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
	name = "PAYERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUSID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIORITYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCEPTEDSERVICES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
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
	name = "ZIP5"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CROSSSTREET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE2DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE3DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAGEPARITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAGEPARITYFROMDATE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAGEPARITYTODATE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAGEPARITYFROMDATE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAGEPARITYTODATE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISALTERNATEBILLING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGFIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGLASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGMIDDLENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGSTREET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGCITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATEBILLINGZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1RELATIONSHIPID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1RELATIONSHIPNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1RELATIONSHIPOTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1LIVESWITHPARENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1HAVEKEYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1PHONE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1PHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT1ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2RELATIONSHIPID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2RELATIONSHIPNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2RELATIONSHIPOTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2LIVESWITHPARENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2HAVEKEYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2PHONE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2PHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT2ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MOBILITYSTATUSID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVACUATIONZONEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVACUATIONLOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHEREVACUATIONLOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ELECTRICEQUIPMENTDEPENDENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYPREPAREDNESSDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NURSEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COORDINATORS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLUSTER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISMUTUALLINKED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MUTUALLINKPATIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISPRIMARYPATIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICESTARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROJECTEDDCDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCEOFADMISSIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TEAMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCHID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALERT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALMASTERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALRECEIVEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALSOURCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALLOSTREASONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALLOSTREASONNOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMMISSIONSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALCONTACTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALINTAKEPERSONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNTMANAGERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUESTSPECIALAGENCYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUESTGENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUESTPRIMARYLANGUAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUESTSECONDARYLANGUAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUESTOTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVVREQUIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCHNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERCOORDINATORS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFILEHEADERALERT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONELOCATIONADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE2LOCATIONADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE3LOCATIONADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEADMISSIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USEPAPERSHEET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VALIDATEPAPERDUTYSHEET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LINKEDPATIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERPRIORITYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROVIDERPRIORITYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RACE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGE3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGE4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTSNURSE"
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

