resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_EVVCODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_EVVCODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_EVVCODES

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
	nullable = true
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ENTRY_USER"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_USER"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVV_CODE"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "EVV_DESCRIPTION"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "BUSINESS_ENTITY_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_CODES"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "FACILITY_CODES"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "PLAN_CODES"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "PROVIDERQUALIFIER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PROVIDERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EVV_USER_NAME"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "EVV_PASSWORD"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "PATIENT_MESSAGE_URL"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "EMPLOYEE_MESSAGE_URL"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "VISIT_MESSAGE_URL"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "SQLSERVER_INSTANCE_NAME"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "SYS_DB_NAME"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "COMPANY_DB_NAME"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "COMPANY_CODE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TEST_OR_PRODUCTION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EVV_INTERFACE_TYPE"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "DDL_FACILITY_PLAN"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FTP_URL"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "SSHHOSTKEYFINGERPRINT"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "FTP_DOWNLOAD_FOLDER"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "USER_DOWNLOAD_FOLDER"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "PORT_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SFTP_INFOLDER"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "SFTP_OUTFOLDER"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "LOCAL_EXPORTIMPORT_FOLDER"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "PROVIDER_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PROVIDER_NPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PROVIDER_EIN_TAXID"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "SENDONLYBILLABLESVCFLAG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SENDONLYMAPPEDVISITSFLAG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SENDVERIFIEDVISITSFLAG"
	type = "NUMBER(3,0)"
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

