resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CLINICALOTHER485" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CLINICALOTHER485"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CLINICALOTHER485

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
	name = "OTHER485ID"
	type = "NUMBER(10,0)"
	nullable = false
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
	name = "FLAMBULATION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLBOWEL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLCONTRACSTURE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLHEARING"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLPARALYSIS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLENDURANCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLAMPUTATION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLSPEECH"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLLEGALYBLIND"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLDYSPNEA"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLOTHER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTCOMPLETEBEDREST"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTBEDRESTWITHBRP"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTUPASTOLERATED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTTRANSFER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTEXCERCISE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTPARTIALWEIGHTBEARING"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTINDEPENDENTATHOME"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTCRUTCHES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTCANE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTWEELCHAIR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTWALKER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTNORESTRICTIONS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTOTHER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MENORIENTED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MENCOMATOSE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MENFORGETFUL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MENDEPRESSED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MENDISORIENTED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MENLETHARGIC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MENAGITATED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MENOTHER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTHERS"
	type = "VARCHAR(16777216)"
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
	name = "PROGPOOR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROGGUARDED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROGFAIR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROGGOOD"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROGEXCELLENT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLOTHERTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ACTOTHERTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "MENOTHERTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DMEOTHERTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SAFETYOTHERTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "NUTOTHERTEXT"
	type = "VARCHAR(500)"
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

