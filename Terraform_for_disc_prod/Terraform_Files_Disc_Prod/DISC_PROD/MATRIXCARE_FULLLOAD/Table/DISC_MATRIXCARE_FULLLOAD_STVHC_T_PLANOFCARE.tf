resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_PLANOFCARE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_PLANOFCARE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_PLANOFCARE

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "POC_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POC_ADMISSIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POC_CERTSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_CERTENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_MSAID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_CBSAID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_HHRGID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_HIPPSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_PPSSUPPLYCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "POC_PPSSUPPLIESPROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_PPSSUPPLIESPROVIDEDMODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POC_PPSSUPPLIESPROVIDEDMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_INTAKEBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POC_GIVENBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POC_NOTES"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "POC_TREATMENTAUTHORIZATION"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "POC_ALERGIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSORIENTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSFORGETFUL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSDISORIENTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSAGITATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSCOMATOSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSDEPRESSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSLETHARGIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSOTHER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_MENTALSTATUSOTHERDESC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_PROGNOSISPOOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_PROGNOSISGUARDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_PROGNOSISFAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_PROGNOSISGOOD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_PROGNOSISEXELLENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ASSISTDEVICES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "POC_DMESUPPLIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_SAFETYMEASURES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_NUTRITIONALREQUIREMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONAMPUTATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONBOWELBALDDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONCONTRACTURE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONHEARING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONPARALYSIS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONENDURANCE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONAMBULATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONSPEECH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONVISION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONDYSPNEA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONOTHER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_FUNCTIONALLIMITATIONOTHERDESC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDCOMPLETEBEDREST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDBEDRESTBRP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDUPASTOLERATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDTRANSFERBEDTOCHAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDINDEPENDENTATHOME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDPARTIALWEIGHTBEARING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDCRUTCHES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDCANE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDWHEELCHAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDWALKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDNORESTRICTIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDEXERCISEPRESCRIBED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDOTHER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POC_ACTIVITIESPERMITTEDOTHERDESC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_HHASPECIALINSTRUCTIONS"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "POC_HHAACTIVITIES"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "POC_HHAOTHERINSTRUCTIONS"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "POC_DIAGNOSIS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "POC_DIAGNOSISNOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "POC_PHARMACYNAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POC_PHARMACYPHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POC_PHARMACYFAX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POC_OASISLOCKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_BILLINGPROCESSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_BILLINGSTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_BILLINGFIRSTVISITSCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POC_GOALS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_REHABILITATIONPOTENIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_DISCHARGEPLANS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_PHYSICIANID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POC_CAREPLANTRACKINGDUEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_CAREPLANTRACKINGSENTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_CAREPLANTRACKINGSECONDSENTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_CAREPLANTRACKINGDATERECEIVED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_CAREPLANTRACKINGNOTES"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "POC_OASISINTERFACEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POC_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POC_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POC_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "POC_HEIGHT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "POC_WEIGHT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "POC_485PROCESSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_485STATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_485ASSESSMENTHISTORYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POC_VERBALSTARTOFCAREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POC_485DIAGNOSISVERSION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POC_PRECLAIMREVIEWUTN"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "POC_SERVICEPLANHEADERDRAFTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POC_SERVICEPLANHEADERFINALIZEDID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POC_FEATURES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_HHAQUALIFYINGTASKS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_HHAPAYERREQUIREMENTSNOTES"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "POC_ADVANCEDDIRECTIVES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_ADVANCEDDIRECTIVESOTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_HOSPITALRISKFACTOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POC_COGNITIVEPSYCHOSOCIALSTATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POC_COGNITIVEPSYCHOSOCIALSTATUSOTHER"
	type = "VARCHAR(16777216)"
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

