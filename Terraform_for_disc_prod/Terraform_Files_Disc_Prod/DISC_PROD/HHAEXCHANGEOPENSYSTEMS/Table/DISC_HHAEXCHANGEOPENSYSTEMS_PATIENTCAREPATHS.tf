resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_PATIENTCAREPATHS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "PATIENTCAREPATHS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PATIENTCAREPATHS

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
	nullable = true
}


column {
	name = "CAREPATHSETUPID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREPATHS"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "ENROLLMENTSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENROLLMENTENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISEASEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ILLNESSMASTERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DIAGNOSISQUESTIONID"
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

