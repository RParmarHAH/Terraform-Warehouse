resource "snowflake_table" "DISC_DEVERO_DEVERO_PATIENT_PROFILE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_PATIENT_PROFILE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_PATIENT_PROFILE

    -- Purpose : Discovery Data Population

    -- Project : DEVERO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PATIENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFICATION_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_CREATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_MODIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_FIRST_SENT_TO_OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_LAST_SENT_TO_OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYINSURANCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYINSURANCENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARYINSURANCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARYINSURANCENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARENUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0064SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0066BIRTHDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATEOFDEATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RACEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RACECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040MIDDLEINIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0050STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0060ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CELLPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTEMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPC_INSURANCEEFFECTIVEFROM_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPC_INSURANCEEFFECTIVETO_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPCSTATUSID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASEMANAGERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPCAGENCYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPCAGENCYNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPCAGENCYSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICALRECORDNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGSYSTEMPATIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STARTOFCAREDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFLNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFFNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAJORCROSSSTREET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_VALUES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

