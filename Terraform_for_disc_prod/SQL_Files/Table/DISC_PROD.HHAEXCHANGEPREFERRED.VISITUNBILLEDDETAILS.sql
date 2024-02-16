CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.VISITUNBILLEDDETAILS (
	AGENCYID NUMBER(10,0),
	VISITUNBILLEDDETAILID NUMBER(19,0),
	PATIENTID NUMBER(19,0),
	CAREGIVERID NUMBER(10,0),
	VISITDATE TIMESTAMP_NTZ(9),
	PAYERID NUMBER(10,0),
	TIMESHEETREQUIRED VARCHAR(10),
	TIMESHEETRECEIVED VARCHAR(10),
	ISSKILLEDVISIT VARCHAR(10),
	VISITRATEID NUMBER(10,0),
	VISITRATE VARCHAR(50),
	VISITID NUMBER(19,0),
	DISCIPLINEID NUMBER(10,0),
	CAREGIVERNOTCOMPLIANT VARCHAR(1),
	CAREGIVEROVERLAPPING VARCHAR(1),
	CLINICALDOCNOTCOMPLIANT VARCHAR(1),
	INCOMPLETECONFIRMATION VARCHAR(1),
	INSUFFICIENTDUTYMINUTES VARCHAR(1),
	INVALIDOT VARCHAR(1),
	MISSINGABSENCECODE VARCHAR(1),
	MISSINGCAREGIVERSSN VARCHAR(1),
	MISSINGHHAPCAREGINFO VARCHAR(1),
	MISSINGMEDICAIDCOMPLIANCE VARCHAR(1),
	MISSINGOTCODE VARCHAR(1),
	MISSINGSERVICELOCATIONCODE VARCHAR(1),
	MORETHAN24HOURS VARCHAR(1),
	NOPOCATTACHEDTOSCHEDULE VARCHAR(1),
	POCNOTCOMPLIANT VARCHAR(1),
	RESTRICTEDCAREGIVERS VARCHAR(1),
	SCHEDULEDWITHHOLDRATE VARCHAR(1),
	SHIFTOVERLAPPING VARCHAR(1),
	TIMESHEETNOTAPPROVED VARCHAR(1),
	TTOTNOTAPPROVED VARCHAR(1),
	UNAUTHORIZED VARCHAR(1),
	UNBALANCEDVISITS VARCHAR(1),
	VISITMISSINGPAYCODE VARCHAR(1),
	WITHTEMPCAREGIVER VARCHAR(1),
	PREBILLING BOOLEAN,
	DELETED VARCHAR(10),
	APPROVEDTRAVELTIMEHOURS NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
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