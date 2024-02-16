resource "snowflake_procedure" "DW_HAH_GET_STAGE_OSHAH_FACT_ADMISSION" {
	name ="GET_STAGE_OSHAH_FACT_ADMISSION"
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
-- NAME:  OSHAH FACT ADMISSION
--
-- PURPOSE: Populates Stage OSHAH FACT ADMISSION
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 3/01/23     Pankti Fadia           Initial version
-- 07/12/23    Sandesh Gosavi         update code to use config flag
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}."STAGE".OSHAH_FACT_ADMISSION
WITH ADMISSION_DIAGNOSIS AS
(
SELECT * FROM (
	select ROW_NUMBER () OVER(PARTITION BY PD.PATIENTID ORDER BY PD.PATIENTDIAGNOSISID DESC) AS RN,
	*FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PATIENTDIAGNOSIS PD
) WHERE rn=1)
,CONTRACT_CHANGE AS (
SELECT * FROM (
	SELECT ROW_NUMBER () OVER(PARTITION BY PATIENTID ORDER BY STARTDATE  DESC) AS RN,
	* FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PATIENTCONTRACTCHANGES 
)WHERE rn=1)
,CLIENT AS
(SELECT * FROM
	(SELECT PATIENTID, MASTER_ID, AGENCYID, LASTNAME, FIRSTNAME, OFFICEID  
	 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CLIENT_MASTER_LIST)
UNION
SELECT * FROM
    (SELECT DISTINCT PATIENTID, MASTER_ID, AGENCYID, LASTNAME, FIRSTNAME, OFFICEID
	 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CLIENT_MATCH_LIST CML
	 WHERE PATIENTID NOT IN (SELECT PATIENTID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CLIENT_MASTER_LIST))
),
COORDINATORS AS(
SELECT * FROM (SELECT ROW_NUMBER () OVER(PARTITION BY TC.COORDINATORNAME ORDER BY TC.COORDINATORID  DESC) AS RN,
			* FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.TBLCOORDINATOR_REPL TC) WHERE RN=1
),	
ADMISSIONS_DATE AS(
SELECT * FROM (SELECT ROW_NUMBER () OVER(PARTITION BY P.PATIENTID  ORDER BY P.SERVICESTARTDATE  DESC) AS RN,
			* FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PATIENTS P) WHERE RN=1
),
VISITS AS (
SELECT * FROM ( SELECT V.PATIENTID,VI.PRIMARYSERVICECODEID AS SERVICECODEID FROM  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.VISITS V 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.VISITINFO_REPL VI ON VI.VISITID = V.VISITID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.TBLVISITS_REPL TBLV ON TBLV.VISITID = VI.VISITID
UNION ALL 
 SELECT PA.PATIENTID,SERVICECODEID FROM  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PATIENTAUTHORIZATION  PA)
 GROUP BY 1,2)
SELECT DISTINCT MD5(''OSHAH''
	 || ''-'' || CLIENT.PATIENTID
     || ''-'' || P.ADMISSIONID 
     || ''-'' || SC.SERVICECODEID
     || ''-'' || ''HHAEXCHANGE'') AS CLIENT_ADMISSION_KEY
,17 AS SOURCE_SYSTEM_ID
,CONCAT(''OSHAH - '',O.STATE) AS SYSTEM_CODE
,MD5(''OSHAH''
	 || ''-'' || CLIENT.MASTER_ID
	 || ''-'' || ''HHAEXCHANGE'') AS CLIENT_KEY
,MD5(''OSHAH''
      || ''-'' || RS.REFERRALSOURCEID  
      || ''-'' || ''HHAEXCHANGE'') AS REFERRER_KEY
,MD5(''OSHAH''
	 || ''-'' || SC.SERVICECODEID 
	 || ''-'' || ''HHAEXCHANGE'') AS SERVICE_KEY   
, MD5(''OSHAH'' || ''-'' || P.PAYERID || ''-'' || COALESCE(SC.CONTRACTID,P.PAYERID) || ''-'' || ''HHAEXCHANGE'') AS PARTNER_CONTRACT_KEY
,MD5(''OSHAH''
	 || ''-'' || ADM_D.PATIENTDIAGNOSISID
	 || ''-'' || ''HHAEXCHANGE'')  AS PRIMARY_DIAGNOSIS_KEY 
,R.DATEOFBIRTH AS REFERRAL_DATE 
,MD5(''OSHAH''
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
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PATIENTS P
ON P.PATIENTID = CLIENT.PATIENTID
LEFT JOIN VISITS V ON V.PATIENTID = CLIENT.PATIENTID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PATIENTCONTRACTS_REPL PC ON P.PATIENTID = PC.PATIENTID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.REFERRAL  R
ON P.ADMISSIONID = R.ADMISSIONID 
LEFT JOIN ADMISSIONS_DATE AS ADM
ON ADM.PATIENTID = P.PATIENTID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.REFERRALSOURCE  RS
ON P.REFERRALSOURCEID = RS.REFERRALSOURCEID  
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL O ON CLIENT.OFFICEID = O.OFFICEID
 JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.SERVICECODES SC ON SC.SERVICECODEID  = V.SERVICECODEID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CONTRACTRATES CR 
ON  SC.SERVICECODEID  = CR.SERVICECODEID 
	AND CR.TODATE :: DATE > GETDATE()
	AND CR.FROMDATE :: DATE <= GETDATE()
LEFT JOIN ADMISSION_DIAGNOSIS AS ADM_D
ON ADM_D.PATIENTID = P.PATIENTID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PAYER_REPL PR 
ON PR.PAYERID = P.PAYERID  
LEFT JOIN CONTRACT_CHANGE CC ON CC.PATIENTID = P.PATIENTID
LEFT JOIN COORDINATORS TC ON 
TRIM(COALESCE(R.COORDINATOR_1,COORDINATOR_2,COORDINATOR_3)) =TRIM(TC.COORDINATORNAME)
WHERE O.STATE IN (SELECT STATE FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CONFIGURATION WHERE CONFIG = TRUE);



RETURN ''SUCCESS'';
end;

 EOT
}

