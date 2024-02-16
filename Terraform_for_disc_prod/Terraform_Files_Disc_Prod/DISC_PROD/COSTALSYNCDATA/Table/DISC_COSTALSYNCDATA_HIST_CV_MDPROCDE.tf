resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_MDPROCDE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_MDPROCDE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_MDPROCDE

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(15)"
	nullable = false
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ENTRY_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROCCODE"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "PRODESC1"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "PROCDESC2"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "CPTCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "UNIT_FEE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PROC_CAT"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SPECIALTY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PLACE_OF_SERVICE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "RECALL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RECALL_DAYS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TYPE_OF_SERVICE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "STATEMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CHARGE_ENTRY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DISCONTINUED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DISCONTINUED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TAXABLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STANDARD_UNITS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CLAIM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ELECTRONIC_CLAIM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "UNIT_COST"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DURATION"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "REVENUE_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "ICD9_CM_CODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "HCPCS_CODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PRESCRIPTION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CONVERSION_FACTOR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NDC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NDC_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CB_TIME_BILLING"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BASE_UNITS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BASE_UNIT_TIME"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BREAK_POINT"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BREAK_UNIT_TIME"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PTD_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CASH_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CHECK_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CREDIT_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_INSURANCE_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_OTHER_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_CONTRACTUAL"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_ADJUSTMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PTD_PROCEDURE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YTD_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CASH_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CHECK_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CREDIT_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_INSURANCE_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_OTHER_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_CONTRACTUAL"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD__ADJUSTMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YTD_PROCEDURE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PREVIOUS_BALANCE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CB_EXPAND_PANEL_CODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "TAX_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "WORK_RVU"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PE_RVU"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MP_RVU"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "RBRVS_UNITS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "RBRVS_VALUE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "RECALLRESN_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFIER_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "UNIT_OF_MEASURE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "VALUE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DISCIPLINE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "VALUE_CODE_MULTI_FAC"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NDC_QUALIFIER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFIER2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFIER3"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFIER4"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
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

