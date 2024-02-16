resource "snowflake_table" "DISC_ALAYACARE_PAYROLL_ITEM" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "PAYROLL_ITEM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.PAYROLL_ITEM

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPAY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_PERIOD_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_RUN_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QUANTITY_REG"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QUANTITY_REG_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "QUANTITY_OT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QUANTITY_OT_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "QUANTITY_HOLIDAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QUANTITY_HOLIDAY_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REG"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "OT1"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "PAYCODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IDPAYCODE_HOLIDAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IDPAYCODE_OVERTIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPAY_TYPE_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "COMPUTED_REGULAR_TOTAL"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "COMPUTED_OT_TOTAL"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "COMPUTED_HOLIDAY_TOTAL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RUN_TOTAL_COST"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "RUN_TOTAL_HOURS"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "RUN_TOTAL_OT_HOURS"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "RUN_TOTAL_PREMIUMS"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "RUN_TOTAL_REG_HOURS"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "RUN_TOTAL_SHIFTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RUN_IS_DELETED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RUN_TOTAL_UNAVAILABILITIES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RUN_CREATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RUN_UPDATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RUN_DELETE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIOD_START_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIOD_END_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_ID_PAYROLL_PERIOD"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_TOTAL_COST"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_TOTAL_HOURS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_TOTAL_OT_HOURS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_TOTAL_PREMIUMS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_TOTAL_REG_HOURS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_TOTAL_SHIFTS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_TOTAL_UNAVAILABILITIES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_RUN_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_IDEMPLOYEE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_IDPAYCODE_HOLIDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_IDPAYCODE_OVERTIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_IDPAYITEM"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_IDPAYROLLRUN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_IS_HOLIDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_MEMO"
	type = "VARCHAR(1250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_OT1"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_OT2"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_PAYROLL_PERIOD_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_QUANTITY_HOLIDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_QUANTITY_HOLIDAY_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_QUANTITY_OT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_QUANTITY_OT_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_QUANTITY_REG"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_QUANTITY_REG_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_RATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_RATE_HOLIDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_RATE_OT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_REG"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PAY_ITEM_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}

}

