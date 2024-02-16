resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_CAREGIVER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_CAREGIVER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_CAREGIVER

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CAR_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "CAR_LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_MIDDLENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_STATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_INTERNALID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CAR_PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CAR_PHONETYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_TITLE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_SKILLCD"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_ADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CAR_ADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CAR_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_STATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CAR_POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CAR_COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_COUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_EMAIL1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_EMAIL2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_TEXTMESSAGE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_BIRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAR_SPOUSENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CAR_ADPFILENUM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_NPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAR_EMPSUBCOD_UD"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CAR_GROUP"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_EMPOTFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAR_TELEPHONYID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "CAR_SUPERVISOR"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAR_MANAGER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAR_INTERNALCASEMGR"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CAR_SHIFTDIFFFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAR_PAYTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CAR_WAGECHARTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_PAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CAR_NUMALLOWANCES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CAR_WITHHOLD"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CAR_PAYPREFERENCE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CAR_VACATIONHOURS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CAR_DDBANKACCTTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CAR_EXCLUDEHOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAR_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAR_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAR_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CAR_ROLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CAR_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_LEGACYBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_EMPSSN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CAR_DDBANKROUTINGNUM"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CAR_DDBANKACCTNUM"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CAR_CALCUNIQUESSN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CAR_BONUSPOINTSTHERSHOLD"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CAR_EMPSEXID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_MARITALSTATID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_EMPSALUTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_NICKNAME"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CAR_ALLOWMASSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAR_REFERRALTERRITORYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_UPLOADTELEPHONY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAR_WSNUMALLOWANCES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CAR_WSWITHHOLD"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CAR_SUISDI_TAXJURISDICTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_FEDFILINGSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CAR_WSFILINGSTATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_WORKSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAR_RSNUMALLOWANCES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CAR_RSWITHHOLD"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CAR_RSFILINGSTATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_TELEPHONYALLOWCAREGIVERPHONE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAR_EDIADDITIONALID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CAR_EDIADDITIONALIDTYPE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CAR_RACEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAR_EMPMHFLAG"
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

