resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_FACT_ADMISSION" {
	name ="GET_STAGE_PREFERRED_FACT_ADMISSION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
--*****************************************************************************************************************************
-- NAME:  PREFERRED FACT ADMISSION
--
-- PURPOSE: Populates Stage PREFERRED FACT ADMISSION
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 3/07/23     Pankti Fadia           Initial version
-- 06/28/23    Nutan Jagnade          service_key logic change 
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}."STAGE".PREFERRED_FACT_ADMISSION
WITH ADMISSION_DIAGNOSIS AS
(
SELECT * FROM (
	select ROW_NUMBER () OVER(PARTITION BY PD.PATIENTID ORDER BY PD.PATIENTDIAGNOSISID DESC) AS RN,
	*FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.PATIENTDIAGNOSIS PD
) WHERE rn=1)
,CONTRACT_CHANGE AS (
SELECT * FROM (
	SELECT ROW_NUMBER () OVER(PARTITION BY PATIENTID ORDER BY STARTDATE  DESC) AS RN,
	* FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.PATIENTCONTRACTCHANGES 
)WHERE rn=1)
,CLIENT AS
(SELECT * FROM
	(SELECT MD5(AGENCYID|| ''-'' ||MASTER_ID|| ''-'' || ''PREFERRED'' ) as CLIENT_KEY,
PATIENTID, MASTER_ID, AGENCYID, LASTNAME, FIRSTNAME, OFFICEID  
	 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST)
UNION
SELECT * FROM
    (SELECT DISTINCT MD5(AGENCYID|| ''-'' ||MASTER_ID|| ''-'' || ''PREFERRED'' ) as CLIENT_KEY,
PATIENTID, MASTER_ID, AGENCYID, LASTNAME, FIRSTNAME, OFFICEID
	 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CLIENT_MATCH_LIST CML
	 WHERE PATIENTID NOT IN (SELECT PATIENTID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST))
),
COORDINATORS AS(
SELECT * FROM (SELECT ROW_NUMBER () OVER(PARTITION BY TC.COORDINATORNAME ORDER BY TC.COORDINATORID  DESC) AS RN,
			* FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.TBLCOORDINATOR_REPL TC) WHERE RN=1
),
ADMISSIONS_DATE AS(
SELECT * FROM (SELECT ROW_NUMBER () OVER(PARTITION BY P.PATIENTID  ORDER BY P.SERVICESTARTDATE  DESC) AS RN,
			* FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.STAGE_PATIENTS P) WHERE RN=1
),
VISITS AS (
    SELECT * FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.VISITS V QUALIFY row_number() OVER (partition by v.visitid order by v.primaryservicecode) = 1
                )
SELECT DISTINCT MD5(''PREFERRED''
	 || ''-'' || CLIENT.PATIENTID
     || ''-'' || P.ADMISSIONID 
     || ''-'' ||NVL(VOR.REVENUE_SUBCATEGORY_CODE,''-1'')
     || ''-'' || SC.SERVICECODEID
     || ''-'' || ''HHAEXCHANGE'') AS CLIENT_ADMISSION_KEY
,17 AS SOURCE_SYSTEM_ID
,CONCAT(''PREFERRED'') AS SYSTEM_CODE
--,MD5(''PREFERRED''
--	 || ''-'' || CLIENT.MASTER_ID
--	 || ''-'' || ''HHAEXCHANGE'') AS CLIENT_KEY
, DC.CLIENT_KEY AS CLIENT_KEY
,MD5(''PREFERRED''
      || ''-'' || RS.REFERRALSOURCEID  
      || ''-'' || ''HHAEXCHANGE'') AS REFERRER_KEY
--,MD5(''PREFERRED''
	 --|| ''-'' || SC.SERVICECODEID 
	 --|| ''-'' || ''HHAEXCHANGE'') AS SERVICE_KEY 
, MD5(''PREFERRED'' || ''-'' || SC.SERVICECODEID || ''-'' ||NVL(VOR.REVENUE_SUBCATEGORY_CODE,''-1'')|| ''-'' || ''HHAEXCHANGE'')  AS SERVICE_KEY
,MD5(''PREFERRED'' || ''-'' ||  NVL(PR.PAYERID,-1) || ''-'' || COALESCE(PR.CONTRACTID,PR.PAYERID,SC.CONTRACTID) || ''-'' || ''HHAEXCHANGE'') AS PARTNER_CONTRACT_KEY
,MD5(''PREFERRED''
	 || ''-'' || ADM_D.PATIENTDIAGNOSISID
	 || ''-'' || ''HHAEXCHANGE'')  AS PRIMARY_DIAGNOSIS_KEY 
,R.DATEOFBIRTH AS REFERRAL_DATE 
,MD5(''PREFERRED''
	|| ''-'' || TC.COORDINATORID
	|| ''-'' || ''HHAEXCHANGE'') AS REFERRAL_TAKEN_BY_EMP_KEY  
,R.ACCEPTEDSERVICES AS REFERAL_ACCEPTED_SERVICES
,IFNULL(RS.REFERRALSOURCETYPE, ''UNKNOWN'') AS REFERRAL_CAMPAIGN
,NULL AS PREVIOUS_PROVIDER 
,ADM.SERVICESTARTDATE  AS ADMISSION_DATE   
,CASE WHEN P.STATUSID = ''01'' THEN ''Waiting''
WHEN P.STATUSID = ''02'' THEN ''Pending''
WHEN P.STATUSID = ''03'' THEN ''Active''
WHEN P.STATUSID = ''04'' THEN ''Hospitalized''
WHEN P.STATUSID = ''05'' THEN ''Discharged''
WHEN P.STATUSID = ''06'' THEN ''Partially Placed''
WHEN P.STATUSID = ''07'' THEN ''ROC''
WHEN P.STATUSID = ''08'' THEN ''Hold''
ELSE NULL END AS STATUS
,ADM_D.CODE AS PRIMARY_DIAGNOSIS --DIAGNOSIS.DIAGNOSIS_CODE AS PRIMARY_DIAGNOSIS,
,ADM_D.DESCRIPTION AS DIAGNOSIS_NOTES
,CASE WHEN P.STATUSID = ''05'' THEN P.DISCHARGEDATE  END AS DISCHARGE_DATE
,CC.DISCHARGEREASONTEXT AS DISCHARGE_REASON --Need TO Clarify
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 AS ETL_DELETED_FLAG
FROM CLIENT
INNER JOIN HAH.DIM_CLIENT DC
	ON DC.CLIENT_KEY = CLIENT.CLIENT_KEY
        AND DC.SYSTEM_CODE = ''PREFERRED''
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.STAGE_PATIENTS P
ON P.PATIENTID = CLIENT.PATIENTID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA 
 ON CLIENT.PATIENTID = PA.PATIENTID
LEFT JOIN VISITS V ON V.PATIENTID = CLIENT.PATIENTID
--LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.VISITINFO_REPL VI ON VI.VISITID = V.VISITID
--LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.REVENUE_MAPPING  vor ON VI.VISITID  = VOR.VISITID
--LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.TBLVISITS_REPL TBLV ON TBLV.VISITID = VI.VISITID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.STAGE_PATIENTCONTRACTS_REPL PC ON P.PATIENTID = PC.PATIENTID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.REFERRAL  R
ON P.ADMISSIONID = R.ADMISSIONID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.REFERRALSOURCE  RS
ON P.REFERRALSOURCEID = RS.REFERRALSOURCEID  
--JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.SERVICECODES SC ON SC.CONTRACTID = PC.CONTRACTID
JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.SERVICECODES SC ON SC.CONTRACTID = PA.CONTRACTID
   	 	 AND SC.SERVICECODEID = PA.SERVICECODEID
  LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.REVENUE_MAPPING  vor ON VOR.SERVICECODEID  = SC.SERVICECODEID 	 	 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CONTRACTS C ON SC.CONTRACTID = C.CONTRACTID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CONTRACTRATES CR 
ON  SC.SERVICECODEID  = CR.SERVICECODEID 
	AND CR.TODATE :: DATE > GETDATE()
	AND CR.FROMDATE :: DATE <= GETDATE()
LEFT JOIN ADMISSION_DIAGNOSIS AS ADM_D
ON ADM_D.PATIENTID = P.PATIENTID 
LEFT JOIN ADMISSIONS_DATE AS ADM
ON ADM.PATIENTID = P.PATIENTID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.STAGE_PAYER_REPL PR 
ON IFNULL(PR.CONTRACTID,PR.PAYERID) = SC.CONTRACTID  
LEFT JOIN CONTRACT_CHANGE CC ON CC.PATIENTID = P.PATIENTID
LEFT JOIN COORDINATORS TC ON 
TRIM(COALESCE(R.COORDINATOR_1,COORDINATOR_2,COORDINATOR_3)) =TRIM(TC.COORDINATORNAME);
RETURN ''SUCCESS'';
end;

 EOT
}

