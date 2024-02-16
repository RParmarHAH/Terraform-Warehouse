resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_PATIENTPERSONALCONTACTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_PATIENTPERSONALCONTACTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_PATIENTPERSONALCONTACTS

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
	type = "VARCHAR(25)"
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
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "SEQUENCE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = false
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MIDDLE_INITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "RLNSHIP__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "NEXT_OF_KIN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PRIMARY_CAREGIVER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EMERGENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_RESPONSIBLE_PARTY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_SECONDARY_RESPONSIBLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POWER_OF_ATTORNEY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SAME_ADDRESS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ADDRESS_1"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "ADDRESS_2"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "WORK_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BEEPER_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BEEPER_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "FAX_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "E_MAIL_ADDRESS"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "BEREAVEMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RISK_SCORE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMPLOYER_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CONTACT_PERSON"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "CONTACT_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EXTENSION_NUMBER"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "STATRT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REMARK"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BIRTH_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SEX"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SALUTE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PERSONAL_CONTACT_TYPE_CD"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_WILLING_TO_PRVDE_CARE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_ABILITY_TO_PRVDE_CARE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_AVAIL_TO_PROVIDE_CARE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAT_SCH_CONTACT_NOTES"
	type = "VARCHAR(2048)"
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

