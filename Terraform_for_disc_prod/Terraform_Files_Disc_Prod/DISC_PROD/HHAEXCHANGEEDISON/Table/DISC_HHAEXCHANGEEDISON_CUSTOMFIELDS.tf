resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_CUSTOMFIELDS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "CUSTOMFIELDS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.CUSTOMFIELDS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CUSTOMFIELDID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CUSTOMFIELDTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CUSTOMFIELDTYPETEXT"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "COMPANYTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "COMPANYTYPETEXT"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CONTROLTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CONTROLTYPETEXT"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "CONTROLSEQ"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CONTROLVALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTROLCAPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTROLSTATUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONTROLSTATUSTEXT"
	type = "VARCHAR(7)"
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
	name = "ISDATECONTROL"
	type = "BOOLEAN"
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

