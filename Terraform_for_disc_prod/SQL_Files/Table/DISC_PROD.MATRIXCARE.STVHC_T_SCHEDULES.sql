CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_SCHEDULES (
	SCH_ID NUMBER(19,0),
	SCH_CLIENTID NUMBER(19,0),
	SCH_CAREGIVERID NUMBER(19,0),
	SCH_STARTTIME TIMESTAMP_NTZ(9),
	SCH_ENDTIME TIMESTAMP_NTZ(9),
	SCH_SCHEDULESTATUSID NUMBER(10,0),
	SCH_SERVICECODEID NUMBER(10,0),
	SCH_ADMISSIONID NUMBER(19,0),
	SCH_DESCRIPTION VARCHAR(4000),
	SCH_CHARGERATEOVERRIDEAMT NUMBER(18,2),
	SCH_CHARGERATEOVERRIDEMODIFIEDUSER VARCHAR(50),
	SCH_CHARGERATEOVERRIDEMODIFIEDDATE TIMESTAMP_NTZ(9),
	SCH_PAYRATEOVERRIDEAMT NUMBER(18,2),
	SCH_PAYRATEOVERRIDEMODIFIEDUSER VARCHAR(50),
	SCH_PAYRATEOVERRIDEMODIFIEDDATE TIMESTAMP_NTZ(9),
	SCH_CHARGERATEID NUMBER(19,0),
	SCH_CHARGERATE NUMBER(18,2),
	SCH_UNITS NUMBER(18,0),
	SCH_BILLRATEUNITFLAG NUMBER(5,0),
	SCH_PAYRATEUNITFLAG NUMBER(5,0),
	SCH_PAYUNITS NUMBER(18,0),
	SCH_OTUNITS NUMBER(18,0),
	SCH_NOTESDATE TIMESTAMP_NTZ(9),
	SCH_PAYREVIEWFLAG BOOLEAN,
	SCH_PAYROLLBATCHID NUMBER(19,0),
	SCH_PAYNOTES VARCHAR(128),
	SCH_PAYDATE TIMESTAMP_NTZ(9),
	SCH_PAYCODE NUMBER(3,0),
	SCH_REVENUECODE NUMBER(3,0),
	SCH_BILLINGSTATUS NUMBER(3,0),
	SCH_AUTHID NUMBER(19,0),
	SCH_1500POS NUMBER(10,0),
	SCH_1500TOS NUMBER(10,0),
	SCH_1500DIAG NUMBER(10,0),
	SCH_1500EPSDT VARCHAR(50),
	SCH_1500EMG VARCHAR(50),
	SCH_1500COB VARCHAR(50),
	SCH_1500LOCALUSE VARCHAR(50),
	SCH_USERDEFINED1 VARCHAR(50),
	SCH_RECURRENCEID NUMBER(19,0),
	SCH_ISRECURRINGAPPOINTMENTROOT BOOLEAN,
	SCH_CREATEDDATE TIMESTAMP_NTZ(9),
	SCH_CREATEDUSER VARCHAR(50),
	SCH_MODIFIEDDATE TIMESTAMP_NTZ(9),
	SCH_MODIFIEDUSER VARCHAR(50),
	SCH_TS VARCHAR(100),
	SCH_ISRECURRENCEUNIQUE NUMBER(19,0),
	SCH_TOTALCHARGE NUMBER(18,2),
	SCH_LEGACYID NUMBER(10,0),
	SCH_LEGACYBRANCHID NUMBER(10,0),
	SCH_TZID VARCHAR(10),
	SCH_TIMEZONEID NUMBER(5,0),
	SCH_STARTOFFSET NUMBER(5,0),
	SCH_ENDOFFSET NUMBER(5,0),
	SCH_OTMULTI NUMBER(18,0),
	SCH_SCHEDSTARTTIME TIMESTAMP_NTZ(9),
	SCH_SCHEDENDTIME TIMESTAMP_NTZ(9),
	SCH_SCHEDUNITS NUMBER(18,0),
	SCH_SCHEDUPDATEDDATE TIMESTAMP_NTZ(9),
	SCH_SCHEDOVERRIDEMODIFIEDDATE TIMESTAMP_NTZ(9),
	SCH_SCHEDOVERRIDEMODIFIEDUSER VARCHAR(50),
	SCH_TELUPDATEDDATE TIMESTAMP_NTZ(9),
	SCH_OTEXEMPTHOURS NUMBER(18,0),
	SCH_OTEXEMPTTYPEID NUMBER(10,0),
	SCH_1500BILLINGMODIFIERID1 NUMBER(10,0),
	SCH_1500BILLINGMODIFIERID2 NUMBER(10,0),
	SCH_1500BILLINGMODIFIERID3 NUMBER(10,0),
	SCH_1500BILLINGMODIFIERID4 NUMBER(10,0),
	SCH_BRANCHID NUMBER(10,0),
	SCH_ORIGINALPAYDATE TIMESTAMP_NTZ(9),
	SCH_TOTALBILLABLE NUMBER(18,2),
	SCH_TOTALBILLED NUMBER(18,2),
	SCH_TOTALPAID NUMBER(18,2),
	SCH_ARRIVALCALLID NUMBER(19,0),
	SCH_DEPARTURECALLID NUMBER(19,0),
	SCH_TELEPHONYSTATUS NUMBER(10,0),
	SCH_INVOICEDETAILDESCRIPTION VARCHAR(100),
	SCH_REGIONID NUMBER(10,0),
	SCH_BILLEDPAIDREGION NUMBER(10,0),
	SCH_QCODE VARCHAR(25),
	SCH_PAYNONWORKSTARTTIME TIMESTAMP_NTZ(9),
	SCH_PAYNONWORKENDTIME TIMESTAMP_NTZ(9),
	SCH_BILLNONWORKTYPEID NUMBER(10,0),
	SCH_BILLNONWORKSTARTTIME TIMESTAMP_NTZ(9),
	SCH_BILLNONWORKENDTIME TIMESTAMP_NTZ(9),
	SCH_BILLNONWORKSTARTTIMEOFFSET NUMBER(5,0),
	SCH_BILLNONWORKENDTIMEOFFSET NUMBER(5,0),
	SCH_PAYNONWORKSTARTTIMEOFFSET NUMBER(5,0),
	SCH_PAYNONWORKENDTIMEOFFSET NUMBER(5,0),
	SCH_NOTERECEIVED DATE,
	SCH_OTRATE NUMBER(18,2),
	SCH_BILLOTOVERRIDEMODIFIEDDATE TIMESTAMP_NTZ(9),
	SCH_BILLOTOVERRIDEMODIFIEDUSER VARCHAR(50),
	SCH_BILLINGOTCALCTYPE NUMBER(3,0),
	SCH_SERVICEPLANHEADERID NUMBER(19,0),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);