resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CLIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CLIENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CLIENT

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "MIDDLEINIT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WEIGHT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CASEMANAGERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AMBULATORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARYDIAGNOSIS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REFERREDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "QUICKBOOKSID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SERVICESTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICEENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFERRALNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHYSICIAN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DNR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PHYSICIANPHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "MEDICALRECORD_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENTTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ENABLE1500"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELEPHONYID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "GSTEXEMPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DONOTCONFIRM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INT_STATUSID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STR_REASON"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "REFNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BIT_ALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "ACCOUNTINGID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INITIALCONTACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COUNTYID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "INQUIRYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASSESSMENTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICEREQUESTNO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "ENABLEEMAILNOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GPSVERIFIED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "NUMBER(18,12)"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "NUMBER(18,12)"
	nullable = true
}


column {
	name = "SALESREPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICEORDERREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEASSISTEDGPS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEAPPQA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEPHONEQA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEUB04"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GEOCODEUPDATESTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "GEOCODELASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GEOCODEUPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ISCLIENTSIGNREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISCGSIGNREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENTACCESS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INITIALDISCHARGEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DESIGNATEDCARENOTEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WOUNDNOTECAREGIVERACCESS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CARENOTECAREGIVERACCESS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ALERTNOTE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENTACCESALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHEDULEACCESSALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYORCLIENTIDENTIFIER"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ERVISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STARTADDRESSTYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ENDADDRESSTYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTINGENCYPLANREVIEWDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONTINGENCYPLANID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISVACCINATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "VACCINECARD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VACCINETYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FIRSTVACCINEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SECONDVACCINEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VACCINEREFUSEDREASON"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ISVACCINATIONREFUSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "THIRDVACCINEDATE"
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

