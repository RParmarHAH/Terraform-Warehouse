CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_PLANOFCARE (
	POC_ID NUMBER(19,0) NOT NULL,
	POC_ADMISSIONID NUMBER(19,0),
	POC_CERTSTARTDATE TIMESTAMP_NTZ(9),
	POC_CERTENDDATE TIMESTAMP_NTZ(9),
	POC_MSAID NUMBER(10,0),
	POC_CBSAID NUMBER(10,0),
	POC_HHRGID NUMBER(10,0),
	POC_HIPPSID NUMBER(10,0),
	POC_PPSSUPPLYCODE VARCHAR(1),
	POC_PPSSUPPLIESPROVIDED BOOLEAN,
	POC_PPSSUPPLIESPROVIDEDMODIFIEDUSER VARCHAR(50),
	POC_PPSSUPPLIESPROVIDEDMODIFIEDDATE TIMESTAMP_NTZ(9),
	POC_INTAKEBY VARCHAR(50),
	POC_GIVENBY VARCHAR(50),
	POC_NOTES VARCHAR(512),
	POC_TREATMENTAUTHORIZATION VARCHAR(18),
	POC_ALERGIES VARCHAR(16777216),
	POC_MENTALSTATUSORIENTED BOOLEAN,
	POC_MENTALSTATUSFORGETFUL BOOLEAN,
	POC_MENTALSTATUSDISORIENTED BOOLEAN,
	POC_MENTALSTATUSAGITATED BOOLEAN,
	POC_MENTALSTATUSCOMATOSE BOOLEAN,
	POC_MENTALSTATUSDEPRESSED BOOLEAN,
	POC_MENTALSTATUSLETHARGIC BOOLEAN,
	POC_MENTALSTATUSOTHER BOOLEAN,
	POC_MENTALSTATUSOTHERDESC VARCHAR(16777216),
	POC_PROGNOSISPOOR BOOLEAN,
	POC_PROGNOSISGUARDED BOOLEAN,
	POC_PROGNOSISFAIR BOOLEAN,
	POC_PROGNOSISGOOD BOOLEAN,
	POC_PROGNOSISEXELLENT BOOLEAN,
	POC_ASSISTDEVICES VARCHAR(255),
	POC_DMESUPPLIES VARCHAR(16777216),
	POC_SAFETYMEASURES VARCHAR(16777216),
	POC_NUTRITIONALREQUIREMENTS VARCHAR(16777216),
	POC_FUNCTIONALLIMITATIONAMPUTATION BOOLEAN,
	POC_FUNCTIONALLIMITATIONBOWELBALDDER BOOLEAN,
	POC_FUNCTIONALLIMITATIONCONTRACTURE BOOLEAN,
	POC_FUNCTIONALLIMITATIONHEARING BOOLEAN,
	POC_FUNCTIONALLIMITATIONPARALYSIS BOOLEAN,
	POC_FUNCTIONALLIMITATIONENDURANCE BOOLEAN,
	POC_FUNCTIONALLIMITATIONAMBULATION BOOLEAN,
	POC_FUNCTIONALLIMITATIONSPEECH BOOLEAN,
	POC_FUNCTIONALLIMITATIONVISION BOOLEAN,
	POC_FUNCTIONALLIMITATIONDYSPNEA BOOLEAN,
	POC_FUNCTIONALLIMITATIONOTHER BOOLEAN,
	POC_FUNCTIONALLIMITATIONOTHERDESC VARCHAR(16777216),
	POC_ACTIVITIESPERMITTEDCOMPLETEBEDREST BOOLEAN,
	POC_ACTIVITIESPERMITTEDBEDRESTBRP BOOLEAN,
	POC_ACTIVITIESPERMITTEDUPASTOLERATED BOOLEAN,
	POC_ACTIVITIESPERMITTEDTRANSFERBEDTOCHAIR BOOLEAN,
	POC_ACTIVITIESPERMITTEDINDEPENDENTATHOME BOOLEAN,
	POC_ACTIVITIESPERMITTEDPARTIALWEIGHTBEARING BOOLEAN,
	POC_ACTIVITIESPERMITTEDCRUTCHES BOOLEAN,
	POC_ACTIVITIESPERMITTEDCANE BOOLEAN,
	POC_ACTIVITIESPERMITTEDWHEELCHAIR BOOLEAN,
	POC_ACTIVITIESPERMITTEDWALKER BOOLEAN,
	POC_ACTIVITIESPERMITTEDNORESTRICTIONS BOOLEAN,
	POC_ACTIVITIESPERMITTEDEXERCISEPRESCRIBED BOOLEAN,
	POC_ACTIVITIESPERMITTEDOTHER BOOLEAN,
	POC_ACTIVITIESPERMITTEDOTHERDESC VARCHAR(16777216),
	POC_HHASPECIALINSTRUCTIONS VARCHAR(512),
	POC_HHAACTIVITIES VARCHAR(512),
	POC_HHAOTHERINSTRUCTIONS VARCHAR(512),
	POC_DIAGNOSIS VARCHAR(255),
	POC_DIAGNOSISNOTES VARCHAR(255),
	POC_PHARMACYNAME VARCHAR(30),
	POC_PHARMACYPHONE VARCHAR(30),
	POC_PHARMACYFAX VARCHAR(30),
	POC_OASISLOCKDATE TIMESTAMP_NTZ(9),
	POC_BILLINGPROCESSID NUMBER(10,0),
	POC_BILLINGSTATUSID NUMBER(10,0),
	POC_BILLINGFIRSTVISITSCHEDULEID NUMBER(19,0),
	POC_GOALS VARCHAR(16777216),
	POC_REHABILITATIONPOTENIAL VARCHAR(16777216),
	POC_DISCHARGEPLANS VARCHAR(16777216),
	POC_PHYSICIANID NUMBER(19,0),
	POC_CAREPLANTRACKINGDUEDATE TIMESTAMP_NTZ(9),
	POC_CAREPLANTRACKINGSENTDATE TIMESTAMP_NTZ(9),
	POC_CAREPLANTRACKINGSECONDSENTDATE TIMESTAMP_NTZ(9),
	POC_CAREPLANTRACKINGDATERECEIVED TIMESTAMP_NTZ(9),
	POC_CAREPLANTRACKINGNOTES VARCHAR(1024),
	POC_OASISINTERFACEID VARCHAR(50),
	POC_CREATEDDATE TIMESTAMP_NTZ(9),
	POC_CREATEDUSER VARCHAR(50),
	POC_MODIFIEDDATE TIMESTAMP_NTZ(9),
	POC_MODIFIEDUSER VARCHAR(50),
	POC_TS VARCHAR(100),
	POC_HEIGHT VARCHAR(10),
	POC_WEIGHT VARCHAR(10),
	POC_485PROCESSID NUMBER(10,0),
	POC_485STATUSID NUMBER(10,0),
	POC_485ASSESSMENTHISTORYID NUMBER(19,0),
	POC_VERBALSTARTOFCAREDATE TIMESTAMP_NTZ(9),
	POC_485DIAGNOSISVERSION NUMBER(3,0),
	POC_PRECLAIMREVIEWUTN VARCHAR(14),
	POC_SERVICEPLANHEADERDRAFTID NUMBER(19,0),
	POC_SERVICEPLANHEADERFINALIZEDID NUMBER(19,0),
	POC_FEATURES NUMBER(10,0),
	POC_HHAQUALIFYINGTASKS NUMBER(10,0),
	POC_HHAPAYERREQUIREMENTSNOTES VARCHAR(512),
	POC_ADVANCEDDIRECTIVES NUMBER(10,0),
	POC_ADVANCEDDIRECTIVESOTHER VARCHAR(16777216),
	POC_HOSPITALRISKFACTOR VARCHAR(16777216),
	POC_COGNITIVEPSYCHOSOCIALSTATUS NUMBER(10,0),
	POC_COGNITIVEPSYCHOSOCIALSTATUSOTHER VARCHAR(16777216),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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