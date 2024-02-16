CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.ADMISSIONS (
	ADMISSIONID NUMBER(10,0) NOT NULL,
	PLACEMENTID NUMBER(10,0),
	AGENCYID NUMBER(10,0) NOT NULL,
	PATIENTID NUMBER(10,0),
	CONTRACTID NUMBER(10,0),
	CONTRACTTYPE NUMBER(3,0),
	CHHAID NUMBER(10,0),
	ALTPATIENTID VARCHAR(50),
	STARTDATE TIMESTAMP_NTZ(9),
	SOURCEOFADMISSIONID NUMBER(10,0),
	SERVICECODEID NUMBER(10,0),
	DISCHARGEDATE TIMESTAMP_NTZ(9),
	DISCHARGETO NUMBER(10,0),
	DISCHARGENOTE VARCHAR(1000),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	DISCHARGEREASON NUMBER(10,0),
	HASSURPLUS BOOLEAN,
	SURPLUSAMOUNT NUMBER(18,2),
	CONTRACTPAYSPERCENT NUMBER(18,2),
	PRIVATEPAYSPERCENT NUMBER(18,2),
	DEDUCTIBLEAMOUNT NUMBER(18,2),
	DEDUCTIBLEDURATION NUMBER(10,0),
	AMOUNTLIMITPERDAY NUMBER(18,2),
	AMOUNTLIMITPERWEEK NUMBER(18,2),
	AMOUNTLIMITPERMONTH NUMBER(18,2),
	SCANFILENAME VARCHAR(1024),
	SCANFILEGUID VARCHAR(36),
	SECSUBSCRIBERRELATION VARCHAR(3),
	SECSUBSCRIBERFIRSTNAME VARCHAR(50),
	SECSUBSCRIBERLASTNAME VARCHAR(50),
	SECSUBSCRIBERINSURANCENUMBER VARCHAR(50),
	SECSUBSCRIBERADDRESS1 VARCHAR(200),
	SECSUBSCRIBERADDRESS2 VARCHAR(200),
	SECSUBSCRIBERCITY VARCHAR(50),
	SECSUBSCRIBERSTATE VARCHAR(50),
	SECSUBSCRIBERZIPCODE VARCHAR(20),
	SECINSNAME VARCHAR(50),
	SECSUBSCRIBERINSURANCEPAYERNUMBER VARCHAR(50),
	CLAIMFILLINGCODE VARCHAR(50),
	INCLUDESECPAYERINFOEBILLINGEXPORT BOOLEAN,
	SECSUBSCRIBERASPATIENTNAME BOOLEAN,
	SECSUBSCRIBERADDRESSTYPE VARCHAR(50),
	SECONDARYPAYSPERCENT NUMBER(18,2),
	SECONDARYCHHAID NUMBER(10,0),
	MONTHLYBILLING BOOLEAN,
	MONTHLYBILLINGDAY NUMBER(10,0),
	MONTHLYBILLINGDATE TIMESTAMP_NTZ(9),
	MONTHLYSERVICECODEID NUMBER(10,0),
	MONTHLYCAREGIVERID NUMBER(10,0),
	MONTHLYPAYRATEID NUMBER(10,0),
	MONTHLYSTARTTIME VARCHAR(4),
	MONTHLYENDTIME VARCHAR(4),
	ADMOFFICEID NUMBER(10,0),
	DEDUCTIBLEANDAMOUNTLIMITAPPLYON VARCHAR(50),
	MULTIPAYERVISITTYPE VARCHAR(50),
	DFTAPATIENT VARCHAR(10),
	PRIVATEPAYSERVICECODEID NUMBER(10,0),
	CONTRACTBILLINGDIAGNOSISCODES VARCHAR(16777216),
	LIMITMAXIMUMPAYERCONTRIBUTIONPERPERIOD VARCHAR(10),
	AUTHLIMITPERDAY NUMBER(18,2),
	AUTHLIMITPERWEEK NUMBER(18,2),
	AUTHLIMITPERMONTH NUMBER(18,2),
	AUTHLIMITPERYEAR NUMBER(18,2),
	AUTHLIMITPERLIFETIME NUMBER(18,2),
	LIMITFORADDITIONALINVOICE NUMBER(10,0),
	PAYMENTADJUSTMENTREASONID NUMBER(10,0),
	PAYMENTADJUSTMENTREASON VARCHAR(200),
	ELIMINATIONPERIOD VARCHAR(20),
	ELIMINATIONPERIODDAYS NUMBER(10,0),
	ELIMINATIONPERIODCOUNTDAYSTYPE VARCHAR(20),
	ELIMINATIONPERIODADJUSTMENTREASONID NUMBER(10,0),
	ELIMINATIONPERIODADJUSTMENTREASON VARCHAR(250),
	ELIMINATIONPERIODSTARTDATE TIMESTAMP_NTZ(9),
	BILLINGSTARTED BOOLEAN,
	LIMITFORADDITIONALINVOICENAME VARCHAR(50),
	PAYERRANKID NUMBER(10,0),
	PAYERPLACEMENTID NUMBER(19,0),
	PREVENTDISCHARGEDATEUPDATE VARCHAR(3),
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