resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CLINICALSECTIONTEMPLATEMASTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CLINICALSECTIONTEMPLATEMASTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CLINICALSECTIONTEMPLATEMASTER

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
	name = "SECTIONTEMPLATEMASTERID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PAGETEMPLATEMASTERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SECTIONKEY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SECTIONNAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "STATUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DISPLAYORDER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISASYMPTOMATICOPTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONTROLNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIELDNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HTMLFILENAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "MASTER485CONTROLNAME"
	type = "VARCHAR(100)"
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
	name = "LASTUPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTUPDATEDATE"
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

