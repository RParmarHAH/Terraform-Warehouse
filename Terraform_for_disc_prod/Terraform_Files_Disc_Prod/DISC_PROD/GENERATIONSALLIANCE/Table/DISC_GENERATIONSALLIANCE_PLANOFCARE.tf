resource "snowflake_table" "DISC_GENERATIONSALLIANCE_PLANOFCARE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "PLANOFCARE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.PLANOFCARE

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
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PLANOFCAREID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PATIENTHICLAIMNUM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STARTCAREDT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFIEDFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFIEDTO"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DME_SUPPLIES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SAFETYMEASURES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NUTRITIONALREQ"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ALLERGIES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "AMPUTATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCONTINENCE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONTRACTURE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEARING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PARALYSIS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENDURANCE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMBULATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPEECH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LEGALLYBLIND"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DYSPNEA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHERLIMITATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHERLIMITATIONDESCR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "COMPLETEBEDREST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BEDRESTBRP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UPASTOLERATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRANSFERBEDCHAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXERCISESPRESCRIBED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PARTIALWEIGHTBEARING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INDEPEDENTATHOM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CRUTCHES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CANE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WHEELCHAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WALKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NORESTRICTIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHERATIVITIESPERMITTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHERACTIVIESPERMITTEDDESCR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ORIENTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COMATOSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FORGETFUL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEPRESSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DISORIENTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LETHARGIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AGITATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHERMENTALSTATUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHERMENTALSTATUSDESCR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PROGNOSIS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "GOALSDISCHARGEPLAND"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "HHARECEIVEDPOTDT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYSICIAN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ATTENDINGPHYSICIAN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PRINCIPLEDIAGNOSIS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PRINCIPLEDIAGNOSISDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SURGICALPROCEDURE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SURGICALPROCEDUREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSIS1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSISDATE1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSIS2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSISDATE2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSIS3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSISDATE3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASSESSEDBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASSESSEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASSESSMENTREVISEDBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVISEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASSISTAMBULATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ASSISTTRANSFERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BEDCHAIRONLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ROMEXERSIZES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHERMOBILITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REYE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LEYE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERIPHERALONLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEARSGLASSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLEANGLASSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HARDOFHEARING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEARSHEARINGAID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISDEAF"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIETNORMAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISDIABETIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIETLOWSODIUM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIETLIQUIDONLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ASSISTWITHMEALS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ASSISTWITHMEALSDESCR"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FEEDINGASSISTANCE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FEEDINGINSTRUCTIONS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BATHINGPARTIAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATHINGCOMPLETE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATHINGTUB"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATHINGSHOWER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATHINGSPONGEBATH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATHINGSINK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATHINGOTHER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SKINMOISTURIZER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SKINPOWDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SKINOTHER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WASHDRYHAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WASHANDSET"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COMBANDBRUSH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BRUSHANDFLOSS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DENTURECARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHAVEFACE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHAVEAXILLA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHAVELEGS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ELECTRICRAZOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SAFETYRAZOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLEANNAILS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FILETRIMNAILS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POLISHNAILS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SELFDRESS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HELPSELECTCLOTHES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ASSISTWITHDRESSING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOILETBATHROOM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOILETBEDPAN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOILETURINAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BEDSIDECOMMODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEIGHCLIENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEIGHFREQUENCY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DRIVESSELF"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARGIVERMAYTAKEOUT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALLBEFORETAKINGOUT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WAIVEROFLIABONFILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACCOMPANYONTAXIBUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OUTDOORRECREATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GUIDELINES"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOUSEKEPINGTYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HOUSEKEEPINGINSTRUCTIONS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PRINTMEDSONPLANOFCARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPECIALINSTRUCTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HCFA487"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRINCIPLEDIAGNOSISDESCR"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SURGICALPROCEDUREDESCR"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSIS1DESCR"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSIS2DESCR"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "OTHERDIAGNOSIS3DESCR"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TREATMENTFIRST"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "TREATMENTSECOND"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "INCLUDETASK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOILETDEPENDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALZHEIMERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEMENTIA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SIGNATUREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNATURENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SIGNATUREDATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INCLUDELIMITATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDEDSNA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ATTACHMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(260)"
	nullable = true
}


column {
	name = "ISATTACHMENTTYPE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISTASKREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POCNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CAREPLANTEMPLATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
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

