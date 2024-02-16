resource "snowflake_view" "DISC_AXXESS_VW_AXXESS_HH_VISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "VW_AXXESS_HH_VISITS"
	statement = <<-SQL
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
SQL
	or_replace = true 
	is_secure = false 
}

