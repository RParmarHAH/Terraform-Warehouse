resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_SERVICECODE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_SERVICECODE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_SERVICECODE

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
	name = "SVCC_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SVCC_BILLCODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_ISEXPENSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_ISMULTIPLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_OTHERCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SVCC_DEFAULTCOST"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SVCC_DEFAULTPAYUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SVCC_DEFAULTBILLUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SVCC_CATEGORYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_PAYROLLCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SVCC_DEFAULTREIMBURSMENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SVCC_WC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SVCC_SHIFTPAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_OTPAY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SVCC_BILLEXCLUDEHOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_PAYEXCLUDEHOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_ISCAT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_COMMISSIONRATE"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SVCC_BONUSPOINTS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SVCC_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_REVENUECODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SVCC_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_POCFIRSTBILLABLEFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_EXPENSETYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SVCC_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SVCC_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SVCC_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SVCC_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SVCC_LISTITEMTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SVCC_RPTGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_OVERRIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SVCC_TAXGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_LEGACYBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_ACCTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SVCC_UPLOADTELEPHONY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_TELEPHONYTASKID"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "SVCC_INCLUDEEFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_PROJECTEDAVGBILLVISIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SVCC_PROJECTEDAVGPAYVISIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SVCC_PROJECTEDAVGPAYHOURLY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SVCC_PROJECTEDAVGBILLHOURLY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SVCC_ISCOPY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_ISWORKING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_DEDUCTEARN"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "SVCC_LIVEINRPTHRS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SVCC_ACCTCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SVCC_DISPLAYONCLIENTPORTAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_DISPLAYONCAREGIVERPORTAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SVCC_THERAPYCOUNTINGTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SVCC_MEDICAREDISCIPLINE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SVCC_DOCTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SVCC_ISMULTIPLESERVICE"
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

