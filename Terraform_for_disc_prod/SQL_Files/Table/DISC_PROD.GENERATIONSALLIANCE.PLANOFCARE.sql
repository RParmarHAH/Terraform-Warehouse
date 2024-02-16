CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.PLANOFCARE (
	CLIENTID NUMBER(10,0) NOT NULL,
	PLANOFCAREID NUMBER(10,0) NOT NULL,
	PATIENTHICLAIMNUM VARCHAR(50),
	STARTCAREDT TIMESTAMP_NTZ(9),
	CERTIFIEDFROM TIMESTAMP_NTZ(9),
	CERTIFIEDTO TIMESTAMP_NTZ(9),
	DME_SUPPLIES VARCHAR(1000),
	SAFETYMEASURES VARCHAR(1000),
	NUTRITIONALREQ VARCHAR(1000),
	ALLERGIES VARCHAR(1000),
	AMPUTATION BOOLEAN,
	INCONTINENCE BOOLEAN,
	CONTRACTURE BOOLEAN,
	HEARING BOOLEAN,
	PARALYSIS BOOLEAN,
	ENDURANCE BOOLEAN,
	AMBULATION BOOLEAN,
	SPEECH BOOLEAN,
	LEGALLYBLIND BOOLEAN,
	DYSPNEA BOOLEAN,
	OTHERLIMITATION BOOLEAN,
	OTHERLIMITATIONDESCR VARCHAR(500),
	COMPLETEBEDREST BOOLEAN,
	BEDRESTBRP BOOLEAN,
	UPASTOLERATED BOOLEAN,
	TRANSFERBEDCHAIR BOOLEAN,
	EXERCISESPRESCRIBED BOOLEAN,
	PARTIALWEIGHTBEARING BOOLEAN,
	INDEPEDENTATHOM BOOLEAN,
	CRUTCHES BOOLEAN,
	CANE BOOLEAN,
	WHEELCHAIR BOOLEAN,
	WALKER BOOLEAN,
	NORESTRICTIONS BOOLEAN,
	OTHERATIVITIESPERMITTED BOOLEAN,
	OTHERACTIVIESPERMITTEDDESCR VARCHAR(500),
	ORIENTED BOOLEAN,
	COMATOSE BOOLEAN,
	FORGETFUL BOOLEAN,
	DEPRESSED BOOLEAN,
	DISORIENTED BOOLEAN,
	LETHARGIC BOOLEAN,
	AGITATED BOOLEAN,
	OTHERMENTALSTATUS BOOLEAN,
	OTHERMENTALSTATUSDESCR VARCHAR(500),
	PROGNOSIS NUMBER(10,0),
	GOALSDISCHARGEPLAND VARCHAR(1000),
	HHARECEIVEDPOTDT TIMESTAMP_NTZ(9),
	PHYSICIAN VARCHAR(255),
	ATTENDINGPHYSICIAN VARCHAR(255),
	PRINCIPLEDIAGNOSIS VARCHAR(10),
	PRINCIPLEDIAGNOSISDATE TIMESTAMP_NTZ(9),
	SURGICALPROCEDURE VARCHAR(10),
	SURGICALPROCEDUREDATE TIMESTAMP_NTZ(9),
	OTHERDIAGNOSIS1 VARCHAR(10),
	OTHERDIAGNOSISDATE1 TIMESTAMP_NTZ(9),
	OTHERDIAGNOSIS2 VARCHAR(10),
	OTHERDIAGNOSISDATE2 TIMESTAMP_NTZ(9),
	OTHERDIAGNOSIS3 VARCHAR(10),
	OTHERDIAGNOSISDATE3 TIMESTAMP_NTZ(9),
	ASSESSEDBY VARCHAR(50),
	ASSESSEDDATE TIMESTAMP_NTZ(9),
	ASSESSMENTREVISEDBY VARCHAR(50),
	REVISEDDATE TIMESTAMP_NTZ(9),
	ASSISTAMBULATION BOOLEAN,
	ASSISTTRANSFERS BOOLEAN,
	BEDCHAIRONLY BOOLEAN,
	ROMEXERSIZES BOOLEAN,
	OTHERMOBILITY VARCHAR(50),
	REYE BOOLEAN,
	LEYE BOOLEAN,
	PERIPHERALONLY BOOLEAN,
	WEARSGLASSES BOOLEAN,
	CLEANGLASSES BOOLEAN,
	HARDOFHEARING BOOLEAN,
	WEARSHEARINGAID BOOLEAN,
	ISDEAF BOOLEAN,
	DIETNORMAL BOOLEAN,
	ISDIABETIC BOOLEAN,
	DIETLOWSODIUM BOOLEAN,
	DIETLIQUIDONLY BOOLEAN,
	ASSISTWITHMEALS BOOLEAN,
	ASSISTWITHMEALSDESCR VARCHAR(50),
	FEEDINGASSISTANCE BOOLEAN,
	FEEDINGINSTRUCTIONS VARCHAR(50),
	BATHINGPARTIAL BOOLEAN,
	BATHINGCOMPLETE BOOLEAN,
	BATHINGTUB BOOLEAN,
	BATHINGSHOWER BOOLEAN,
	BATHINGSPONGEBATH BOOLEAN,
	BATHINGSINK BOOLEAN,
	BATHINGOTHER VARCHAR(50),
	SKINMOISTURIZER BOOLEAN,
	SKINPOWDER BOOLEAN,
	SKINOTHER VARCHAR(50),
	WASHDRYHAIR BOOLEAN,
	WASHANDSET BOOLEAN,
	COMBANDBRUSH BOOLEAN,
	BRUSHANDFLOSS BOOLEAN,
	DENTURECARE BOOLEAN,
	SHAVEFACE BOOLEAN,
	SHAVEAXILLA BOOLEAN,
	SHAVELEGS BOOLEAN,
	ELECTRICRAZOR BOOLEAN,
	SAFETYRAZOR BOOLEAN,
	CLEANNAILS BOOLEAN,
	FILETRIMNAILS BOOLEAN,
	POLISHNAILS BOOLEAN,
	SELFDRESS BOOLEAN,
	HELPSELECTCLOTHES BOOLEAN,
	ASSISTWITHDRESSING BOOLEAN,
	TOILETBATHROOM BOOLEAN,
	TOILETBEDPAN BOOLEAN,
	TOILETURINAL BOOLEAN,
	BEDSIDECOMMODE BOOLEAN,
	WEIGHCLIENT BOOLEAN,
	WEIGHFREQUENCY VARCHAR(50),
	DRIVESSELF BOOLEAN,
	CARGIVERMAYTAKEOUT BOOLEAN,
	CALLBEFORETAKINGOUT BOOLEAN,
	WAIVEROFLIABONFILE BOOLEAN,
	ACCOMPANYONTAXIBUS BOOLEAN,
	OUTDOORRECREATION BOOLEAN,
	GUIDELINES VARCHAR(50),
	HOUSEKEPINGTYPE NUMBER(5,0),
	HOUSEKEEPINGINSTRUCTIONS VARCHAR(255),
	PRINTMEDSONPLANOFCARE BOOLEAN,
	SPECIALINSTRUCTION VARCHAR(16777216),
	HCFA487 VARCHAR(16777216),
	PRINCIPLEDIAGNOSISDESCR VARCHAR(255),
	SURGICALPROCEDUREDESCR VARCHAR(255),
	OTHERDIAGNOSIS1DESCR VARCHAR(255),
	OTHERDIAGNOSIS2DESCR VARCHAR(255),
	OTHERDIAGNOSIS3DESCR VARCHAR(255),
	CREATEDBY VARCHAR(15),
	CREATED TIMESTAMP_NTZ(9),
	UPDATEDBY VARCHAR(15),
	LASTUPDATED TIMESTAMP_NTZ(9),
	TREATMENTFIRST VARCHAR(1000),
	TREATMENTSECOND VARCHAR(7000),
	INCLUDETASK BOOLEAN,
	TOILETDEPENDS BOOLEAN,
	ALZHEIMERS BOOLEAN,
	DEMENTIA BOOLEAN,
	SIGNATUREDATE TIMESTAMP_NTZ(9),
	SIGNATURENAME VARCHAR(100),
	SIGNATUREDATA VARCHAR(16777216),
	INCLUDELIMITATION BOOLEAN,
	INCLUDEDSNA BOOLEAN,
	ATTACHMENT VARCHAR(16777216),
	FILENAME VARCHAR(260),
	ISATTACHMENTTYPE BOOLEAN,
	ISTASKREQUIRED BOOLEAN,
	POCNAME VARCHAR(100),
	CAREPLANTEMPLATEID NUMBER(10,0),
	STATUS VARCHAR(1),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);