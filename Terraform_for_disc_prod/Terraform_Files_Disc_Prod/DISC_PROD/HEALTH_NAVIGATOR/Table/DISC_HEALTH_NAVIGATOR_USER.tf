resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_USER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "USER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.USER

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
	name = "PROFILEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USERPREFERENCESRECEIVENOTIFICATIONSASDELEGATEDAPPROVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LANGUAGELOCALEKEY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERPREFERENCESRECORDHOMESECTIONCOLLAPSEWTSHOWN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESHASCELEBRATIONBADGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BADGETEXT"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "EMAILPREFERENCESAUTOBCCSTAYINTOUCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISPROFILEPHOTOACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWMOBILEPHONETOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "COMMUNITYNICKNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERPREFERENCESHASSENTWARNINGEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FEDERATIONIDENTIFIER"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "STREET"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "USERPREFERENCESHASSENTWARNINGEMAIL238"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLEENDORSEMENTEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESPREVIEWCUSTOMTHEME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPERMISSIONSCALLCENTERAUTOLOGIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STAYINTOUCHSUBJECT"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLESHAREPOSTEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "USERPERMISSIONSINTERACTIONUSER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWSTATETOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLECHANGECOMMENTEMAIL"
	type = "BOOLEAN"
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
	name = "USERPREFERENCESHIDECSNDESKTOPTASK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDES1BROWSERUI"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDEENDUSERONBOARDINGASSISTANTMODAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWPOSTALCODETOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWSTATETOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERTYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "RECEIVESADMININFOEMAILS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWMOBILEPHONETOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDESFXWELCOMEMAT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIMEZONESIDKEY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERROLEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "USERPREFERENCESCACHEDIAGNOSTICS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDECSNGETCHATTERMOBILETASK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESNEWLIGHTNINGREPORTRUNPAGEENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FORECASTENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESEXCLUDEMAILAPPATTACHMENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWFORECASTINGCHANGESIGNALS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWWORKPHONETOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIVISION"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "USERPREFERENCESTASKREMINDERSCHECKBOXDEFAULT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCALESIDKEY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "SMALLPHOTOURL"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "USERPREFERENCESSRHOVERRIDEACTIVITIES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWSTREETADDRESSTOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWCITYTOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDECHATTERONBOARDINGSPLASH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESREVERSEOPENACTIVITIESVIEW"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWEMAILTOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SMALLBANNERPHOTOURL"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "USERPREFERENCESFAVORITESSHOWTOPFAVORITES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RECEIVESINFOEMAILS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESGLOBALNAVGRIDMENUWTSHOWN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWWORKPHONETOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESRECEIVENONOTIFICATIONSASAPPROVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FULLPHOTOURL"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "MEDIUMBANNERPHOTOURL"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDESECONDCHATTERONBOARDINGSPLASH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULTGROUPNOTIFICATIONFREQUENCY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLEPROFILEPOSTEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWTITLETOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACCOUNTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLELATERCOMMENTEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWPOSTALCODETOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTLOGINDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "NUMBER(18,15)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLEFOLLOWERSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISEXTINDICATORVISIBLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIGESTFREQUENCY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MOBILEPHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BANNERPHOTOURL"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(121)"
	nullable = true
}


column {
	name = "COMPANYNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "USERPREFERENCESGLOBALNAVBARWTSHOWN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLEMESSAGEEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWEMAILTOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWFAXTOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SENDEREMAIL"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "INDIVIDUALID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWMANAGERTOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDIUMPHOTOURL"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "DELEGATEDAPPROVERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISCOMMENTAFTERLIKEEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLEFILESHARENOTIFICATIONSFORAPI"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWSTREETADDRESSTOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERPREFERENCESUSERDEBUGMODEPREF"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPERMISSIONSSUPPORTUSER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPERMISSIONSMARKETINGUSER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMAILPREFERENCESSTAYINTOUCHREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OFFLINEPDATRIALEXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWTITLETOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSUPPRESSEVENTSFXREMINDERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMAILPREFERENCESAUTOBCC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESCREATELEXAPPSWTSHOWN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "OUTOFOFFICEMESSAGE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MANAGERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "USERPERMISSIONSAVANTGOUSER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWMANAGERTOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDEONLINESALESAPPWELCOMEMAT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWPROFILEPICTOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SENDERNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "USERPERMISSIONSOFFLINEUSER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPERMISSIONSSFCONTENTUSER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDELIGHTNINGMIGRATIONMODAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDEBROWSEPRODUCTREDIRECTCONFIRMATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISMENTIONSCOMMENTEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONTACTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "USERPREFERENCESAPEXPAGESDEVELOPERMODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLEALLFEEDSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STAYINTOUCHSIGNATURE"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "STAYINTOUCHNOTE"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "USERPREFERENCESREMINDERSOUNDOFF"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESACTIVITYREMINDERSPOPUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESEVENTREMINDERSCHECKBOXDEFAULT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLELIKEEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESLIGHTNINGEXPERIENCEPREFERRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLEMENTIONSPOSTEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COUNTRYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWCOUNTRYTOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWCITYTOGUESTUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESENABLEAUTOSUBFORFEEDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESHASSENTWARNINGEMAIL240"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OFFLINETRIALEXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALLCENTERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "USERPREFERENCESPATHASSISTANTCOLLAPSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESRECORDHOMERESERVEDWTSHOWN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABOUTME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "EMPLOYEENUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "USERPREFERENCESFAVORITESWTSHOWN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWCOUNTRYTOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMAILENCODINGKEY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERPREFERENCESDISPROFPOSTCOMMENTEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXTENSION"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USERPREFERENCESSUPPRESSTASKSFXREMINDERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSHOWFAXTOEXTERNALUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERNAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "ALIAS"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "SIGNATURE"
	type = "VARCHAR(1333)"
	nullable = true
}


column {
	name = "USERPREFERENCESHIDEBIGGERPHOTOCALLOUT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESDISABLEBOOKMARKEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERPREFERENCESSORTFEEDBYCOMMENT"
	type = "BOOLEAN"
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

}

