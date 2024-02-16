resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_CPCARPLN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_CPCARPLN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_CPCARPLN

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
	type = "VARCHAR(20)"
	nullable = true
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
	nullable = true
}


column {
	name = "ADMISSION_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CARE_PLAN_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CARE_PLAN_DESCRIPTION"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "DDL_CLINIC_CARE_PLAN_ST"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CARE_PLAN_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CARE_PLAN_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNATURE_ARRAY5_1"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "SIGNATURE_ARRAY5_2"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "SIGNATURE_ARRAY5_3"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "SIGNATURE_ARRAY5_4"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "SIGNATURE_ARRAY5_5"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "SIGNATURE_DATE_ARRAY5_1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNATURE_DATE_ARRAY5_2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNATURE_DATE_ARRAY5_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNATURE_DATE_ARRAY5_4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNATURE_DATE_ARRAY5_5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CP_CARE_PLAN_TYPE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "NEXT_REVIEW_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_REVIEW_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DDL_CARE_PLAN_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PRIMARY_DIAGNOSIS"
	type = "VARCHAR(9)"
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

