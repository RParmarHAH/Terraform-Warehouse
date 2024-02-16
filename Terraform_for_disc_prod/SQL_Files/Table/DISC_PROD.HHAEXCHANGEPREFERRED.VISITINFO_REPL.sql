CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.VISITINFO_REPL (
	AGENCYID NUMBER(10,0),
	VISITINFOID NUMBER(19,0),
	VISITID NUMBER(19,0),
	NONBILLABLE BOOLEAN,
	ISUPDATEDBYPOPUP BOOLEAN,
	CAREGIVERRATE NUMBER(10,2),
	CAREGIVERADJMINUTES NUMBER(10,0),
	PAYRATEID NUMBER(10,0),
	ISSKILLEDVISIT NUMBER(3,0),
	COMMENTS VARCHAR(500),
	PAYROLLDATE TIMESTAMP_NTZ(9),
	IVRCALLIN TIMESTAMP_NTZ(9),
	IVRCALLOUT TIMESTAMP_NTZ(9),
	POCDUTIES VARCHAR(200),
	IVRDUTIES NUMBER(10,0),
	TIMESHEETRECEIVED BOOLEAN,
	ISMUTUALLINKEDFAILED NUMBER(3,0),
	ISTEMPSCHEDULE BOOLEAN,
	ISTEMPCAREGIVER BOOLEAN,
	DELETEDINVOICENUMBER1 VARCHAR(500),
	DELETEDINVOICENUMBER2 VARCHAR(500),
	EXPENSE1 NUMBER(18,2),
	EXPENSE2 NUMBER(18,2),
	REASONEXPENSE1 NUMBER(10,0),
	REASONEXPENSE2 NUMBER(10,0),
	VISITAUDITVERIFIEDBY NUMBER(3,0),
	VISITAUDITVERIFIEDBYOTHER VARCHAR(500),
	VISITAUDITDATETIME TIMESTAMP_NTZ(9),
	VISITAUDITSUPERVISOR VARCHAR(500),
	ABSENCECODE VARCHAR(4),
	OVERTIMECODE VARCHAR(4),
	FULLSERVICECODE VARCHAR(4),
	ISVNSRESUBMIT BOOLEAN,
	PRIMARYSERVICECODEID NUMBER(10,0),
	VISITTYPE NUMBER(3,0),
	PARENTVISITID NUMBER(19,0),
	SERVICECATEGORYID NUMBER(10,0),
	SERVICETYPEID NUMBER(10,0),
	ONHOLDVISIT BOOLEAN,
	BILLVISITWITHZERORATE BOOLEAN,
	CLINICALEDOCID NUMBER(10,0),
	CLINICALEDOCSTATUS VARCHAR(50),
	INCLUDEMILEAGEEXPENSE BOOLEAN,
	POCDUTIESWITHADDITIONALVALUE VARCHAR(500),
	OVERRIDEMILEAGEEXPENSE BOOLEAN,
	MILEAGEDISTANCE NUMBER(10,2),
	MILEAGERATE NUMBER(10,2),
	MILEAGEPAYTOTAL NUMBER(10,2),
	OFFICEID NUMBER(10,0),
	TOTALVISITPOCMINUTES NUMBER(10,0),
	TOTALVISITPOCMINUTESROUNDED NUMBER(10,0),
	EXCLUDEPAYCODERECALCULATE BOOLEAN,
	EXCLUDEPAYCODEPAYDIFFERENTIAL BOOLEAN,
	ALLPOCDUTIES VARCHAR(16777216),
	SUBMISSIONUTCDATE TIMESTAMP_NTZ(9),
	MANUALAUTHORIZATION VARCHAR(10),
	EXTERNALINVOICENUMBER VARCHAR(100),
	BROADCASTTYPE VARCHAR(15),
	BROADCASTSTATUS VARCHAR(15),
	CAREGIVERREQUESTCOUNT NUMBER(10,0),
	INVOICELINEITEMID VARCHAR(50),
	SERVICELOCATION VARCHAR(100),
	CREATEDBY NUMBER(19,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBY NUMBER(19,0),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	ACTIONTAKENREASONID NUMBER(10,0),
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