resource "snowflake_table" "DISC_GENERATIONSALLIANCE_HCFA1500" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "HCFA1500"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.HCFA1500

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "HCFAID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "_1_INSURANCETYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "_1A_INSUREDIDFIELD"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "_6_RELATIONSHIPTOINSURED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "_12_SIGNATUREONFILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "_17_REFERRALSOURCEFIELD"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "_19_RESERVEDFORLOCALUSE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "_21_USEGLOBALDIAGNOSIS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "_21_GLOBALDIAGNOSIS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "_24A_DETAILEDOPTION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "_24B_PLACEOFSERVICE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "_24G_DAYSORUNITS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "_23_REFERRALNUMBER"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "_9A_OTHERINSUREDPOLICYNO"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "_11_POLICY_FECA_NO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "_9A_USEMEDRECNO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GRPNO_33"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ACCEPTASSIGNMENT27"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "_24K_RESERVEDLOCALUSE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "_33PIN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OVERRIDELINE33"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OVERRIDELINE33VALUE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "OVERRIDEPHONE33"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LEFTMARGIN"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOPMARGIN"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EMG_24C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NPI33A_RPTUIOVERRIDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PICA_RIGHT"
	type = "VARCHAR(3)"
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

