resource "snowflake_table" "DISC_CCSI_EMPROSTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "EMPROSTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.EMPROSTER

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "VARCHAR(99999)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMP_CITY"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "DESK"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CELL_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "A1_COMBINED_CLIENT_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "B1_PHONE_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "C1_ADDRESS_1"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "D_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WK_MAX_HRS"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "SUN_AM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUN_PM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MON_AM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MON_PM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUE_AM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUE_PM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WED_AM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WED_PM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THU_AM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THU_PM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRI_AM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRI_PM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SAT_AM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SAT_PM1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "A1_COMBINED_CLIENT_NAME1"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "B1_PHONE_NUMBER1"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "C1_ADDRESS_11"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "D_CITY1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WK_MAX_HRS1"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "SUN_AM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUN_PM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MON_AM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MON_PM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUE_AM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUE_PM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WED_AM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WED_PM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THU_AM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THU_PM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRI_AM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRI_PM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SAT_AM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SAT_PM2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "A1_COMBINED_CLIENT_NAME2"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "B1_PHONE_NUMBER2"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "C1_ADDRESS_12"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "D_CITY2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WK_MAX_HRS2"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "SUN_AM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUN_PM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MON_AM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MON_PM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUE_AM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUE_PM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WED_AM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WED_PM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THU_AM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THU_PM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRI_AM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRI_PM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SAT_AM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SAT_PM3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ADDRESS2_IN_FIELD_8"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "ADDRESS2_IN_FIELD_27"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "ADDRESS2_IN_FIELD_46"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIIDOA_IN_FIELD_8"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIIDOA_IN_FIELD_27"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIIDOA_IN_FIELD_46"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "SHARED_CODE_IN_FIELD_8"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "SHARED_CODE_IN_FIELD_27"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "SHARED_CODE_IN_FIELD_46"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "REGION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NOT_AVAIL"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "F1_FLAG_FIELD_1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "F1_FLAG_FIELD_2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "F1_FLAG_FIELD_3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(100)"
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

