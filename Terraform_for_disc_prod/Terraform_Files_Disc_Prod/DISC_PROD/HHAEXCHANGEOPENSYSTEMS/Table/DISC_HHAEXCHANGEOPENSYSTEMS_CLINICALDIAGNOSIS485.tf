resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CLINICALDIAGNOSIS485" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CLINICALDIAGNOSIS485"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CLINICALDIAGNOSIS485

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DIAGNOSIS485ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DIAGNOSISID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MASTER485ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ISPRIMARYDIAGNOSIS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DATETYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ONSETDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(10,0)"
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
	name = "ICD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HISTORICALASOFDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DISPLAYORDER"
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

