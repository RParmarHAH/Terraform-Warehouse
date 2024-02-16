create or replace view DISC_PROD.AXXESS.VW_AXXESS_HH_VISITS(
	VISIT_ID,
	BRANCH_ID,
	EPISODE_ID,
	PATIENT_ID,
	ACCOUNT,
	BRANCH,
	PAYOR_TYPE,
	PAYOR_CLASS,
	EPISODE_PRIMARY_INSURANCE,
	CURRENT_PRIMARY_INSURANCE,
	START_OF_CARE_DATE,
	EPISODE_START_DATE,
	EPISODE_END_DATE,
	EPISODE_DISCHARGE_DATE,
	MRN,
	PATIENT_FIRST_NAME,
	PATIENT_LAST_NAME,
	PATIENT_STATUS,
	ADMISSION_STATUS,
	DATE_OF_BIRTH,
	PATIENT_AGE,
	CITY,
	COUNTY,
	STATE,
	ZIP_CODE,
	VISIT_NAME,
	VISIT_TYPE,
	VISIT_STATUS,
	VISIT_DATE,
	VISIT_TIME_IN,
	VISIT_TIME_OUT,
	SCHEDULE_DATE,
	CLINICIAN_NAME,
	IS_MISSED_VISIT,
	ADDRESSLINE_1,
	ADDRESSLINE_2,
	IS_ORDER_FOR_NEXT_EPISODE,
	IS_VISIT_AUTHORIZATION_REQUIRED,
	IS_VISIT_AUTHORIZED,
	ORDER_NUMBER,
	ORDER_EPISODE_ID,
	ORDER_CERTIFICATION_START_DATE,
	ORDER_CERTIFICATION_END_DATE,
	ORDER_MD_SIGNATURE_DATE,
	ORDER_PHYSICIAN,
	ORDER_RECEIVED_BY,
	ORDER_RECEIVED_DATE,
	ORDER_SENT_DATE,
	ORDER_TYPE,
	FACT_AR_ID,
	ISBILLABLE,
	IS_COMPLETED_VISIT,
	CASE_MANAGER_ID,
	CLINICIAN_ID,
	INSURANCE_FEE_SCHEDULE_ID,
	INSURANCE_ID,
	PAYER_ID,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
) as
SELECT * FROM AXXESS.AXXESS_PATIENTVISITS PV
WHERE PV.VISIT_NAME  NOT IN (
'Change in Focus (SN)', -- Added BY PJShah ON 06/10
'10-Day Summary/Case Conference',
'30 Day Summary/ Case Conference',
'485 Plan of care' ,
'60 Day Summary/ Case Conference', 
'Communication note',
'Coordination of Care', 
'COTA Supervisory Visit',
'Discharge Summary( Auto Generated )',
'Driver / Transportation Log' ,
'End of Episode Sumarry ( Auto – Generated )', 
'Face to Face Encounter', 
'HHA Care Plan',
'HHA Sup Visit',
'Incident log' ,
'Infection log' ,
'Medicaid POC',
'Medicare Eligibility Report' ,
'OT Discharge Summary' ,
'Physican Order' ,
'Plan of care',
'Plan of Treatment' ,
'Post Hospitalization Order', 
'PT Discharge Summary' ,
'PT Plan of Care',
'ST discharge Summary', 
'Transfer Summary' ,
'Transfer Summary ( auto generated )')
--AND VISIT_STATUS IN ('Submitted', 'Returned for Review ',')
AND
(PV.VISIT_STATUS IN ('Submitted ( Pending QA Review )' 
,'Returned for Review'
--,'Completed ( Pending QA Review)'
--,'Completed ( Export Ready)'
,'Exported'
,'OasisExported'
--,'Completed ( not exported)' 
,'Completed'
,'Missed – if you want to see missed visits' 
,'Missed Visits ( pending QA Review) if you want to see missed'
,'Submitted with Signature '
,'Returned for Clinician Signature')
OR 
PV.VISIT_STATUS  LIKE '%Completed%'
)
AND
VISIT_TYPE NOT IN ('ReportsAndNotes') AND
PV.VISIT_STATUS NOT IN ('OrderReturnedWPhysicianSignature','NoteNotStarted');