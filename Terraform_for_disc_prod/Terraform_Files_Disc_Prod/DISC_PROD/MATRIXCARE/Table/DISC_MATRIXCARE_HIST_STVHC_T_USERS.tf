resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_USERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_USERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_USERS

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
	name = "USER_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "USER_FIRSTNAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "USER_LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER_USERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER_REPORTUSERNAME"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "USER_ADDRESS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "USER_ADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "USER_ADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "USER_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER_STATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "USER_POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "USER_COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER_COUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "USER_PHONETYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_LASTLOGIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USER_LAN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_ATTEMPTS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "USER_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_RETRIESEXC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_WORKINGBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_IMAGELOADING"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGCALENDERWEEKSTARTDAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_DEFAULTTRAVELTIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGCONFLICTOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGSCHEDULECONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGAVAILABILITYCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGDNUCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGAUTHORIZATIONCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGCAREGIVEREXPIRATIONSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGCHECKFOROVERTIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_NEXTPAYROLLDATEFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_DEFAULTPAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USER_USELOCALHELP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_AUTOLOGOFFTIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_DEFAULTFILELOCATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USER_SHOWDASHBOARDPAGEONSTARTUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CARBIRTHDAYREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CARBIRTHDAYPRIORREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CARBIRTHDAYFOLLOWINGREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CARANNIVERSARYREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CARANNIVERSARYPRIORREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CARANNIVERSARYFOLLOWINGREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CARKEYDATESREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CARKEYDATESPRIORREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CARKEYDATESFOLLOWINGREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CARTRAININGREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CARTRAININGPRIORREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CARTRAININGFOLLOWINGREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CLIBIRTHDAYREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CLIBIRTHDAYPRIORREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CLIBIRTHDAYFOLLOWINGREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CLIANNIVERSARYREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CLIANNIVERSARYPRIORREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CLIANNIVERSARYFOLLOWINGREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CLIDOCUMENTSREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CLIDOCUMENTSPRIORREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_CLIDOCUMENTSFOLLOWINGREMINDERDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_MISCACTIVITIESREMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USER_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USER_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USER_DEFINQUIRYVIEW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_DEFCLIENTVIEW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_DEFCAREGIVERVIEW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_REMINDERSPINONSTARTUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_DEFREFSOURCEVIEW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_DRIVELISTPINONSTARTUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_DRIVELISTXML"
	type = "VARIANT"
	nullable = true
}


column {
	name = "USER_ACTCALDAYSBEFORE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_ACTCALDAYSAFTER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_UITIMEZONEFROM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_CAREGIVERMAPID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "USER_CLIENTMAPID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "USER_EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER_ALLOWMASSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_SHOWNOTIFICATIONSONSTARTUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_SCHEDULINGCHECKNODAYSFORBALANCE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGCHECKFORBALANCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_FAVORITES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "USER_MAPTOTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_MAPTOENTITYTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_MAPTOENTITYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "USER_AUTHFLAGS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "USER_EULAPORTALSIGNDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USER_EULASONETOSIGNDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGSKILLGROUPCHECKALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_MUSTCHANGEPASSWORD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USER_PWDCHANGEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "USER_SCHEDULINGCGSTATUSCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_SCHEDULINGCHECKFORMAXHOURS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USER_HIDDEN"
	type = "BOOLEAN"
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

