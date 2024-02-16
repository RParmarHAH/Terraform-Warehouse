resource "snowflake_table" "DISC_GENERATIONSALLIANCE_ADMIN_OPTIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "ADMIN_OPTIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.ADMIN_OPTIONS

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
	name = "FISCALYEAREND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COMPANYNAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "ADDRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TIN"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYPERIODENDDAY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALENDARDISPLAYOPTION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ISSSN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EENUMLENGTH"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SPLITTIMESHEETDAYS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOWSRVONCAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TYPEOFCAREGIVER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYOVERTIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATETS_CONFIRMEDONLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "VENDORGLACCT"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "DEFAULTCONFIRMED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QBINVOICEDESCR"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CREATEBILLS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROVIDERNUM"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "IMAGEPATH"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "QBAPACCT"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "TSNOTEDETAIL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PASSPORTID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PASSPORTLOCATION"
	type = "VARCHAR(20)"
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
	name = "SECURITYON"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOGINSALLOWED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ICD9VERSION"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "READONLYNOTES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INACTIVITYTIMEOUT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SHOWCALENDARNOTES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCALIZATION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "TELEPHONYLASTUPLOAD"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TELEPHONYLASTDOWNLOAD"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TELEPHONYFIRSTUPLOAD"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATETSAVAILSHIFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UL"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TELEPHONYID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EXPDT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TELCGCUSTOM"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ACCTSYSTEM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OVERTIMEWARNING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INDEPENDENTCONTRACTOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHEDULEDATELASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TARDY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CONNECTEDUSERS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTTELEPHONYID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "VENDORGLEXPACCT"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "TELEPHONYSYSTEM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "LINKATTACHMENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_UPDATE_CON_SCHEDULE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ROUND_EARLYLOGIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELEPHONYUPLOADTILL"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "QBFLATRATEHIDETIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOGO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOGOVALUE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BIT_CMPNAMEONREPORTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_CANADA2008"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_QBLOG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INT_MILEAGEACT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BIT_IMPORTMILEAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STR_TPWID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STR_TPWPASSWORD"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "STR_SERVERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INT_CALLIN"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INT_CALLOUT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "STR_COMPANYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STR_COMPANYPASSWORD"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "INT_ROUNDINTERVAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INT_SCHEDULEROUNDINTERVAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DTM_PROCESSINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BIT_MISSEDALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INT_LATEBY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BIWKLYXFRSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ESTIMATE_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ATTACH_OPTIONS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ATTACH_PATH"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "ISARCHECKED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACCOUNTRECEIVABLE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISHOSTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWCLIENTCGLOGIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FRANCHISEID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "QBVENDORNAME"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COMPATIBLEAPPVERSION"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ABBREVIATENAMES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REMOVECLIENTPHONE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWCAREGIVERSTOPOC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAGESINNEWTAB"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISQBOE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_PROCESSMANUALEXPORT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOSTEDTELEPHONYOFFSET"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BIT_ONLINEAPPLICATIONENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ONLINESERVICEENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEMILEAGEPROMPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOWUNAVAILABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOWTASKCOMPLETEDSTATUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWCGTOVIEWAVAILABLESHIFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_EMAILCALLCENTERASSIGNED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ENABLETOTALHOURSONSCHEDULE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLECLIENTVIEWTASK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLECLIENTNOTIFICATIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLECLIENTVIEWPOC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_REQUIRESTRONGPASSWORD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_USEPASSWORDFIELDSONSCREEN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONFIRMCONTSCHEDULES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLECHECKIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ENABLEFTEALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INT_FTEALERTHOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "OVERTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BIT_ENABLEQUICKCONFIRMGRID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ENABLEGPS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEC_GPSVARIANCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTOMATCHCALLERID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_BILLABLESTATUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUSTOMLOGOWIDTH"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CUSTOMLOGOHEIGHT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BITLIMITCALENDERDATERANGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GENERALOPTIONSSCHEDULESTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GENERALOPTIONSSCHEDULEENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BIT_MASKSSN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWCGTOACCESSVISITNOTES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BITSHIFTVISITBYCLIENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_INCLUDEINACTIVECGNOTETYPE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_INCLUDEINACTIVECLIENTNOTETYPE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_INCLUDEINACTIVEREFERRALNOTETYPE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ENABLEOTPERWEEK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHOURPERWEEK"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "BIT_ENABLEOTPERDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHOURSPERDAY"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "BIT_ENABLEWEIGHTEDAVG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_CGMISSEDALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_DISABLEVISITNOTETIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_CHANGE_PASSWORD_FORCE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PASSWORD_DURATION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BIT_READONLYCONFIRMEDSCHEDULES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALENDARVIEWABLETYPE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALENDARVIEWABLEPERIODTYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALENDARVIEWABLEPERIOD"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ENABLECLIENTVIEWQUESTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEFRANCHISESETUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_MSDVSTALERTMSG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MSDVSTALERTMSG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INT_LATEBYCG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "TRAVEL_ENABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRAVEL_CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRVLTIMEDEFRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ITEMNAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INCLUDEHOLIDAYPREMIUM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLECLIENTVIEWVISITNOTES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALENDARPERIODLIMITTYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRIORROLLINGDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FUTUREROLLINGDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALCULATEOTFORIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CANADATAXCODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMAILDISCLAIMER"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "ENABLEEMAILDISCLAIMER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEMOCKLOCATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOWPAYORONCALENDAR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLECLIENTQA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULTQA"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ENABLEQAONNEWSCHEDULES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DONOTCALLTIMES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DONOTCALLSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DONOTCALLENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BIT_CUSTOMMAILSERVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SMTPHOSTADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SMTPPASSWORD"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SMTPPORTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BIT_USETLS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SMTPUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SHOWPITEMONCALENDAR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ENABLECONSECUTIVEVISIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INT_MINIMUMSHIFTDURATION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ISCALLERIDMATCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_AUTOCAREGIVERNUMBER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_DONOTALLOWLOGINOUTSIDEGPS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISCONFIRMNOTEREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SANTRAXFTPID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SANTRAXPASSWORD"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SANTRAXID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SANTRAXPROCESSINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SANTRAXEMPLOYEELASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SANTRAXSCHEDULELASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SANTRAXLASTIMPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SANTRAXEMPLOYEEREQFIELDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BITROUNDSHIFTTO15MINS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SANTRAXFTPFOLDER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TRAVELTIMEALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MILEAGEACCOUNT_OTHEREXPENCE_SERVICECODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BIT_ENABLEMILEAGECALCULATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISSHOWNEEDSALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_ENABLEAPPNOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEELECTRONICSIGN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISLANGUAGEPROMTREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHARTINGNOTECOMPLETIONDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISDISPLAYTELEPHONYID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISAUTOATTACHCALLCENTERNOTE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_DASHBOARDACCESS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MOBILEINACTIVITYTIMEOUT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ENABLEMESSAGECENTER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_READONLYSIGNEDSCHEDULES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SIGNATURETIMEOPTION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ENABLEVOICESIGNATURE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISDISPLAYPAYOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REQUIREDCGVISITNOTE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENFORCEPASSWORDHISTORY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_HIDECLIENTCATEGORIESANDQUESTIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_HIDECGCATEGORIESANDQUESTIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISTIMEDECIMALFORMAT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DECRYPTEDSMTPASSWORD"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HHAXID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "HHAXFTPID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "HHAXPASSWORD"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "HHAXEMPLOYEELASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HHAXPROCESSINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DECRYPTEDHHAXPASSWORD"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BIT_DISPLAYSERVICESHORTDESCRIPTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISAZUREENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWREQUESTSHIFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PASSWORDMINLENGTH"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ENABLEAMAZONSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SANTRAXOHCLIENTLASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SANTRAXOHPROVIDERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SANTRAXOHPROCESSINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SANTRAXOHEMPLASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SANTRAXOHVISITLASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SANTRAXOHID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SANTRAXOHUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SANTRAXOHPASSWORD"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "DECRYPTEDSANTRAXOHPASSWORD"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "DECRYPTEDSANTRAXPASSWORD"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "OFFLINEMODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BIT_ADMINOVERRIDE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOWVISITNOTESINCLIENTAPP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELLUSMEDICAIDID"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "TELLUSNPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TELLUSNPITAXONOMY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TELLUSCLIENTID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TELLUSUSERNAME"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TELLUSPASSWORD"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TELLUSPROCESSINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TELLUSLASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BIT_ENABLE_PASSWORD_AUTO_RESET"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PASSWORD_AUTO_RESET_DURATION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ENABLEDMASTASKSONPOC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELLUSFTPPASSWORD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENABLECGSCREENING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CGSCREENINGFAILEDMESSAGE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CGSCREENINGHOURSALLOWPRIOR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INT_VISITLOGOUT_LATEBY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INT_VISITLOGOUT_LATEBYCG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BIT_CGMISSEDLOGOUTALERT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_MSDVSTLOGOUTALERTMSG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MSDVSTLOGOUT_ALERTMSG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ARPROVIDERID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENABLEMASSACHUSETTSEVV"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MASSHEALTHID"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "SIMSCONSUMERID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PROVIDERFEINNUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "MASSACHUSETTSVISITLASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ARUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ARPASSWORD"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ARJURISDICTIONID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ARVISITLASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ARPROVIDEREMAIL"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "ARPROVIDERXREF"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "ALLOWAUTHENTICAREEXPORT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ARPROCESSINGSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HHAXVISITLASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HHAXCLIENTID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HHAXCLIENTSECRET"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "NYMEDICAIDPROVIDERNAME"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NYMEDICAIDPROVIDERID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NYMEDICAIDNPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NYMEDICAIDLASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NYMEDICAIDPROCESSINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MEDICAIDSUBMITTERID"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "ISDISPLAYCLIENTPHONE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREBRIDGEFTPPASSWORD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREBRIDGEPROVIDERID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CAREBRIDGEUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAREBRIDGELASTEXPORT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREBRIDGEBEGINPROCESS"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ROUNDPAYROLLHOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ARROUNDINGRULES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXCLUDEDAILYOTFROMHOLIDAYHOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MASSACHUSETTSPROVIDERID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "MASSACHUSETTSPROVIDERSL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ENABLEARFILEEXPORT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLECGINCOMPLETETASKNOTE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELLUSPORT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ALLOWCAREBRIDGEEXPORT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISCBSPECIFICTIMESHEET"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISENABLECONTSHIFTMANUALLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISENABLEEVVCONFLICT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ICONNECTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SANTRAXOHPASSWORDSTRONG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SMTPPASSWORDSTRONG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "HHAXPASSWORDSTRONG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SANTRAXPASSWORDSTRONG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TELLUSPASSWORDSTRONG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ARPASSWORDSTRONG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "HHAXCLIENTSECRETSTRONG"
	type = "VARCHAR(200)"
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

