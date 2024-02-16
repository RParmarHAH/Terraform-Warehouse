resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_PATIENTMDORDER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "PATIENTMDORDER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.PATIENTMDORDER

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

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
	name = "MDORDERID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MDORDER_NUMBER"
	type = "VARCHAR(24)"
	nullable = true
}


column {
	name = "CERTSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(20)"
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
	name = "CERTIFICATIONPERIODID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRINTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SENTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HHASIGNEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DMEANDSUPPLIES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SAFETYMEASURES"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "NUTRITIONREQUIREMENTS"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "FUNCTIONALLIMITATIONS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "ACTIVITIESPERMITTED"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "MENTALSTATUS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "PROGNOSIS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SNORDERS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SNGOALS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCTASKS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDEROTHERS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GOALOTHERS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCANFILENAME"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "SCANFILEGUID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "MDORDERVERSION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLINICALDOCID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ICD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DISPLAYMDORDERAIDETABAS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FAXLOGSTATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FAXLOGSTATUSTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SENTDATEMANUAL"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FORMCLINICALDOCID"
	type = "NUMBER(19,0)"
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

