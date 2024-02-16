resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_CAREGIVERCUSTOMFIELDS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "CAREGIVERCUSTOMFIELDS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.CAREGIVERCUSTOMFIELDS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CAREGIVERCUSTOMFIELDID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TEXT1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT4"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT5"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT6"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT7"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT8"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT9"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT10"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT11"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT12"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT13"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT14"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT15"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT16"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT17"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT18"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT19"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT20"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT21"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT22"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT23"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT24"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT25"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT26"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT27"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT28"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT29"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TEXT30"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN1"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN2"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN3"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN4"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN5"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN6"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN7"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN8"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN9"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWN10"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CHECKBOX1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX6"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX7"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX8"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX9"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX10"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX11"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX12"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX13"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX14"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX15"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX16"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX17"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX18"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX19"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CHECKBOX20"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE4"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE5"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE6"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE7"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE8"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE9"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE10"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT4"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT5"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT6"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT7"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT8"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT9"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT10"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN11"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE11"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT11"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN12"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE12"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT12"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN13"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE13"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT13"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN14"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE14"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT14"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN15"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE15"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT15"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN16"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE16"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT16"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN17"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE17"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT17"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN18"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE18"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT18"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN19"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE19"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT19"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWN20"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DROPDOWNVALUE20"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DROPDOWNTEXT20"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
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

