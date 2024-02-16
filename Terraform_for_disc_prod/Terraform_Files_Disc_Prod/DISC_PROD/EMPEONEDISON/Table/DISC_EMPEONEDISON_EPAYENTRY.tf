resource "snowflake_table" "DISC_EMPEONEDISON_EPAYENTRY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "EPAYENTRY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.EPAYENTRY

    -- Purpose : Discovery Data Population

    -- Project : EMPEONEDISON

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
	nullable = false
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TRANS"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "VOIDEDTRANS"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BEGINDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALENDARID"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "BATCH"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PROCESS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TCODE1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TCODE2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TCODE3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TCODE4"
	type = "VARCHAR(10)"
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
	name = "JOBCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VOUCHERNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOCUMENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHECKATTRIBUTES"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NET"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "DIRDEPAMOUNT"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "NETCHECK"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "ACCOUNTID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DIRDEPACCOUNTID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CALCFLAG"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SPECIALCHECK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAXFREQUENCY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DEDUCTIONMULTIPLIER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DEDBLOCKS"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "EARNBLOCKS"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "TAXBLOCKS"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "DIRDEPBLOCKED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACCRUALSBLOCKED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DISTRIBUTIONSBLOCKED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHECKSTUBMEMO"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "USERMEMO"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "USEOVERRIDEOPTIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALCORDER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CLEARED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOURS"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "REGHOURS"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "AUTOPAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHOURS"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "GROSS"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "REGDOLLARS"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "OTDOLLARS"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "WCC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIRDEPBLOCKS"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "CHECKATTRIBUTEID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OVFITWPERCENT"
	type = "NUMBER(6,3)"
	nullable = true
}


column {
	name = "OVSITWPERCENT"
	type = "NUMBER(6,3)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "INYTD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WW"
	type = "NUMBER(9,6)"
	nullable = true
}


column {
	name = "WWTYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISNOCALC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISVOID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISMANUAL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "IMPORTGUID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "EXTRAWITHHOLDINGBLOCKED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REPLACEDCHECKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REPLACEDCHECKNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISREISSUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REISSUEDTRANS"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "VOIDREASON"
	type = "VARCHAR(50)"
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

