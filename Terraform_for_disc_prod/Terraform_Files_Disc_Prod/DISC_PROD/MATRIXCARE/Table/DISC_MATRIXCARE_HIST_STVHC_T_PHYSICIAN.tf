resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PHYSICIAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PHYSICIAN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PHYSICIAN

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PHYS_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PHYS_FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PHYS_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYS_COMPANYNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_MIDDLEINITIAL"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PHYS_TITLE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHYS_SEX"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PHYS_SUFFIX"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_CONTACTNAME"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "PHYS_BIRTHDAY"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYS_ADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PHYS_ADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "PHYS_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_STATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHYS_POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHYS_COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_COUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYS_PHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PHYS_PHONETYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYS_SPECIALTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_LICENSENUM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_UPIN"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PHYS_DEANUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_DEADATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYS_EXPIREDT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYS_DATACURRENT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYS_CONTACTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYS_DEGREE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_LICENSESTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_ACTIVITYSTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_TAXID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_TAXTYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PHYS_NPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PHYS_EDIADDITIONALID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHYS_EDIADDITIONALIDTYPE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PHYS_EMAIL"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "PHYS_INFOREQUESTED"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PHYS_NOTES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PHYS_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYS_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYS_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYS_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_TS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PHYS_STATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYS_OASISINTERFACEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYS_ALLOWMASSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PHYS_DEAR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
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

