resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_ADMISSIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "ADMISSIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.ADMISSIONS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ADMISSIONID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PLACEMENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CHHAID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ALTPATIENTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SOURCEOFADMISSIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISCHARGEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCHARGETO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISCHARGENOTE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISCHARGEREASON"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HASSURPLUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SURPLUSAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRACTPAYSPERCENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PRIVATEPAYSPERCENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "DEDUCTIBLEAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "DEDUCTIBLEDURATION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AMOUNTLIMITPERDAY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "AMOUNTLIMITPERWEEK"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "AMOUNTLIMITPERMONTH"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCANFILENAME"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "SCANFILEGUID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERRELATION"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERINSURANCENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERADDRESS1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERADDRESS2"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERZIPCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SECINSNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECSUBSCRIBERINSURANCEPAYERNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMFILLINGCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCLUDESECPAYERINFOEBILLINGEXPORT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SECSUBSCRIBERASPATIENTNAME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SECSUBSCRIBERADDRESSTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECONDARYPAYSPERCENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SECONDARYCHHAID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONTHLYBILLING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MONTHLYBILLINGDAY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONTHLYBILLINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MONTHLYSERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONTHLYCAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONTHLYPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONTHLYSTARTTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "MONTHLYENDTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "ADMOFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DEDUCTIBLEANDAMOUNTLIMITAPPLYON"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MULTIPAYERVISITTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DFTAPATIENT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PRIVATEPAYSERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTBILLINGDIAGNOSISCODES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LIMITMAXIMUMPAYERCONTRIBUTIONPERPERIOD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUTHLIMITPERDAY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "AUTHLIMITPERWEEK"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "AUTHLIMITPERMONTH"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "AUTHLIMITPERYEAR"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "AUTHLIMITPERLIFETIME"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "LIMITFORADDITIONALINVOICE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYMENTADJUSTMENTREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYMENTADJUSTMENTREASON"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ELIMINATIONPERIOD"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ELIMINATIONPERIODDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ELIMINATIONPERIODCOUNTDAYSTYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ELIMINATIONPERIODADJUSTMENTREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ELIMINATIONPERIODADJUSTMENTREASON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ELIMINATIONPERIODSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILLINGSTARTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LIMITFORADDITIONALINVOICENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYERRANKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYERPLACEMENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PREVENTDISCHARGEDATEUPDATE"
	type = "VARCHAR(3)"
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

