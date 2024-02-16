resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_CONTACT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "CONTACT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.CONTACT

    -- Purpose : Discovery Data Population

    -- Project : HEALTH_NAVIGATOR

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
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACCOUNTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "ETHNICITY_DATA_STANDARD__C"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TESTING_STATUS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MOBILEPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(121)"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "MAILINGLATITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "PHOTOURL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MASTERRECORDID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "INDIVIDUALID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CONDITIONSTATUS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISEMAILBOUNCED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__STATUSGROUP__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MAILINGCITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SUFFIX"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__COUNTRYOFBIRTH__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MAILINGSTATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEM__C"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MAILINGCOUNTRYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INDIVIDUALTYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MONITORED_AT_HOME__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MAILINGSTREET"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JIGSAW"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ASSISTANTPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EMAILBOUNCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CONVERTEDREFERRALS__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "OTHERPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "WHAT_IS_THIS_PERSON_S_RACE__C"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PREFERREDNAME__C"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "MAILINGCOUNTRY"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SALUTATION"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MAILINGSTATE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DECEASEDDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARYLANGUAGE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INDIVIDUALID__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "MAILINGLONGITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CREATEDFROMLEAD__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MAILINGPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MEDICALRECORDNUMBER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRERSCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEMID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTCUUPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RACE_DATA_STANDARD__C"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "MAILINGGEOCODEACCURACY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__AGE__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "EMAILBOUNCEDREASON"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TOTALREFERRALS__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "ISPERSONACCOUNT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SECONDARYLANGUAGE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "CARE_PROGRAM__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__BIRTHDATE__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "LASTCUREQUESTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__GENDER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "REPORTSTOID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "JIGSAWCONTACTID"
	type = "VARCHAR(20)"
	nullable = true
}

}

