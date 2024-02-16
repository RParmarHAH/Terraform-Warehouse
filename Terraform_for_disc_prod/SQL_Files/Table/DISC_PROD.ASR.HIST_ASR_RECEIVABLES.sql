CREATE OR REPLACE TABLE DISC_PROD.ASR.HIST_ASR_RECEIVABLES (
	VISITDATE VARCHAR(16777216),
	SERVICEVISITID VARCHAR(16777216),
	SERVICETYPE VARCHAR(16777216),
	CUSTOMERID VARCHAR(16777216),
	EMPLOYEEID VARCHAR(16777216),
	PAYERSOURCEID VARCHAR(16777216),
	HOURSASSIGNEDORIGSCHED VARCHAR(16777216),
	SERVICEVISITACTUALID VARCHAR(16777216),
	TIMECHECKEDIN VARCHAR(16777216),
	TIMECHECKEDOUT VARCHAR(16777216),
	ISCANCELLED VARCHAR(16777216),
	RESCHEDULEDTO VARCHAR(16777216),
	RESPONCIBLEFORCANCELATION VARCHAR(16777216),
	CANCELATIONCOMMENTS VARCHAR(16777216),
	COMMLOGRECORDID VARCHAR(16777216),
	EMPCOMMLOGRECID VARCHAR(16777216),
	RANDOMCHECK VARCHAR(16777216),
	RESCHEDULEDEMPLOYEEID VARCHAR(16777216),
	LATECHECKINNOTIFICATION VARCHAR(16777216),
	CHECKEDINFROM VARCHAR(16777216),
	CHECKEDOUTFROM VARCHAR(16777216),
	RESCHEDULEDVISITRATE VARCHAR(16777216),
	RESCHEDULEDVISITFEE VARCHAR(16777216),
	CUSTOMERNOTIFIED VARCHAR(16777216),
	EMPLOYEENOTIFIED VARCHAR(16777216),
	HOURSCREDITED VARCHAR(16777216),
	VISITSTATUSID VARCHAR(16777216),
	ISFINAL VARCHAR(16777216),
	TIMECHECKEDINISFINAL VARCHAR(16777216),
	TIMECHECKEDOUTISFINAL VARCHAR(16777216),
	ISPAID VARCHAR(16777216),
	VISITNOTES VARCHAR(16777216),
	ISTRIMMEDOVERMAXSHIFT VARCHAR(16777216),
	BILLINGCODEID VARCHAR(16777216),
	HOURSAPPROVED VARCHAR(16777216),
	MILESTOMAKEVISIT VARCHAR(16777216),
	TIMETOMAKEVISIT VARCHAR(16777216),
	CHINLAT VARCHAR(16777216),
	CHINLONG VARCHAR(16777216),
	CHOUTLAT VARCHAR(16777216),
	CHOUTLONG VARCHAR(16777216),
	EVV_SEQUENCEID VARCHAR(16777216),
	EVV_REASONCODEID VARCHAR(16777216),
	EVV_REASONMEMO VARCHAR(16777216),
	EVV_EXCEPTIONSCLEARED VARCHAR(16777216),
	EVV_CLIENTSIGNATUREISEMPTY VARCHAR(16777216),
	OBSERVATIONSNOTED VARCHAR(16777216),
	SUPERVISORNOTIFIEDOFOBSERVATIONSNOTED VARCHAR(16777216),
	EVV_TRANSACTIONID VARCHAR(16777216),
	EVV_LASTSUBMITTEDON VARCHAR(16777216),
	DOCUMENTATIONRECEIVED VARCHAR(16777216),
	ACTUALVISITDATE VARCHAR(16777216),
	EVV_PAYDATE VARCHAR(16777216),
	SCHEDULEDCHECKIN VARCHAR(16777216),
	SCHEDULEDCHECKOUT VARCHAR(16777216),
	SCHEDULEDCHECKINORIGSCHED VARCHAR(16777216),
	SCHEDULEDCHECKOUTORIGSCHED VARCHAR(16777216),
	PROGRAMID VARCHAR(16777216),
	HOMEPHONE VARCHAR(16777216),
	EMPLOYEEHOMEPHONE VARCHAR(16777216),
	CUSTOMERZIPCODE VARCHAR(16777216),
	EMPLOYEEZIPCODE VARCHAR(16777216),
	CUSTOMERNAME VARCHAR(16777216),
	EMPLOYEENAME VARCHAR(16777216),
	ACTUALORSCHEDULEDCHECKIN VARCHAR(16777216),
	ACTUALORSCHEDULEDCHECKOUT VARCHAR(16777216),
	CANCELATIONCOMMENTSUSABLE VARCHAR(16777216),
	RATE VARCHAR(16777216),
	RATETYPE VARCHAR(16777216),
	MILAGECOMPENSATION VARCHAR(16777216),
	ISFIRSTVISIT VARCHAR(16777216),
	COPAY VARCHAR(16777216),
	ZONEID VARCHAR(16777216),
	LOCATIONID VARCHAR(16777216),
	SUPERVISORID VARCHAR(16777216),
	CUSTOMERNUMCOMMRECRODS VARCHAR(16777216),
	EMPLOYEENUMCOMMRECRODS VARCHAR(16777216),
	SCHEDULEDDURATION VARCHAR(16777216),
	ACTUALDURATION VARCHAR(16777216),
	ACTUALDURATIONADJUSTED VARCHAR(16777216),
	BILLABLEHOURS VARCHAR(16777216),
	EARNEDAMOUNT VARCHAR(16777216),
	MILESCOMPENSATION VARCHAR(16777216),
	PAYROLLDEDUCTIONS VARCHAR(16777216),
	NONTAXABLEPAYROLLDEDUCTIONS VARCHAR(16777216),
	TOTALEARNEDAMOUNT VARCHAR(16777216),
	REQUIREDHOURS VARCHAR(16777216),
	RECEIVABLEAMOUNT VARCHAR(16777216),
	RECEIVABLEFEEORRATE VARCHAR(16777216),
	PROFITAMOUNT VARCHAR(16777216),
	ISBILLED VARCHAR(16777216),
	BILLINGTRANSACTIONID VARCHAR(16777216),
	BILLINGDATE VARCHAR(16777216),
	INVOICENUMBER VARCHAR(16777216),
	INVOICENUMBEREXTERN VARCHAR(16777216),
	BILLINGPREMIUM VARCHAR(16777216),
	BILLINGPREMIUMTAG VARCHAR(16777216),
	BILLEDAMOUNT VARCHAR(16777216),
	MEMO_RECEIVABLEFEEORRATE VARCHAR(16777216),
	MEMO_BILLABLEHOURS VARCHAR(16777216),
	BILLINGMEMO VARCHAR(16777216),
	LASTMODIFIEDON VARCHAR(16777216),
	CLAIMNUMBER VARCHAR(16777216),
	RANK VARCHAR(16777216),
	DATECHECKEDIN VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);