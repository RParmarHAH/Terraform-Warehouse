CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PAYROLLDETAILS (
	PROLLD_ID NUMBER(19,0) NOT NULL,
	PROLLD_PAYROLLBATCHID NUMBER(19,0),
	PROLLD_CHECKTRANSID NUMBER(10,0),
	PROLLD_CAREGIVERID NUMBER(19,0),
	PROLLD_PAYROLLCOMPANYEMPLOYEEID VARCHAR(50),
	PROLLD_SCHEDULEID NUMBER(19,0),
	PROLLD_SCHEDULEEXPENSEID NUMBER(19,0),
	PROLLD_SHIFTNO NUMBER(5,0),
	PROLLD_BRANCHHOLIDAYID NUMBER(19,0),
	PROLLD_HOLIDAYMULTIPLIER NUMBER(18,0),
	PROLLD_HOLIDAYADDITION NUMBER(18,2),
	PROLLD_SERVICEENDTIME TIMESTAMP_NTZ(9),
	PROLLD_SERVICEDATE TIMESTAMP_NTZ(9),
	PROLLD_SERVICECODEID NUMBER(10,0),
	PROLLD_NOTES VARCHAR(255),
	PROLLD_DEDUCTIONEARNING VARCHAR(2),
	PROLLD_RATE NUMBER(18,2),
	PROLLD_RATESOURCE NUMBER(3,0),
	PROLLD_RATEID NUMBER(19,0),
	PROLLD_UNITS NUMBER(18,8),
	PROLLD_PAYUNITFLAG NUMBER(5,0),
	PROLLD_OT_DAYUNITS NUMBER(5,2),
	PROLLD_OT_DAYMULTIPLIER NUMBER(4,2),
	PROLLD_OTDAYRATETYPE NUMBER(3,0),
	PROLLD_OT_WEEKUNITS NUMBER(5,2),
	PROLLD_OT_WEEKMULTIPLIER NUMBER(4,2),
	PROLLD_OTWEEKRATETYPE NUMBER(3,0),
	PROLLD_EARNCODE VARCHAR(50),
	PROLLD_OVERRIDEDEPARTMENT VARCHAR(15),
	PROLLD_OVERRIDEDIVISION VARCHAR(50),
	PROLLD_OVERRIDEBRANCH VARCHAR(50),
	PROLLD_OVERRIDESTATE VARCHAR(50),
	PROLLD_OVERRIDELOCAL VARCHAR(50),
	PROLLD_JOB VARCHAR(50),
	PROLLD_VACATION NUMBER(18,2),
	PROLLD_LOAN NUMBER(18,2),
	PROLLD_FEE NUMBER(18,2),
	PROLLD_OTHER NUMBER(18,2),
	PROLLD_MISC NUMBER(18,2),
	PROLLD_HOLIDAY NUMBER(18,2),
	PROLLD_ADVANCE NUMBER(18,2),
	PROLLD_AMOUNT NUMBER(18,2),
	PROLLD_SOURCETS VARCHAR(100),
	PROLLD_CREATEDDATE TIMESTAMP_NTZ(9),
	PROLLD_CREATEDUSER VARCHAR(50),
	PROLLD_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PROLLD_MODIFIEDUSER VARCHAR(50),
	PROLLD_TS VARCHAR(100),
	PROLLD_OTWEEKLYHOURS NUMBER(3,0),
	PROLLD_PAYOT NUMBER(3,0),
	PROLLD_WEEKSTARTTIME TIMESTAMP_NTZ(9),
	PROLLD_WEEKENDTIME TIMESTAMP_NTZ(9),
	PROLLD_OTADJUSTEDUNITS NUMBER(18,0),
	PROLLD_OTADJUSTEDRATE NUMBER(18,2),
	PROLLD_TOTALAMOUNT NUMBER(18,2),
	PROLLD_PAYROLLADJID NUMBER(19,0),
	PROLLD_TOTALPAYMENT NUMBER(18,2),
	PROLLD_PAYERID NUMBER(19,0),
	PROLLD_ADDON NUMBER(18,2),
	PROLLD_PRIMARYRATE NUMBER(18,2),
	PROLLD_ADDONRATEID NUMBER(10,0),
	PROLLD_TOTALDETAILAMOUNT NUMBER(18,0),
	PROLLD_REGIONID NUMBER(10,0),
	PROLLD_CLIENTID NUMBER(19,0),
	PROLLD_ISEXPENSE BOOLEAN,
	PROLLD_CAREXCLUDEOT BOOLEAN,
	PROLLD_BRANCHID NUMBER(10,0),
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