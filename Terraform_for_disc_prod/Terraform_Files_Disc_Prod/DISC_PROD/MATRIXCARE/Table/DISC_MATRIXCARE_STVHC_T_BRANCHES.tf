resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_BRANCHES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_BRANCHES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_BRANCHES

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BR_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_FORMALNAME"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "BR_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_LOCATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_PARBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_ADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_ADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_STATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BR_POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BR_COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_COUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_UTCOFFSETHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_AGENCYLICENSENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGWEEKSTARTDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_DEFAULTTRAVELTIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCONFLICTSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGSCHEDULECONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGSCHEDULECONFLICTSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGAVAILABILITYCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGAVAILABILITYCONFLICTSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGDNUCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGDNUCONFLICTSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGAUTHORIZATIONCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGAUTHORIZATIONCONFLICTSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCAREGIVEREXPIRATIONSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCAREGIVEREXPIRATIONSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULELISTMAXDAYS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_REMITADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_REMITADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_REMITCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_REMITSTATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BR_REMITPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BR_REMITCOUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_REMITCOUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_REMITPOSTALCODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_REMITPHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "BR_REMITFAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "BR_REMITCONTACTNAME"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "BR_REMITEMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_EDIADDITIONALID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BR_EDIADDITIONALIDTYPE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "BR_OASISIFENABLEDFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_NPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BR_FEDTAXID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BR_TAXONOMY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BR_SHIFT1DESC"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "BR_SHIFT2DESC"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "BR_SHIFT3DESC"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "BR_SHIFT4DESC"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "BR_SHIFT5DESC"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "BR_SHIFT6DESC"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "BR_OTDAYRATETYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_OTDAYHOURS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_OTDAYMULTIPLIER"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "BR_OTWEEKRATETYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_OTWEEKHOURS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_OTWEEKMULTIPLIER"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "BR_PAYROLLCOMPANYCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BR_MAPPINGTOOLSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_USEMAPPOINT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_MAPPOINTUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_MAPPOINTPASSWORD"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_REPLICATIONSERVERID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BR_REPLICATIONUSERNAME"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "BR_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BR_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BR_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BR_DBA"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "BR_COMPANYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_COMPANYAGREEMENTSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BR_COMPANYAGREEMENTEXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BR_BUSINESSTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_POTENTIALCLIENTS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_DATEESTABLISHED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BR_INVOICENOTE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "BR_INVOICETAGLINE"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "BR_INVOICEDUEDAYS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_BANKACCOUNTTYPE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "BR_TIMEZONEID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGWEEKSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCHECKFOROVERTIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCHECKFOROVERTIMEOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_BANKACCOUNTNUMBER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BR_BANKROUTINGNUMBER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BR_PAYROLLDIVISIONCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BR_LEGACYBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_ACCTSYSTEM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_ACCTACCRUAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_ACCTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_PCEFILEEXTRACTPREFIX"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "BR_PCEUSECOMPANYCODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_PCECOMPANYCODECHARS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_PCEUSEBATCHID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_PCEBATCHIDNUMS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_PCEFILEEXTENSION"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "BR_PCEDEFAULTPATH"
	type = "VARCHAR(240)"
	nullable = true
}


column {
	name = "BR_FEDTAXIDTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BR_OTWEEKEARNCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_TELEPHONYLOGINNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BR_TELEPHONYUPLOADRUNINTERVAL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYDOWNLOADRUNINTERVAL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYUPLOADRANGE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYLOGXMLDOWN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_TELEPHONYLOGXMLUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_TELEPHONYPASSWORD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BR_TELEPHONYACCOUNTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_DEFAULTSERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_DEFAULTMILEAGEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_OTDAYEARNCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_EMAILSENDERADDRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_EMAILHOSTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BR_EMAILHOSTPORT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_EMAILHOSTUSESSSL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_EMAILHOSTUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_EMAILHOSTPASSWORD"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BR_EMAILHOSTDOMAIN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_OASIS_MEDICARE_PAYER_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BR_OASIS_MEDICAID_PAYER_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BR_OASIS_M0016_BRANCH_ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BR_TELEPHONYSETC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_COMPANYURI"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "BR_OASIS_IGNOREFATALEDITS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_AVGEPISODEDAYS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BR_ACCTEXTRACTONCLOSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_ACCTEXTRACTGRPGLDATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_PCELIMITBATCHIDINFILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_PCEBATCHIDINFILENUMS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_OASISEXTRACTDEFAULTPATH"
	type = "VARCHAR(240)"
	nullable = true
}


column {
	name = "BR_OASIS_HHA_AGENCY_ID"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "BR_OTDAYDEDUCTEARN"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BR_OTWEEKDEDUCTEARN"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BR_INCLUDEPREVPAYDATES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_TELEPHONYLOGLEVEL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_ELECTRONICPMTPROCESSENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_ELECTRONICPAYMENTPROCESSINGTYPESID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_ELECTRONICPMTPROCESSLOGIN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BR_ELECTRONICPMTPROCESSPASSWORD"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BR_ELECTRONICPMTCUSTINFOMGTLOGIN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BR_ELECTRONICPMTCUSTINFOMGTPASSWORD"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BR_ELECTRONICPMTVALIDATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_TELEPHONYTIMESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_INVPARM_DISPLAYBRLOGO"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_INVPARM_DISPLAYCRBALANCES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_INVPARM_DISPLAYCARFISTNAMEONLY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_INVPARM_DISPLAYRECENTPMTS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_INVPARM_DISPLAYOUTSTANDINGINV"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_INVPARM_DISPLAYDEPOSITBALANCES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_INVPARM_PMTWITHINDAYS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_PAYROLLEXTRACTTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_485BOX5DEFAULT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYTIMEBEFOREARRIVALLIMIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYTIMEAFTERARRIVALLIMIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYTIMEBEFOREDEPARTURELIMIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYTIMEAFTERDEPARTURELIMIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYCREATENEWSCHONNOMATCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_TELEPHONYROUNDUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_TELEPHONYROUNDINCREMENT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYEMAILDESTTYPEONMISSEDVISIT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYEMAILADDRONMISSEDVISIT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BR_TELEPHONYPARENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_MINWAGE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BR_TELEPHONYNOTIFICATIONMAXHOURSAGO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_FTPPAYROLLSETTINGS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BR_TREATMENTWEEKSTARTDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_BILLTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_OAREQFORCLIENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_TELEPHONYSERVICECHANGEFLAGBEHAVIOR"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYCHECKINRESETTHRESHOLD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BR_INVPARM_DISPLAYSCHTIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_AUTOPOST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_INVPARM_DISPLAYSCHNOTE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_ADDRESSVERIFICATION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BR_TELEPHONYEMAILFROMADDRONMISSEDVISIT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BR_MGMTINTERFPASSWORD"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BR_AALIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_ALLOWSMSTEXTMESSAGING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_SCHEDULINGSKILLGROUPCHECKALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGSKILLGROUPCHECKOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_TIMEANDATTENDLOCATIONTHRESHOLD"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "BR_TIMEANDATTENDLOCATIONMINACCURACY"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "BR_TIMEANDATTENDPORTALENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_ADMINISTRATOREMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BR_PCE_FILENAMESUFFIX"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCGSTATUSCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCGSTATUSCONFLICTSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_MAXWEEKHOURS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCHECKFORMAXHOURS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_SCHEDULINGCHECKFORMAXHOURSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BR_EDISFLADDITIONALID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BR_EDISFLADDITIONALIDTYPE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "BR_PAYROLLTRAVELTIMETHRESHOLD"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BR_OPERATIONSFEATURES"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BR_BILLPAYKEY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BR_BILLPAYLOCATIONID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "BR_ISHOLIDAYOTELIGIBLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_INVOICEEMAILBODY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BR_ELECTRONICPROCESSINGMERCHANTID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BR_FTPEFTSETTINGS"
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

