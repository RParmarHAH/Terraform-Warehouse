resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_INVOICEDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_INVOICEDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_INVOICEDETAILS

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
	name = "INVD_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_INVHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_SCHEDULEPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_SCHEDULEEXPENSEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_RATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_RATEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_CHARGERATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_INVOICERATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_CHARGEUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_CHARGEUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INVD_INVOICEUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_INVOICEUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INVD_CHARGEFLAG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_SPLITTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "INVD_BENEFITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_PMTALLOWANCE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_SPLITPERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVD_BILLCODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_BILLCODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_SCHSHFID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_SHIFTNO"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_HOLIDAYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_HOLIDAYADD"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_HOLIDAYMULT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_SERVICEDATEFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_SERVICEDATETO"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_REVCODE"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "INVD_HCPCS"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "INVD_1500POS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_1500TOS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_1500DIAG"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_1500EPSDT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVD_1500EMG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVD_1500COB"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVD_1500LOCALUSE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVD_UB_FL49"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVD_NONCOVERED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_TOTALCHARGES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_DISCOUNTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_DISCOUNTPERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVD_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVD_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVD_DISPLAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_BATCHTAXGRPID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_TOTALTAXPERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_TOTALTAXFIXEDAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_ACCTEXTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_ROUND"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_ROUNDDECIMAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_OTMULTI"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_OTUNIT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_INCLUDEEFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVD_SERVICEUTCDATEFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_SERVICEUTCDATETO"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_ALLOCATEDAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_1500BILLINGMODIFIERID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_1500BILLINGMODIFIERID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_1500BILLINGMODIFIERID3"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_1500BILLINGMODIFIERID4"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_PROVIDERNPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVD_OTHERIDTYPE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "INVD_OTHERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVD_AUTHORIZATIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_AUTHDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_AUTHCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVD_DEFDAYSREM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_INCLUDETAXES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_ADMISSIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_DETAILSTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_BALANCE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_ADJUSTEDCHARGETOTAL"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_TOTALREVADJUSTMENTS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_TOTALNONREVADJUSTMENTS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_TOTALPAYMENTS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_INVOICEGROUPID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_INVOICEGROUPCOUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_SCHEDULENOTE"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "INVD_NOCALCUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_NOCALCUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INVD_NOCALCDATEFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_NOCALCDATETO"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_TAXPORTION"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_DISPLAYUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_DISPLAYUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INVD_DISPLAYDATEFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_DISPLAYDATETO"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVD_TOTALTAXES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_CONTRACTRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_CONTRACTRATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_CONTRACTRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVD_1500DIAGLABEL"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "INVD_SCHEDULESHIFTPAYERSID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_TRANSFERFROMINVOICEDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_TRANSFERTOINVOICEDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_DRAFTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_OTRATE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_OTCALCTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_PAYROLLBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVD_OTRATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_OTUNITSSUBTRACT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVD_CHARGETOTALWOTAX"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_ALLOCATEDCHARGEWOTAX"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_CHARGETOTAL"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_DISPLAYTOTAL"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_CONTRACTTOTAL"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVD_DISPLAYOTRATE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_DISPLAYOTUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVD_LINEITEMTYPEOVERRIDE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVD_LINEITEMTYPE"
	type = "NUMBER(3,0)"
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

