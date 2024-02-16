resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_INVOICEHEADER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_INVOICEHEADER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_INVOICEHEADER

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
	name = "INVH_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "INVH_INVOICENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_INVOICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_PERIODCLOSEDID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_BILLTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_STATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_BATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_DRAFTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_POCID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_INVOICETOTALROUND"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVH_INVOICETOTALROUNDDECIMAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVH_INVOICELINEROUND"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVH_INVOICELINEROUNDDECIMAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVH_CANCELDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_CANCELUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVH_CLIENTCONTROLNO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_TYPEOFBILL"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_FEDTAXID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "INVH_STATEMENTFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_STATEMENTTHROUGH"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_CLIENTLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_CLIENTFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_CLIENTMIDDLENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_CLIENTSUFFIXNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_ADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "INVH_ADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "INVH_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_STATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_COUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_DOB"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_SEX"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "INVH_CLIENTNUMBER"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "INVH_PRVDRNAME"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "INVH_PRVDRADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "INVH_PRVDRADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "INVH_PRVDRCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PRVDRSTATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_PRVDRPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_PRVDRCOUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PRVDRCOUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_PRVDRTELEPHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "INVH_PRVDRFAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "INVH_PRVDREMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PRVDRNPI"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "INVH_PRVDRTYPE1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "INVH_PRVDRID1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PRVDRTYPE2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "INVH_PRVDRID2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PRVDRTYPE3"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "INVH_PRVDRID3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PAYNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PAYADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "INVH_PAYADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "INVH_PAYCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PAYSTATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_PAYPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_PAYCOUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PAYCOUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_ADMISSIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_ADMISSIONHR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_ADMISSIONTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_ADMISSIONSRC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_MEDICALRECORDNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_RPARTYNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_RPARTYADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "INVH_RPARTYADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "INVH_RPARTYCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_RPARTYSTATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_RPARTYPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_RPARTYCOUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_RPARTYCOUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_CURRENTPAYERLOCATION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVH_PAYER1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PROVIDERNO1"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_RELINFO1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "INVH_ASGBEN1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "INVH_PRIORPAYMENTS1"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ESTAMOUNTDUE1"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_PAYER2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PROVIDERNO2"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_RELINFO2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "INVH_ASGBEN2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "INVH_PRIORPAYMENTS2"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ESTAMOUNTDUE2"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_PAYER3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_PROVIDERNO3"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVH_RELINFO3"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "INVH_ASGBEN3"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "INVH_PRIORPAYMENTS3"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ESTAMOUNTDUE3"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_DUEFROMPATIENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_INSUREDSNAME1"
	type = "VARCHAR(102)"
	nullable = true
}


column {
	name = "INVH_P_REL1"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "INVH_GROUPNAME1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_INSURANCEGROUPNO1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_INSUREDSNAME2"
	type = "VARCHAR(102)"
	nullable = true
}


column {
	name = "INVH_P_REL2"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "INVH_GROUPNAME2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_INSURANCEGROUPNO2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_INSUREDSNAME3"
	type = "VARCHAR(102)"
	nullable = true
}


column {
	name = "INVH_P_REL3"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "INVH_GROUPNAME3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_INSURANCEGROUPNO3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_TREATMENTAUTHCODE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_EMPLOYERNAME1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_TREATMENTAUTHCODE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_EMPLOYERNAME2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_TREATMENTAUTHCODE3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_EMPLOYERNAME3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_ICDVERSION"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "INVH_PRINDIAGCD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_ADMDIAGCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_VISITREASON1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_VISITREASON2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_VISITREASON3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_PPSCODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "INVH_ECODE1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_ECODE2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_ECODE3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVH_ATTEND_PHYSID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_OPER_PHYSID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_OTHER_PHYSID1"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_OTHER_PHYSID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_REMARKS"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "INVH_UB04"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_OTHERDIAGNOSTICSCODEDATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_PROCEDURECODEDATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_ATTENDINGPHYSICANDATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_OPERATINGPHYSICIANDATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_OTHERPHYSICIAN1DATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_OTHERPHYSICIAN2DATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_CMS1500"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_LEGACYBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_ACCTEXTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_BALANCE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_TOTALCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_CLIENTPHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "INVH_ADMISSIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_EFTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_CLIENTPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_SIGNEDNAME"
	type = "VARCHAR(102)"
	nullable = true
}


column {
	name = "INVH_SIGNEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVH_AUTHCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVH_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVH_ORIGINALSERVCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ORIGINALEXPCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ORIGINALTAXCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ADJUSTEDSERVCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ADJUSTEDEXPCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ADJUSTEDTAXCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_DISPLAYTOTAL"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_ORIGINALCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVH_INVOICEVERSION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_GROUPINGPROCESSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_INVOICEPRINTLINE"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "INVH_ROLLUPTAXESONPRINT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVH_CERT_SSN_HIC_ID_NO1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "INVH_CERT_SSN_HIC_ID_NO2"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "INVH_CERT_SSN_HIC_ID_NO3"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "INVH_JOINICDVERSION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVH_TRANSFERFROMINVOICEHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_TRANSFERTOINVOICEHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_TRANSFERTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVH_COBINVOICEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_SCHEDULEPAYERSCHECKSUM"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_COBSEQUENCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_CANCELEFTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVH_ASSOCIATEDPPSINVOICEHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVH_ROYALTYFRONTPERCENTAGE"
	type = "NUMBER(18,0)"
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

