resource "snowflake_table" "DISC_GENERATIONSALLIANCE_HCFA1500RPT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "HCFA1500RPT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.HCFA1500RPT

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
	name = "PAGENUMBER"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "GENDER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMTYPE_1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INSUREDID_1A"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENTNAME_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENTDOB_3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDRESS_5"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CITY_5"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATE_5"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ZIP_5"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RELATIONSHIPTOINSURED_6"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SIGNATUREONFILE_12"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REFERRALSOURCE_17"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RESERVEDLOCALUSE_19"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DIAGNOSIS_21"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIORAUTHNUMBER_23"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FROM_24A1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "THRU_24A1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POS_24B1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CPT_24D1"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHARGES_24F1"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "UNITS_24G1"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "FROM_24A2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "THRU_24A2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POS_24B2"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CPT_24D2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CHARGES_24F2"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "UNITS_24G2"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "FROM_24A3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "THRU_24A3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POS_24B3"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CPT_24D3"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHARGES_24F3"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "UNITS_24G3"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "FROM_24A4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "THRU_24A4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POS_24B4"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CPT_24D4"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHARGES_24F4"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "UNITS_24G4"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "FROM_24A5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "THRU_24A5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POS_24B5"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CPT_24D5"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHARGES_24F5"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "UNITS_24G5"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "FROM_24A6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "THRU_24A6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POS_24B6"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CPT_24D6"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHARGES_24F6"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "UNITS_24G6"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "FEDID_25"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONAME_33"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COCITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COSTATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COZIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COPHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENTTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTPHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "GROUPNO_9A"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "_11_POLICY_FECA_NO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GRPNO_33"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DIAGREF_24E1"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "DIAGREF_24E2"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "DIAGREF_24E3"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "DIAGREF_24E4"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "DIAGREF_24E5"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "DIAGREF_24E6"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "MOD_241"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD_242"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD_243"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD_244"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD_245"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD_246"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TOS_1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TOS_2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TOS_3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TOS_4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TOS_5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TOS_6"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RESERVEDLOCALUSE_24K"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MOD2_241"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD2_242"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD2_243"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD2_244"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD2_245"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MOD2_246"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NPI1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NPI2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NPI3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NPI4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NPI5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NPI6"
	type = "VARCHAR(10)"
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

