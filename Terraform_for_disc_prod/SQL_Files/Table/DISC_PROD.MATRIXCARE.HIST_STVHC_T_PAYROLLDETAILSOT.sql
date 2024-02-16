CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_PAYROLLDETAILSOT (
	PROLLDOT_ID NUMBER(19,0) NOT NULL,
	PROLLDOT_PAYROLLBATCHID NUMBER(19,0),
	PROLLDOT_BATCHID NUMBER(19,0),
	PROLLDOT_RECORDID NUMBER(19,0),
	PROLLDOT_CAREGIVERID NUMBER(19,0),
	PROLLDOT_SCHEDULEID NUMBER(19,0),
	PROLLDOT_RATIOOFHOURSINCLUDEDINWEEK NUMBER(18,0),
	PROLLDOT_WEEKLYTOTALHOURSFOROT NUMBER(18,0),
	PROLLDOT_BLENDEDRATE NUMBER(18,0),
	PROLLDOT_PRORATEOTAMOUNT NUMBER(18,0),
	PROLLDOT_PRORATEOTHOURS NUMBER(18,0),
	PROLLDOT_PORTIONFORBLENDEDRATE NUMBER(18,0),
	PROLLDOT_WEEKLYHOURSLIMIT NUMBER(3,0),
	PROLLDOT_PRORATEFOROTEXEMPT NUMBER(18,0),
	PROLLDOT_ACTUALHOURS NUMBER(18,0),
	PROLLDOT_PAYAMOUNT NUMBER(18,0),
	PROLLDOT_TOTALWEEKPAYAMOUNT NUMBER(18,0),
	PROLLDOT_WEEKLYHOURS NUMBER(18,0),
	PROLLDOT_ACCUMWEEKLYHOURS NUMBER(18,0),
	PROLLDOT_ACCUMDAILYHOURS NUMBER(18,0),
	PROLLDOT_NOTWORKINGHRS NUMBER(18,0),
	PROLLDOT_STARTTIME TIMESTAMP_NTZ(9),
	PROLLDOT_ENDTIME TIMESTAMP_NTZ(9),
	PROLLDOT_SCHEDULEDURATION NUMBER(18,0),
	PROLLDOT_WEEKNUM NUMBER(3,0),
	PROLLDOT_WEEKSTARTTIME TIMESTAMP_NTZ(9),
	PROLLDOT_WEEKENDTIME TIMESTAMP_NTZ(9),
	PROLLDOT_DAYNO NUMBER(3,0),
	PROLLDOT_DAYSTARTTIME TIMESTAMP_NTZ(9),
	PROLLDOT_DAYENDTIME TIMESTAMP_NTZ(9),
	PROLLDOT_DAILYTOTALHOURS NUMBER(18,0),
	PROLLDOT_DAILYOTUNITS NUMBER(18,0),
	PROLLDOT_DAILYOTLIMIT NUMBER(10,0),
	PROLLDOT_TOTALDAILYOTUNITSPERWEEK NUMBER(18,0),
	PROLLDOT_WEEKLYOTUNITS NUMBER(18,0),
	PROLLDOT_OTMULTIPLIER NUMBER(18,0),
	PROLLDOT_RATE NUMBER(18,2),
	PROLLDOT_UNITS NUMBER(18,0),
	PROLLDOT_ISWEEKLY NUMBER(3,0),
	PROLLDOT_HASSEVENDAYOT BOOLEAN,
	PROLLDOT_TOTALPAY NUMBER(18,2),
	PROLLDOT_DAILYOTORDER NUMBER(5,0),
	PROLLDOT_RANKED NUMBER(5,0),
	PROLLDOT_ADJUSTMENTHRS NUMBER(18,0),
	PROLLDOT_ADJUSTMENTAMT NUMBER(18,2),
	PROLLDOT_WEEKLYHOURSFOROT NUMBER(18,0),
	PROLLDOT_DAILYHOURSFOROT NUMBER(18,0),
	PROLLDOT_DESCRIPTION VARCHAR(100),
	PROLLDOT_CLIENTID NUMBER(19,0),
	PROLLDOT_BATCHTS NUMBER(19,0),
	PROLLDOT_ISEXPENSE BOOLEAN,
	PROLLDOT_RECORDTOTALPAYMENT NUMBER(38,6),
	PROLLDOT_OTPAYMENT NUMBER(38,6),
	PROLLDOT_OTUNITS NUMBER(8,2),
	PROLLDOT_RECORDUNITS NUMBER(18,0),
	PROLLDOT_PAYROLLTYPEID NUMBER(10,0),
	PROLLDOT_PAYROLLADJID NUMBER(19,0),
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