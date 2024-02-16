resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_ACCOUNT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "ACCOUNT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.ACCOUNT

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
	name = "SHIPPINGLATITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "ADI_NATIONAL_RANK__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SDOH_ACUITY_SCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MONITORED_AT_HOME__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LAST_OBSERVATION_RESPONSE_DATE__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERSONHOMEPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARYCONTACT__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ACCOUNTSOURCE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RACE_DATA_STANDARD_OTHER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PERSONMAILINGSTATE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PHOTOURL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HOSPICE__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "VETERAN__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MEDICARE_COVERAGE__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PREFERREDNAME__PC"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NEUROLOGICAL_STATUS__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MAILING_ZIP__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "PERSONMAILINGLATITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "AUTHORIZED_HOURS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PERSONMAILINGSTATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OBSERVATION_RESPONSES_COUNT__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "VISION__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PERSONASSISTANTPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PERSONMARITALSTATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MEDICAID_PAYER__PC"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUFFIX"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BILLINGSTATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__LOWINCOME__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEM__C"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "PERSONMAILINGLONGITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "SHIPPINGPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SECONDARYLANGUAGE__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SHIPPINGSTATE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "BRANCH_KEY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PERSONGENDER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TEAM_ROLE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JIGSAW"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INDIVIDUALTYPE__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PAYERTYPE__C"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "MAILING_STATE__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__GENDER__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "WEBSITE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BILLINGLATITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "NUMBEROFEMPLOYEES"
	type = "NUMBER(8,0)"
	nullable = true
}


column {
	name = "ADI_STATE_RANK__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ENROLLMENTTYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LIVING_WILL_DATE__PC"
	type = "DATE"
	nullable = true
}


column {
	name = "SALUTATION"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PERSONEMAILBOUNCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INDIVIDUALID__C"
	type = "VARCHAR(37)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "BILLINGLONGITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "SOURCESYSTEMIDENTIFIER"
	type = "VARCHAR(85)"
	nullable = true
}


column {
	name = "PERSONLASTCUUPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERSONMOBILEPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DECEASEDDATE__PC"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEMID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SHIPPINGCITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PERSONMAILINGGEOCODEACCURACY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__BIRTHDATE__PC"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "PERSONMAILINGCOUNTRYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DENTAL__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PARENTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "MEDICARE_ISSUING_ENTITY__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISPERSONACCOUNT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETHNICITY_DATA_STANDARD__PC"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "WHAT_IS_THIS_PERSON_S_RACE__PC"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__COUNTRYOFBIRTH__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PERSONINDIVIDUALID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "POWER_OF_ATTORNEY__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SEX_FOR_CLINICAL_USE_SFCU__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PERSONSEQUENCEINMULTIPLEBIRTH"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INSTITUTION__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BILLINGCOUNTRY"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__STATUSGROUP__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CARE_PROGRAM__PC"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "PERSONDECEASEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CONVERTEDREFERRALS__PC"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PERSON_CONTACT_ID__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MEDICALRECORDNUMBER__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TEAM_MEMBERS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SHIPPINGLONGITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "SHIPPINGSTATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BILLINGCITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PERSONCONTACTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "POLST__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DURABLE_MEDICAL_EQUIPMENT__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JIGSAWCOMPANYID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DME_TYPE__PC"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "LIVING_WILL__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__OREC__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__AGE__PC"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PERSONTITLE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "INDUSTRY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLAN__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SEXUAL_ORIENTATION_SO_OTHER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "OPERATINGHOURSID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "BILLINGGEOCODEACCURACY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BILLINGPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PERSONMAILINGCITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PERSONMAILINGCOUNTRY"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "HEARING__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MASTERRECORDID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PERSONMAILINGSTREET"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MEDICAIDELIGIBILITYSTATUS__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RACE_DATA_STANDARD__PC"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERSONBIRTHDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETHNICITY_DATA_STANDARD_OTHER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SHIPPINGGEOCODEACCURACY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "POLST_DATE__PC"
	type = "DATE"
	nullable = true
}


column {
	name = "AMS_SOURCESYSTEM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PERSONEMAILBOUNCEDREASON"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SHIPPINGSTREET"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MAILING_CITY__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TESTING_STATUS__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BIRTHDATE_TEXT__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEM__PC"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INDIVIDUALTYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TAXID__C"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "SICDESC"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "SEXUAL_ORIENTATION_SO__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PERSONEMAIL"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PERSONOTHERPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BILLINGSTATE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "BRANCH_NAME__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLIENT_NAME__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MEDICAREENROLLEE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PALLIATIVE_CARE__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLINGCOUNTRYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COUNTY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MAILING_STREET__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "MEDICAID_ID__PC"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ACUITY_SCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PERSONDEPARTMENT"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PRIMARY_ADDRESS__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MEDICALRECORDNUMBER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PERSONMAILINGPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SHIPPINGCOUNTRY"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "SOURCESYSTEMMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERSONLASTCUREQUESTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__ACTIVE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EXTERNAL_ID__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "GENDER_IDENTITY_GI__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TOTALREFERRALS__PC"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "EDUCATION_LEVEL__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CONDITIONSTATUS__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MEDICARE_BENEFICIARY_ID__PC"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CARE_PROGRAM__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__DISABLED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHIPPINGCOUNTRYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__PRIMARYLANGUAGE__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__INDIVIDUALID__PC"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "BILLINGSTREET"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "GENDER_IDENTITY_GI_OTHER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SOURCESYSTEMID__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__REFERRERSCORE__PC"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HEALTHCARE_AGENT__PC"
	type = "VARCHAR(255)"
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
	name = "EFFECTIVEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYMENT_STATUS__PC"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CREATEDFROMLEAD__PC"
	type = "BOOLEAN"
	nullable = true
}

}

