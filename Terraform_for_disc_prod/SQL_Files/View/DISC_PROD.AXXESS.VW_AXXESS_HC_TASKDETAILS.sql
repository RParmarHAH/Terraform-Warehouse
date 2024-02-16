create or replace view DISC_PROD.AXXESS.VW_AXXESS_HC_TASKDETAILS(
	ACCOUNT_ID,
	ACCOUNT_NAME,
	BRANCH_ID,
	BRANCH_NAME,
	SCHEDULED_TASK_ID,
	CLIENT_ID,
	CLIENT_FIRST_NAME,
	CLIENT_LAST_NAME,
	CLIENT_MIDDLE_INITIAL,
	MRN,
	SCHEDULED_TASK_STATUS,
	SCHEDULED_DISCIPLINE_TASK,
	SCHEDULED_TASK_NAME,
	SCHEDULED_TASK_DISCIPLINE,
	EVENT_STARTTIME,
	EVENT_ENDTIME,
	VISIT_START,
	VISIT_END,
	SCHEDULED_TASK_STARTDATE,
	SCHEDULED_TASK_ENDDATE,
	ISPAYABLE_VISIT,
	ISBILLABLE_VISIT,
	SCHEDULED_TASK_ISORDER,
	SCHEDULED_UNITS,
	SCHEDULED_TASK_ISVISITPAID,
	SCHEDULED_TASK_ISALLDAY,
	SCHEDULED_TASK_ISMISSEDVISIT,
	SCHEDULED_TASK_ISCAREPERIOD_DISCHARGED,
	SCHEDULED_TASK_ISCAREPERIOD_ACTIVE,
	SCHEDULED_TASK_ISDEPRECATED,
	AUTHORIZATION_ID,
	AUTHORIZATION_START,
	AUTHORIZATION_END,
	AUTHORIZATION_NUMBER,
	AUTHORIZED_UNITS,
	AVAILABLE_UNITS,
	AUTHORIZED_UNIT_TYPE,
	AUTHORIZED_FREQUENCY_OF_UNITS,
	AUTHORIZED_OCCURRENCE_FREQUENCY,
	DAYS_AUTH_RESTRICTEDTO,
	AUTHORIZED_TOTAL_LUNITS,
	AUTHORIZED_DISCIPLINE,
	AUTHORIZED_COMMENTS,
	AUTHORIZED_STATUS,
	AUTHORIZED_ISDEPRECATED,
	CLAIM_ID,
	CLAIM_STARTDATE,
	CLAIM_ENDDATE,
	BILLED_DATE,
	PAYMENT_DATE,
	CLAIM_STATUS,
	CLAIM_AMOUNT,
	CLAIM_INVOICE_NUMBER,
	CASH_RECEIVED,
	ADJUSTMENT_AMOUNT,
	NEGATIVE_ADJUSTMENT_AMOUNT,
	NET_RECEIVABLE,
	ACCOUNT_ISDEPRECATED,
	BRANCH_STATE_CODE,
	BRANCH_ZIP_CODE,
	BRANCH_ZIP_CODE_FOUR,
	BRANCH_ISMAIN_OFFICE,
	BRANCH_ISDEPRECATED,
	PRIMARY_INSURANCE_ID,
	INSURANCE_NAME,
	PAYOR_TYPE,
	PAYOR_NAME,
	PAYOR_ID,
	CLIENT_ADDRESS1,
	CLIENT_ADDRESS2,
	CLIENT_CITY,
	CLIENT_STATE,
	CLIENT_ZIP,
	CLIENT_REFERRAL_SOURCE,
	CLIENT_STATUS,
	CLIENT_DOB,
	CLIENT_AGE,
	CLIENT_MEDICAID_NUMBER,
	CLIENT_ISHOSPITALIZED,
	CLIENT_ISNONMEDICAL,
	CLIENT_GENDER,
	CLIENT_DISCHARGEDATE,
	CLIENT_DIAGNOSISID,
	CAREPERIOD_ID,
	CAREPERIOD_START,
	CAREPERIOD_END,
	CAREPERIOD_STARTOFCARE_DATE,
	CAREPERIOD_CASEMANAGER_ID,
	CAREPERIOD_CASEMANAGER_NAME,
	CAREPERIOD_COMMENTS,
	CAREPERIOD_ISACTIVE,
	CAREPERIOD_ISDISCHARGED,
	CAREPERIOD_ISLINKEDTODISCHARGE,
	ADMISSION_ID,
	ADMISSION_SOURCE,
	ADMISSION_DISCHARGE_DATE,
	ADMISSION_DISCHARGE_REASON,
	ADMISSION_ISDEPRECATED,
	ADMISSION_ISNONMEDICAL,
	ADMISSION_REFERRALID,
	ADMISSION_STARTOFCARE_DATE,
	ISVERIFIED_VISIT,
	ADMISSION_DISCHARGE_COMMENTS,
	ADMISSION_STATUS,
	ACTUAL_SCHEDULED_UNITS,
	DAYS_AUTH_RESTRICTED,
	CLINICIAN_ID,
	CLINICIAN_NAME,
	CLIENT_ISDEPRECATED,
	BILLED_UNIT_TYPE,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
) as
(SELECT TD.ACCOUNT_ID,
	TD.ACCOUNT_NAME,
	TD.BRANCH_ID,
	TD.BRANCH_NAME,
	TD.SCHEDULED_TASK_ID,
	TD.CLIENT_ID,
	TD.CLIENT_FIRST_NAME,
	TD.CLIENT_LAST_NAME,
	TD.CLIENT_MIDDLE_INITIAL,
	TD.MRN,
	TD.SCHEDULED_TASK_STATUS,
	TD.SCHEDULED_DISCIPLINE_TASK,
	TD.SCHEDULED_TASK_NAME,
	TD.SCHEDULED_TASK_DISCIPLINE,
	TD.EVENT_STARTTIME,
	TD.EVENT_ENDTIME,
	TD.VISIT_START,
	TD.VISIT_END,
	TD.SCHEDULED_TASK_STARTDATE,
	TD.SCHEDULED_TASK_ENDDATE,
	TD.ISPAYABLE_VISIT,
	TD.ISBILLABLE_VISIT,
	TD.SCHEDULED_TASK_ISORDER,
	TD.SCHEDULED_UNITS,
	TD.SCHEDULED_TASK_ISVISITPAID,
	TD.SCHEDULED_TASK_ISALLDAY,
	TD.SCHEDULED_TASK_ISMISSEDVISIT,
	TD.SCHEDULED_TASK_ISCAREPERIOD_DISCHARGED,
	TD.SCHEDULED_TASK_ISCAREPERIOD_ACTIVE,
	TD.SCHEDULED_TASK_ISDEPRECATED,
	TD.AUTHORIZATION_ID,
	TD.AUTHORIZATION_START,
	TD.AUTHORIZATION_END,
	TD.AUTHORIZATION_NUMBER,
	TD.AUTHORIZED_UNITS,
	TD.AVAILABLE_UNITS,
	TD.AUTHORIZED_UNIT_TYPE,
	TD.AUTHORIZED_FREQUENCY_OF_UNITS,
	TD.AUTHORIZED_OCCURRENCE_FREQUENCY,
	TD.DAYS_AUTH_RESTRICTEDTO,
	TD.AUTHORIZED_TOTAL_LUNITS,
	TD.AUTHORIZED_DISCIPLINE,
	TD.AUTHORIZED_COMMENTS,
	TD.AUTHORIZED_STATUS,
	TD.AUTHORIZED_ISDEPRECATED,
	TD.CLAIM_ID,
	TD.CLAIM_STARTDATE,
	TD.CLAIM_ENDDATE,
	TD.BILLED_DATE,
	TD.PAYMENT_DATE,
	TD.CLAIM_STATUS,
	TD.CLAIM_AMOUNT,
	TD.CLAIM_INVOICE_NUMBER,
	TD.CASH_RECEIVED,
	TD.ADJUSTMENT_AMOUNT,
	TD.NEGATIVE_ADJUSTMENT_AMOUNT,
	TD.NET_RECEIVABLE,
	TD.ACCOUNT_ISDEPRECATED,
	TD.BRANCH_STATE_CODE,
	TD.BRANCH_ZIP_CODE,
	TD.BRANCH_ZIP_CODE_FOUR,
	TD.BRANCH_ISMAIN_OFFICE,
	TD.BRANCH_ISDEPRECATED,
	TD.PRIMARY_INSURANCE_ID,
	TD.INSURANCE_NAME,
	TD.PAYOR_TYPE,
	TD.PAYOR_NAME,
	TD.PAYOR_ID,
	TD.CLIENT_ADDRESS1,
	TD.CLIENT_ADDRESS2,
	TD.CLIENT_CITY,
	TD.CLIENT_STATE,
	TD.CLIENT_ZIP,
	TD.CLIENT_REFERRAL_SOURCE,
	TD.CLIENT_STATUS,
	TD.CLIENT_DOB,
	TD.CLIENT_AGE,
	TD.CLIENT_MEDICAID_NUMBER,
	TD.CLIENT_ISHOSPITALIZED,
	TD.CLIENT_ISNONMEDICAL,
	TD.CLIENT_GENDER,
	TD.CLIENT_DISCHARGEDATE,
	TD.CLIENT_DIAGNOSISID,
	TD.CAREPERIOD_ID,
	TD.CAREPERIOD_START,
	TD.CAREPERIOD_END,
	TD.CAREPERIOD_STARTOFCARE_DATE,
	TD.CAREPERIOD_CASEMANAGER_ID,
	VF.CAREPERIOD_CASEMANAGER_NAME,
	TD.CAREPERIOD_COMMENTS,
	TD.CAREPERIOD_ISACTIVE,
	TD.CAREPERIOD_ISDISCHARGED,
	TD.CAREPERIOD_ISLINKEDTODISCHARGE,
	TD.ADMISSION_ID,
	TD.ADMISSION_SOURCE,
	TD.ADMISSION_DISCHARGE_DATE,
	TD.ADMISSION_DISCHARGE_REASON,
	TD.ADMISSION_ISDEPRECATED,
	TD.ADMISSION_ISNONMEDICAL,
	TD.ADMISSION_REFERRALID,
	TD.ADMISSION_STARTOFCARE_DATE,
	TD.ISVERIFIED_VISIT,
	TD.ADMISSION_DISCHARGE_COMMENTS,
	TD.ADMISSION_STATUS,
	TD.ACTUAL_SCHEDULED_UNITS,
	TD.DAYS_AUTH_RESTRICTED,
	COALESCE(TD.ASSIGNED_WORKER_ID,VF.CLINICIAN_ID) AS CLINICIAN_ID,
	COALESCE(TD.ASSIGNED_TO_WORKER,VF.CLINICIAN_NAME) AS CLINICIAN_NAME,
	TD.CLIENT_ISDEPRECATED,
	UPPER(TRIM(IU.UNIT)) AS UNIT_TYPE,
	TD.ETL_TASK_KEY,
	TD.ETL_INSERTED_TASK_KEY,
	TD.ETL_INSERTED_DATE,
	TD.ETL_INSERTED_BY,
	TD.ETL_LAST_UPDATED_DATE,
	TD.ETL_LAST_UPDATED_BY,
	TD.ETL_DELETED_FLAG
	FROM AXXESS.AXXESS_TASKDETAILS TD
LEFT JOIN 
(
SELECT SCHEDULED_TASK_ID, CAREPERIOD_CASEMANAGER_NAME, CLINICIAN_ID, CLINICIAN_NAME , count(1)
FROM AXXESS.AXXESS_VISITFINANCIALS 
GROUP BY SCHEDULED_TASK_ID, CAREPERIOD_CASEMANAGER_NAME, CLINICIAN_ID,CLINICIAN_NAME
)VF
ON nvl(TD.SCHEDULED_TASK_ID,'') = nvl(VF.SCHEDULED_TASK_ID,'')
LEFT JOIN AXXESS.AXXESS_INSURANCE_UNIT_TYPE IU ON TRIM(UPPER(TD.INSURANCE_NAME)) = TRIM(UPPER(IU.PRIMARY_INSURANCE))
WHERE UPPER(trim(TD.SCHEDULED_TASK_NAME)) NOT IN
(
'CASE CONFERENCE',
'CLIENT ON HOLD',
'EMPLOYEE BONUS' ,
'EMPLOYEE MILEAGE 0.42',
'EMPLOYEE TRAVEL TIME 9.30',
--'NO HHA CARE PLANS',
'HHA DISCHARGE SUMARRY',
'HHA MEETING',
'HHA SIGN ON BONUS $400',
'HHA SUPERVISORY VISIT',
'HOME SUP VISIT FROM YEARLY', 
'LPN ORIENT/ MEETING $23.00',
'LPN SUPERVISORY VISIT',
'OLD DON�T USE T1019',
'OT DISCHARGE SUMMARY',
'PHYSICIAN ORDER', 
'PT DISCHARGE SUMMARY', 
'PTO FIELD STAFF',
'REFERRAL BONUS $150.00',
'RN ORIENT/ MEETING $33.00',
'ST DISCHARGE SUMMARY',
'TRAVEL MILEAGE SHEET',
'WENDY SCHEDULE REMINDER' 
)
AND  UPPER(trim(TD.SCHEDULED_TASK_NAME)) NOT LIKE '%HHA CARE PLANS%'
AND UPPER(TRIM(TD.SCHEDULED_TASK_DISCIPLINE)) NOT IN ('REPORT & NOTES','EMPLOYEE TASKS','ORDERS')
AND TD.SCHEDULED_TASK_ID IS NOT NULL
AND TD.PRIMARY_INSURANCE_ID IS NOT NULL
);