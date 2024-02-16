resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_LEAD" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "LEAD"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.LEAD

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
	name = "HEALTHCLOUDGA__EMERGENCYCONTACTLASTNAME__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANRECORDTYPENAME__C"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SPECIALTY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRINGUSER__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "STREET"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PHOTOURL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__RELATEDACCOUNT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INSURANCEGROUPID__C"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__EMERGENCYCONTACTFIRSTNAME__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REASONFORDISQUALIFICATION__C"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INSURANCEMEMBERID__C"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERREDTOPRACTITIONER__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRINGPRACTITIONER__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SUFFIX"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "GEOCODEACCURACY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARYDIAGNOSISDESCRIPTION__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEM__C"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SECONDARYINSURANCEID__C"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REASONFOROUTOFNETWORKREFERRAL__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JIGSAW"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CONVERTEDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARYCAREPROVIDER__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "WEBSITE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "NUMBEROFEMPLOYEES"
	type = "NUMBER(8,0)"
	nullable = true
}


column {
	name = "SALUTATION"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANRECORDTYPENAMESPACE__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEMID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EMAILBOUNCEDREASON"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TYPEOFSERVICE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SECONDARYINSURANCE__C"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__BIRTHDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__HOMEBOUND__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REASONFORREFERRAL__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRINGCONTACTNAME__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERREDTOUSER__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRINGNPI__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MOBILEPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ISOUTOFNETWORK__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(121)"
	nullable = true
}


column {
	name = "INDUSTRY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ASSIGNCARECOORDINATORUSER__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ANTICIPATEDDISCHARGEDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERREDTOORGANIZATION__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRINGORGANIZATION__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CONVERTEDOPPORTUNITYID"
	type = "VARCHAR(18)"
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
	name = "HEALTHCLOUDGA__STARTRESUMPTIONOFCAREDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DIAGNOSIS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CONVERTEDACCOUNTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__STATUSGROUP__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DISCHARGEDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ISCONVERTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INSURANCETYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ASSIGNCARECOORDINATORCONTACT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LEADSOURCE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRINGPRACTITIONERSCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "EMAILBOUNCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RATING"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__LANGUAGE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARYINSURANCE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SIGNINGPROVIDER__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CONVERTEDCONTACTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARYDIAGNOSIS__C"
	type = "VARCHAR(18)"
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
	name = "HEALTHCLOUDGA__MEDICALRECORDNUMBER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COUNTRYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__AGE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRINGCONTACTPHONE__C"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIORITY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__EMERGENCYCONTACTPHONE__C"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ISMARKEDFORPATIENTCONVERSION__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SECONDARYDIAGNOSISDESCRIPTION__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISUNREADBYOWNER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRERADMITDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SECONDARYDIAGNOSIS__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TERTIARYDIAGNOSIS__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__GENDER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__FACETOFACEENCOUNTERDATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__EMERGENCYCONTACTRELATIONSHIP__C"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "JIGSAWCONTACTID"
	type = "VARCHAR(20)"
	nullable = true
}

}

