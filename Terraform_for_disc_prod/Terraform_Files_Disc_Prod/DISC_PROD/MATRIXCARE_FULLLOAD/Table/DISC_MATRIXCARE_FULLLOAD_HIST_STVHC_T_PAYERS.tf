resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_PAYERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_PAYERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PAYERS

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
	name = "PAY_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PAY_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_ADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PAY_ADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PAY_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_STATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAY_POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAY_COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_COUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_CONTACTSALUT"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PAY_CONTACTTITLE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_CONTACTFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_CONTACTLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_PHONETYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_PAYERTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_NPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAY_BILLTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_AGENCYPROVIDERNUM"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAY_EXCLUDEFROMBATCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_PAYMENTTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_AUTHREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI01"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI02"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI03"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI04"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI05_1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI06"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI05_2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI07"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI10"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI11"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI12"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI13"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI14"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI15"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_ANSIGSF479"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSIGSF28"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_ANSIGSF455"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSIGSF480"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "PAY_ANSISTF143"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PAY_ANSISTF329"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PAY_ANSISTF1705"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "PAY_ANSIBHTF1005"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "PAY_ANSIHEADERREFF128"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PAY_ANSIHEADERREFF127"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP1000ANM1F98"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP1000BNM1F98"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP1000ANM1F66"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP1000BNM1F66"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSIRECEIVERNAME"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "PAY_ANSIIDTYPE1"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSIIDTYPE2"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSIIDTYPE3"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSIPHYSIDTYPE1"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSIPHYSIDTYPE2"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSIPHYSIDTYPE3"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVOICETOTALROUND"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVOICETOTALROUNDDECIMAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVOICELINEROUND"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVOICELINEROUNDDECIMAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_EDITYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAY_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAY_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_STATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_LEGACYBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_ERNID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAY_ITEMIZE1500BILLING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_ALLOWMASSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_AUTHORIZATIONCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_AUTHORIZATIONCONFLICTSOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_DAILYBENEFIT12AM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_SHOWDFPSPLIT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_SHOWDFPBALANCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_SHOWDFPDAILYBENEFIT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_SHOWDFPVISIT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_USECLIENTFORINSURED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_INVDETAILPROVIDERTYPEID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_USEBILLCONTACTFORSIGN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_USEBILLPROVIDERFORFACILITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_BILLBYSHIFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_STAMPAUTH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_DXVERSIONDEFAULT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_CONTACTSALUTATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_INVBREAKBYAUTH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_INVBREAKBYHCPCS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_INVOICEUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PAY_INVOICEFROMTOTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_SHOWINVFROMDTONLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_ELECTPMTGATEWAYCUSTPROFILEID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAY_ELECTPMTDFLTCUSTPMTPROFILEID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYBRLOGO"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYCRBALANCES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYCARFISTNAMEONLY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYRECENTPMTS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYOUTSTANDINGINV"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYDEPOSITBALANCES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVPARM_PMTWITHINDAYS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_1500OTHRPVDRTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_AUTHORIZATIONFROMPHYSICANORDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_485BOX1USEPOLICYNUMBER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYSCHTIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSIISAFI65"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_DELIVERYMETHOD"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSISBR1032"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP2310A_ENABLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP2310B_ENABLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP2310C_ENABLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSICLM1359"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_ANSICLM1351"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_ANSICLM1331"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSICLM1325"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_ANSICLM1073_1"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAY_EDIPOSTINGTYPEID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP2300REF_9F_ENABLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_EDIADDITIONALID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_EDIADDITIONALIDTYPE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PAY_INVPARM_PAYERINVGROUPBY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP2010BBNM1F1035_1"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP2010BBNM1F66"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP2010BBNM1F67"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYSCHNOTE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_INVOICEGROUPINGTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_WEEKLYBENEFITSTART"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_MONTHLYBENEFITSTART"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP1000ANM1F1035_1"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP1000ANM1F67"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP1000BNM1F67"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PAY_ANSIGSF142"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PAY_ANSIGSF124"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PAY_ANSILOOP2000C_ENABLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_CONTALLOWADJ"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_INVBREAKBYPOC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_EDI837_TERMINATESEGMENTWITHLINEFEED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_INVPARM_DISPLAYRATESCHARGES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_FEATURES"
	type = "NUMBER(10,0)"
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

