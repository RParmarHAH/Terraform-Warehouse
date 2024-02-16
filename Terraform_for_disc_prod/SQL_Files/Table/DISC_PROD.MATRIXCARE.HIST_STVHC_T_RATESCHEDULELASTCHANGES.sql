CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_RATESCHEDULELASTCHANGES (
	SCHID NUMBER(19,0) NOT NULL,
	SCHEXPID NUMBER(19,0),
	BILLARGS NUMBER(3,0),
	PAYARGS NUMBER(3,0),
	BRANCHID NUMBER(10,0),
	CLIENTID NUMBER(19,0),
	ADMISSIONID NUMBER(19,0),
	CAREGIVERID NUMBER(19,0),
	CLIENTREGIONID NUMBER(19,0),
	CAREGIVERREGIONID NUMBER(19,0),
	SERVICECODEID NUMBER(10,0),
	PRIMPAYERID NUMBER(19,0),
	BILLUNITS NUMBER(8,4),
	PAYUNITS NUMBER(8,4),
	BILLFLAGSOURCE NUMBER(3,0),
	PAYFLAGSOURCE NUMBER(3,0),
	BILLFLAG NUMBER(3,0),
	PAYFLAG NUMBER(3,0),
	BILLUNITFLAG NUMBER(10,0),
	PAYUNITFLAG NUMBER(10,0),
	PAYERSOURCE NUMBER(3,0),
	BILLRATE NUMBER(18,2),
	PAYRATE NUMBER(18,2),
	BILLRATEID NUMBER(19,0),
	BILLRATESOURCE NUMBER(3,0),
	BILLRATEOVRDSEQ NUMBER(3,0),
	PAYRATEID NUMBER(19,0),
	PAYRATESOURCE NUMBER(3,0),
	PAYRATEOVRDSEQ NUMBER(3,0),
	SCHEDULESTART TIMESTAMP_NTZ(9),
	SCHEDULEBILLEND TIMESTAMP_NTZ(9),
	SCHEDULEPAYEND TIMESTAMP_NTZ(9),
	RESOLVEDBILLFLAG NUMBER(3,0),
	RESOLVEDPAYFLAG NUMBER(3,0),
	SCHEDULESTATUS NUMBER(5,0),
	BILLEXCLUDEHOLIDAYS BOOLEAN,
	PAYEXCLUDEHOLIDAYS BOOLEAN,
	BILLBYSHIFT BOOLEAN,
	ADDONRATEID NUMBER(19,0),
	ADDONRATESOURCE NUMBER(3,0),
	PAYHOLIDAYID NUMBER(19,0),
	BILLHOLIDAYID NUMBER(19,0),
	ISBILLED BOOLEAN,
	ISPAID BOOLEAN,
	TOTALBILLAMOUNT NUMBER(18,2),
	TOTALPAYAMOUNT NUMBER(18,2),
	MARGIN NUMBER(18,2),
	ISSERVICE BOOLEAN,
	ISMULTISERVICE BOOLEAN,
	RATEDRIVERPROCESSLOGID NUMBER(19,0),
	CS_ALL NUMBER(19,0),
	PAYORBILLFLAG NUMBER(10,0),
	RSLC_TOTALOTAMOUNT NUMBER(18,2),
	OT_CALCRATES BOOLEAN,
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