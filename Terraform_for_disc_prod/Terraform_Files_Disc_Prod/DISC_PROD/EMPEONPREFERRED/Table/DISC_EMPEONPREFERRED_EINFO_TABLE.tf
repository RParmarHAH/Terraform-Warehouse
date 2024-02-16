resource "snowflake_table" "DISC_EMPEONPREFERRED_EINFO_TABLE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "EINFO_TABLE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.EINFO_TABLE

    -- Purpose : Discovery Data Population

    -- Project : EMPEONPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS2"
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
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SEX"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYGROUP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HIREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REHIREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJSENIORITYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TERMDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NEWHIREREPORTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CC"
	type = "VARCHAR(54)"
	nullable = true
}


column {
	name = "CC1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WCC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLOCK"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAYGRADE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BASERATE"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "RATEPER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SALARY"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "DEFAULTHOURS"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "PAYFREQUENCY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ANNUALSALARY"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "AUTOPAY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "JOBCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TIPPED"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "GUIDFIELD"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PASSWORD"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SALUTATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SURNAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NICKNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIORLASTNAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DISABILITYDESC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VETERANDESC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SMOKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POSITIONCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "POSITIONINFOLOCKED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EEOCLASS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FLSAOTEXEMPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WORKPHONEEXT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MAILSTOP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMAILADDRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TAXFORM"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PENSION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUTORY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DECEASED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFERREDCOMP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LEGALREP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DOMESTICEMPL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEASONAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "I9VERIFIED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "I9REVERIFY"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CITIZENSHIP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "VISATYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VISAEXPIRATION"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UNIONCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "UNIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UNIONINITFEES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UNIONDUES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPERVISORID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUPERVISORNAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LASTRAISEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTRAISEAMOUNT"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "LASTRAISEREASON"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NEXTRAISEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTREVIEWDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTREVIEWRATING"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NEXTREVIEWDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USER1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER4"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER5"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER6"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER7"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER8"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MISCCHECK1"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MISCCHECK2"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MISCCHECK3"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MISCCHECK4"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MISCCHECK5"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EE401KDEFERRAL"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "EE401KCALC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EE401KCONTINUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EE401KELIGIBLEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EE401KSTATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EE401KSUSPENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ER401KMATCH"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "HIGHCOMP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OWNER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OWNERPERCENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OWNERRELATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OWNERSSN"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "MEMO"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "SHOWMEMO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NEWHIRECALENDARID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "NEWHIRESB"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WORKSTATE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "OFFICER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WAGETYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FAMILY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROBATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DISTRIBUTIONCODES"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "CELLPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MASTERRECORDFORACA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CMSPBJID"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "ADDRESSNOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CONTACTNOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "DEMOGRAPHICNOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "FACEBOOK"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FILESTORAGEUSED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "JOBCATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "JOBNOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "LANGUAGESSPOKEN"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "LINKEDIN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SKYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TWITTERUSERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ESSACCOUNTCREATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NEWHIREHANDLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISPBJ"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISMANAGER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROFILEIMG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FULLNAME"
	type = "VARCHAR(103)"
	nullable = true
}


column {
	name = "UNIONDEDAUTH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIMEZONEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLOCKCARDNO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLOCKFILTER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLOCKMANAGER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLOCKPW"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LEGACYELIGIBLEFORREHIRE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LEGACYEMPSTATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LEGACYEMPTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LEGACYTERMREASON"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TERMREASON"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EMPTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EMPSTATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ELIGIBLEFORREHIRE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYTOSCHEDULE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ATTENDANCEEXCLUDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEBCLOCK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ONBOARDINGID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PBJEMPID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PBJEMPTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ALLOWMISSINGPUNCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKAUTHORIZATIONSTATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "WORKEMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRSTPAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTPAYDATE"
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

