resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_PATIENTPROFESSIONALCONTACTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_PATIENTPROFESSIONALCONTACTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_PATIENTPROFESSIONALCONTACTS

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
	name = "PROFESSIONAL_CONTACTCODE"
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
	name = "REMARK"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "PROF_CONT_TYP_CDE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "FAX_NUMBER"
	type = "VARCHAR(11)"
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

