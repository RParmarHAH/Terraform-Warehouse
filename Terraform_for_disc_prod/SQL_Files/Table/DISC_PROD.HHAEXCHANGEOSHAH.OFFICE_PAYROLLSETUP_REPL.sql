CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_PAYROLLSETUP_REPL (
	AGENCYID NUMBER(10,0),
	PAYROLLSETUPID NUMBER(10,0) NOT NULL,
	PAYROLLSETUPNAME VARCHAR(100),
	PAYPREFERENCESKILLED NUMBER(5,0),
	PAYPREFERENCENONSKILLED NUMBER(5,0),
	OVERTIME BOOLEAN,
	OVERTIMEMINS NUMBER(10,0),
	OVERTIMERATE NUMBER(10,0),
	MINDAILYMINUTES NUMBER(10,0),
	CALCULATEOTFORPRIORWEEK BOOLEAN,
	PAYROLLWEEKENDINGDAY NUMBER(5,0),
	MULTIPLEPAYROLLPERCAREGIVERPERPAYROLL BOOLEAN,
	OFFICENAMES VARCHAR(16777216),
	ISACTIVE BOOLEAN,
	CUTOFFOTRATE NUMBER(10,0),
	DISPLAYPATIENTONSTUB BOOLEAN,
	DAILYCAPPED NUMBER(10,0),
	ISDAILYHOURLYPAID NUMBER(10,0),
	BLENDEDCUTOFFOTRATE NUMBER(10,0),
	PREPAYROLLPROCESSADDDISCIPLINE BOOLEAN,
	PREPAYROLLPROCESSUPDATEPAYCODE BOOLEAN,
	PAYROLLCREATIONONANYWEEKENDINGDAY VARCHAR(10),
	PAYTRAVELTIMETOTHEMINUTE VARCHAR(5),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	LASTUPDATEDBY NUMBER(10,0),
	LASTUPDATEDDATE TIMESTAMP_NTZ(9),
	LASTUPDATEDUTCDATE TIMESTAMP_NTZ(9),
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