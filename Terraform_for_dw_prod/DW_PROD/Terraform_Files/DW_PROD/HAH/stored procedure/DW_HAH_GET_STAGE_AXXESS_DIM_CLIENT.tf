resource "snowflake_procedure" "DW_HAH_GET_STAGE_AXXESS_DIM_CLIENT" {
	name ="GET_STAGE_AXXESS_DIM_CLIENT"
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
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/06/22    Abhishek Sunil        Initial Development
-- 04/04/22    Parag Gajjar          Logic Change
-- 05/09/22    Parag Gajjar          Dedup Leverage
-- 06/28/22	   POOJA SHAH			 CORRECTIONS RELATED TO DEDUP AND MASTERID
-- 08/17/22	   POOJA SHAH			 ENHANCEMENTS FOR HOMECARE DATA
-- 14/06/23	   PINKAL PANCHAL		 Changed SP to reflect ARS date format changes
-- 08/31/23    SANDESH GOSAVI        Add CONFIRMED_FLAG logic in CONFIRMED_VISITS CTE to avoid clients future last_service_date
-- 08/31/23    Deeepen Gajjar        Added logic for client_ethnicity
-- 09/11/23    Abhishek Sunil        Added temp fix for client ethincity logic
-- 11/08/2023  Trushali Ramoliya    Added the column for HISPANIC_OR_LATINO and also updated the logic for ethnicity as per IDDOX - 388
-- 11/20/23    Sandesh	Gosavi      Added CLIENT_STATUS Field
-- 11/21/23   Sandesh Gosavi        ADDED A LOGIC AND COLUMN FOR DISCHARGE_REASON
-- 11/27/2023  DEEPEN GAJJAR        UPDATE LOGIC FOR PRIMAYR BRANCH KEY, PRIMARY BRANCH NAME, PRIMARY BRANCH STATE
-- 12/08/2023  TRUSHALI RAMOLIYA    ADDED A LENGHT 50 AS WE ARE RECEIVING INAPPROPRIATE VALUES FROM SOURCE TABLES.
-- 01/09/2024  TRUSHALI RAMOLIYA    made changes in CLIENT_ETH cte for client_ethnicity as it was causing duplicate issue in pipeline
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.AXXESS_DIM_CLIENT 
WITH branchinfo AS (
SELECT *
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HC_BRANCHINFO 
UNION 
SELECT *
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HH_BRANCHINFO 
)
,STATUS_MAPPING AS 
(
SELECT DISTINCT MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(VISIT_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS VISIT_KEY, VISIT_NAME  ,VISIT_TYPE,
TRY_TO_DATE(COALESCE(VISIT_DATE,''1999-12-31''), ''YYYY-MM-DD'') AS VISIT_DATE ,CLINICIAN_ID ,SCHEDULE_DATE  ,UPPER(TRIM(VISIT_STATUS)) AS VISIT_STATUS,IS_MISSED_VISIT ,VISIT_TIME_IN ,VISIT_TIME_OUT ,''HH'' AS REVENUE_CATEGORY 
,HV.FACT_AR_ID , UPPER(TRIM(AR.FINAL_OR_MANAGEDCARE_STATUS)) AS INVOICE_STATUS
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HH_VISITS_UPPER HV
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_ARS AR ON HV.FACT_AR_ID =AR.ID
UNION ALL 
SELECT   DISTINCT
         VISIT_KEY                     
        ,SCHEDULED_TASK_NAME   
        ,SCHEDULED_TASK_DISCIPLINE
        ,VISIT_START
        ,CLINICIAN_ID                        
        ,SCHEDULED_TASK_STARTDATE
        ,SCHEDULED_TASK_STATUS
        ,SCHEDULED_TASK_ISMISSEDVISIT
        ,VISIT_START_TIME        
        ,VISIT_END          
        ,REVENUE_CATEGORY
        ,CLAIM_ID                            
        ,FIRST_VALUE(INVOICE_STATUS) OVER(PARTITION BY VISIT_KEY ORDER BY PRECEDENCE)
        --,PRECEDENCE
FROM 
(
SELECT DISTINCT  MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(SCHEDULED_TASK_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS VISIT_KEY, SCHEDULED_TASK_NAME , SCHEDULED_TASK_DISCIPLINE,
CAST(COALESCE(VISIT_START,''1999-12-31'') AS DATE) AS VISIT_START,CLINICIAN_ID,SCHEDULED_TASK_STARTDATE ,UPPER(TRIM(SCHEDULED_TASK_STATUS)) AS SCHEDULED_TASK_STATUS,SCHEDULED_TASK_ISMISSEDVISIT,VISIT_START AS VISIT_START_TIME,
VISIT_END,''HC'' AS REVENUE_CATEGORY,TD.CLAIM_ID ,TRIM(UPPER(FT.CLAIM_STATUS)) AS INVOICE_STATUS,
CASE WHEN TRIM(UPPER(FT.CLAIM_STATUS))=''OVER PAID'' THEN 1
       WHEN TRIM(UPPER(FT.CLAIM_STATUS))=''PAID'' THEN 2
       WHEN TRIM(UPPER(FT.CLAIM_STATUS))=''PARTIALLY PAID'' THEN 3 
       WHEN TRIM(UPPER(FT.CLAIM_STATUS))=''SUBMITTED'' THEN 4 END AS PRECEDENCE
--SELECT DISTINCT TRIM(UPPER(FT.CLAIM_STATUS))
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HC_TASKDETAILS  TD 
--LEFT JOIN (SELECT CLAIM_ID, MAX(TRANSACTION_DATE) TRANSACTION_DATE FROM  DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_FINANCIALTRANSACTIONS GROUP BY CLAIM_ID) FIN  ON FIN.CLAIM_ID=TD.CLAIM_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_FINANCIALTRANSACTIONS FT ON TD.CLAIM_ID =FT.CLAIM_ID and  FT.TRANSACTION_ID IS NOT NULL--AND FT.TRANSACTION_DATE =FIN.TRANSACTION_DATE
)T
),
DERIVED_VISIT  AS
(
SELECT STATUS_MAPPING.VISIT_KEY AS VISIT_KEY,	
	CASE
			--WHEN TRY_TO_DATE(TRIM(VISIT_DATE),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) THEN ''Future''
			WHEN VISIT_DATE > TO_DATE(GETDATE()) THEN ''Future''
--			WHEN IS_MISSED_VISIT=''True''  OR  VISIT_STATUS IN (''MISSED VISIT(COMPLETE)'',''MISSED VISIT(PENDING)'')  --AND  (VISIT_TIME_IN IS  NULL AND  VISIT_TIME_OUT IS NULL )   
--			THEN ''Did not happen''
			WHEN (IS_MISSED_VISIT=''True''  OR  VISIT_STATUS IN (''MISSED VISIT(COMPLETE)'',''MISSED VISIT(PENDING)'') ) --AND  (VISIT_TIME_IN IS  NULL AND  VISIT_TIME_OUT IS NULL )   
            OR (VISIT_STATUS IN (''NOT YET DUE'',''RETURNED W/ PHYSICIAN SIGNATURE'',''COMPLETED'',''MISSED VISIT(COMPLETE)'') AND STATUS_MAPPING.CLINICIAN_ID IS NULL)
            THEN ''Did not happen''
			WHEN (VISIT_STATUS) IN (''NOTECOMPLETED'',''OASISCOMPLETEDEXPORTREADY'',''OASISEXPORTED'',''ORDERRECEIVED'',
										''EVALRETURNEDWPHYSICIANSIGNATURE'',''NOTEMISSEDVISITCOMPLETE'',''NONOASISCOMPLETED'',
										''COMPLETED'',''COMPLETED(EXPORT READY)'',''COMPLETED(NOT EXPORTED)'',''EXPORTED''
										,''COMPLETED'',''COMPLETED(EXPORT READY)'',''COMPLETED(NOT EXPORTED)'',''EXPORTED'',''RETURNED W/ PHYSICIAN SIGNATURE'',''COMPLETED (NOT EXPORTED)''
										,''COMPLETED (EXPORT READY)'',
										''OASISCOMPLETEDNOTEXPORTED'') 
										THEN ''Completed''
			WHEN (VISIT_STATUS) IN (''ORDERREOPENED'',''NOTEREOPENED'',''NOTERETURNED'',''OASISNOTYETDUE'',
										''OASISNOTSTARTED'',''ORDERTOBESENTTOPHYSICIAN'',''NOTESAVED'',''ORDERNOTYETSTARTED'',''ORDERSENTTOPHYSICIAN'',''NOTENOTYETDUE'',
										''OASISSAVED'',''OASISREOPENED'',''ORDERRETURNEDFORCLINICIANREVIEW'',''ORDERSAVED''
										,''NOT YET DUE'',''SAVED'',''RETURNED FOR REVIEW'',''TO BE SENT TO PHYSICIAN'',
							            ''SENT TO PHYSICIAN (MANUALLY)'',''RETURNED FOR CLINICIAN SIGNATURE'',''NOT YET STARTED''
							            ,''COMPLETED (PENDING QA REVIEW)'',''OASISCOMPLETEDPENDINGREVIEW'',''REOPENED'',''SUBMITTED (PENDING QA REVIEW)''
							            ,''SUBMITTED WITH SIGNATURE'',''SUBMITTED PENDING CO-SIGNATURE'',''MISSED VISIT(RETURN FOR REVIEW)'') 
										THEN ''In Review''
			WHEN (VISIT_STATUS) IN (''NOTESUBMITTEDWITHSIGNATURE'',''ORDERSUBMITTEDPENDINGREVIEW'',''NOTEMISSEDVISITPENDING'',
										''SUBMITTEDWITHSIGNATUREPENDINGOASISAPPROVAL'') 
										THEN ''Pending''
   		 ELSE ''Completed'' END AS DERIVED_VISIT_STATUS -- UNKNOWN
FROM STATUS_MAPPING
),
CONFIRMED_FLAG_CTE AS		--Added By Pinkal on 11/25/2022
(
	SELECT STATUS_MAPPING.VISIT_KEY,STATUS_MAPPING.REVENUE_CATEGORY,VIS.DERIVED_VISIT_STATUS,
	CASE WHEN NVL(VIS.DERIVED_VISIT_STATUS,'''') IN (''In Review'',''Completed'') AND STATUS_MAPPING.CLINICIAN_ID IS NOT NULL THEN ''YES'' 
	 WHEN  NVL(VIS.DERIVED_VISIT_STATUS,'''')=''Did not happen'' 	THEN ''NO''
	 ELSE ''UNKNOWN'' END AS CONFIRMED_FLAG
	FROM  STATUS_MAPPING 
	LEFT JOIN DERIVED_VISIT VIS ON VIS.VISIT_KEY=STATUS_MAPPING.VISIT_KEY
),
VISITS AS (
SELECT DISTINCT
		 MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(PV.VISIT_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS VISIT_KEY	-- Added by Pinkal on 24/08/22	
		,TRY_TO_DATE(COALESCE(PV.VISIT_DATE,''1999-12-31''), ''YYYY-MM-DD'') AS VISIT_DATE	-- Added by Pinkal on 24/08/22	
		,14 AS SOURCE_SYSTEM_ID
		,PV.PATIENT_ID AS CLIENT_NUMBER
		,''PRIME'' AS SYSTEM_CODE
		
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HH_VISITS_UPPER PV
WHERE VISIT_TYPE NOT IN (''ReportsAndNotes'') AND
PV.VISIT_STATUS NOT IN (''OrderReturnedWPhysicianSignature'',''NoteNotStarted'')

--/* -- COMMENTED BY PJSHAH ON 160822
AND PV.VISIT_ID IS NOT NULL 
AND PV.VISIT_DATE IS NOT NULL 
AND PV.BRANCH_ID IS NOT NULL
AND PV.PATIENT_ID IS NOT NULL 
AND PV.CLINICIAN_ID IS NOT NULL 
AND PV.CASE_MANAGER_ID IS NOT NULL 
AND PV.VISIT_DATE IS NOT NULL
 --*/

UNION ALL  -- FOR HOMECARE DATA 

SELECT DISTINCT 
	 MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(PV.SCHEDULED_TASK_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS VISIT_KEY
--	,TRY_TO_DATE(COALESCE(PV.VISIT_START,''1999-12-31''), ''YYYY-MM-DD'') AS REPORT_DATE
	,CAST(COALESCE(PV.VISIT_START,''1999-12-31'') AS DATE) AS VISIT_DATE  -- Added by Pinkal on 31/10/22
	,14 AS SOURCE_SYSTEM_ID
	,PV.CLIENT_ID AS CLIENT_NUMBER -- CHECK FOR VARCHAR -- NEED TO MAP CLIENT_ID NUMERIC
	,''PRIME'' AS SYSTEM_CODE
	
FROM
DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HC_TASKDETAILS PV
WHERE PV.SCHEDULED_TASK_ID IS NOT NULL --AND FIN.TRANSACTION_ID IS NOT NULL
)--SELECT * FROM VISITS
, DEDUP_LEVERAGE AS
 (
	    SELECT * FROM 
	(
		SELECT MASTER_ID,PATIENT_ID 
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST  		
	)
	UNION
	SELECT * FROM 
	(
		SELECT DISTINCT MASTER_ID, PATIENT_ID 
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MATCH_LIST  
		WHERE PATIENT_ID NOT IN (SELECT PATIENT_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST)			
	)
)
,EMP_DEDUPE --- ADDED BY PJSHAH ON 07/01
AS
(
  SELECT * FROM 
	(
		SELECT MASTER_ID, EMPLOYEE_ID, (FIRST_NAME || ''  '' || LAST_NAME) AS EMP_NAME
		--SELECT *
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.EMPLOYEE_MASTER_LIST  		
	)
	UNION
	SELECT * FROM 
	(
		SELECT  MASTER_ID, EMPLOYEE_ID, (FIRST_NAME || ''  '' || LAST_NAME) AS EMP_NAME
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.EMPLOYEE_MATCH_LIST  
		WHERE EMPLOYEE_ID NOT IN (SELECT EMPLOYEE_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.EMPLOYEE_MASTER_LIST)			
	)
)
, 
CONFIRMED_VISITS AS (SELECT DISTINCT
                      V.VISIT_KEY
                      ,V.VISIT_DATE
                      ,B.MASTER_ID AS MASTER_ID
              FROM VISITS V
              INNER JOIN DEDUP_LEVERAGE B ON B.PATIENT_ID = V.CLIENT_NUMBER
              LEFT JOIN CONFIRMED_FLAG_CTE AS SCH ON SCH.VISIT_KEY = V.VISIT_KEY
--              LEFT JOIN DW_${var.SF_ENVIRONMENT}."STAGE".AXXESS_DIM_VISIT_STATUS_MAPPING VSM 
--              ON VSM.VISIT_STATUS_KEY = SCH.VISIT_STATUS_KEY
              WHERE SCH.CONFIRMED_FLAG = ''YES'')
, 
SERVICE_DATES
 AS (

SELECT DISTINCT MASTER_ID,  -- E.G.MASTER_ID=''0741f99e-828e-46cc-8427-bf2c09bc7c18'' 
	   MIN(VISIT_DATE) AS FIRST_SERVICE_DATE,
	   MAX(VISIT_DATE) AS LAST_SERVICE_DATE
	   FROM CONFIRMED_VISITS CV
       GROUP BY MASTER_ID
)
,SUPERVISORS 
AS
(
SELECT SUP.*, EMP.EMP_NAME AS SUPERVISOR_NAME
FROM 
	(-- HOME HEALTH :
		SELECT
					DISTINCT
					B.MASTER_ID, 
				 	FIRST_VALUE(PV.CASE_MANAGER_ID) OVER (PARTITION BY B.MASTER_ID ORDER BY B.MASTER_ID) AS CASE_MANAGER_ID,	-- TO AVOID DUPLICATE ROWS DUE TO MULTIPLE SUPERVISORS FOR A PATIENT
					PV.BRANCH_ID
	FROM
		DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_PATIENTVISITS PV
		INNER JOIN DEDUP_LEVERAGE B ON	PV.PATIENT_ID = B.MASTER_ID -- BCOZ, WE NEED TO FETCH SUPERVISOR OF THE CLIENT WHICH IS IN MASTER LIST
		WHERE	VISIT_TYPE NOT IN (''ReportsAndNotes'')
		AND	VISIT_STATUS NOT IN (''OrderReturnedWPhysicianSignature'', ''NoteNotStarted'')		
	UNION   
	--  HOMECARE :			
			SELECT DISTINCT  
					B.MASTER_ID, 
					FIRST_VALUE(CAREPERIOD_CASEMANAGER_ID) OVER (PARTITION BY CLIENT_ID ORDER BY CLIENT_ID) AS CASE_MANAGER_ID,	-- TO AVOID DUPLICATE ROWS DUE TO MULTIPLE SUPERVISORS FOR A PATIENT
					BRANCH_ID  
			FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_CAREPERIODS VF
		    LEFT JOIN  DEDUP_LEVERAGE B  ON VF.CLIENT_ID = B.MASTER_ID -- BCOZ, WE NEED TO FETCH SUPERVISOR OF THE CLIENT WHICH IS IN MASTER LIST
			WHERE CAREPERIOD_CASEMANAGER_ID IS NOT NULL
	) SUP 
LEFT JOIN EMP_DEDUPE EMP ON EMP.EMPLOYEE_ID=SUP.CASE_MANAGER_ID
) 
, 
BRANCH 
AS 
(
-- HOME HEALTH :
	SELECT
		DISTINCT CES.MASTER_ID, --ES.PATIENT_ID,
		BI.BRANCH_ID,
		ES.BRANCH ,
		BI.ADDRESS_STATECODE 
		/**** ADDED BELOW COLUMNS TO AVOID DUPLICATION ***/  -- ADDED BY PJSAH ON 6/28
		,MIN(NVL(TRY_TO_DATE(TRIM(ES.START_OF_CARE_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''),
		TRY_TO_DATE(TRIM(ES.START_OF_CARE_DATE),''YYYY-MM-DD''))) OVER (PARTITION BY TRIM(ES.PATIENT_ID)) AS BEGIN_DATE		--Changed on 14/06/23
		,UPPER(TRIM(ES.ADDRESSLINE_1)) AS CLIENT_ADDRESS1
		,IFF(TRIM(ES.ADDRESSLINE_2) <> '''',UPPER(TRIM(ES.ADDRESSLINE_2)),NULL) AS CLIENT_ADDRESS2
		,TRIM(ES.ZIPCODE) AS CLIENT_ZIP
		,NULLIF(UPPER(TRIM(ES.EMAIL_ADDRESS)),'''') AS CLIENT_PERSONAL_EMAIL
		,NOT FIRST_VALUE(TRIM(ES.IS_DISCHARGED)) OVER (PARTITION BY ES.PATIENT_ID ORDER BY NVL(TRY_TO_DATE(TRIM(ES.EPISODE_END_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''),
			TRY_TO_DATE(TRIM(ES.EPISODE_END_DATE),''YYYY-MM-DD'')) DESC) AS ACTIVE_CLIENT_FLAG		--Changed on 14/06/23
		, ES.PATIENT_STATUS AS CLIENT_STATUS							  
		,FIRST_VALUE(IFF(TRIM(UPPER(ES.PATIENT_STATUS)) = ''PENDING'', TRUE, FALSE)) OVER (PARTITION BY ES.PATIENT_ID ORDER BY NVL(TRY_TO_DATE(TRIM(ES.EPISODE_END_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''),
			TRY_TO_DATE(TRIM(ES.EPISODE_END_DATE),''YYYY-MM-DD''))DESC) AS ON_HOLD_FLAG		--Changed on 14/06/23
		FROM
		DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_EPISODESNAPSHOTS ES
	    LEFT JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST CES ON ES.PATIENT_ID = CES.PATIENT_ID  -- CES.MASTER_ID
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_BRANCHINFO BI ON ES.BRANCH_ID = BI.BRANCH_ID 
		WHERE ES.BRANCH_ID IS NOT NULL -- MODIFIFED BY PJSHAH ON 6/28
-- HOME CARE :
UNION 
SELECT
	DISTINCT 
	CLI.MASTER_ID,
	BRANCH_ID ,
	BRANCH_NAME,
	BRANCH_STATE_CODE ,
	MIN(TRY_TO_DATE(TRIM(CAREPERIOD_START_DATE), '' MM / DD / YYYY HH12:MI:SS AM + TZH:TZM'')) OVER (PARTITION BY TRIM(CP.CLIENT_ID)) AS BEGIN_DATE,
	--UPPER(TRIM(CLIENT_ADDRESS1)) AS CLIENT_ADDRESS1 ,
	--UPPER(TRIM(CLIENT_ADDRESS2)) AS CLIENT_ADDRESS2 ,
    FIRST_VALUE (UPPER(TRIM(CLIENT_ADDRESS1))) OVER (PARTITION BY CLI.PATIENT_ID ORDER BY TRY_TO_DATE
    (TRIM(CP.CAREPERIOD_START_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM'') DESC) AS CLIENT_ADDRESS1 ,
    FIRST_VALUE (UPPER(TRIM(CLIENT_ADDRESS2))) OVER (PARTITION BY CLI.PATIENT_ID ORDER BY TRY_TO_DATE
    (TRIM(CP.CAREPERIOD_START_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM'') DESC) AS CLIENT_ADDRESS2 ,
	--TRIM(CLIENT_ZIP) AS CLIENT_ZIP,
	FIRST_VALUE(TRIM(CLIENT_ZIP)) OVER (PARTITION BY CP.CLIENT_ID ORDER BY CP.MRN  DESC) AS CLIENT_ZIP,		--Added by Pinkal on 22/11/22
	NULL AS CLIENT_PERSONAL_EMAIL,
	--CASE WHEN UPPER(TRIM(CLIENT_STATUS))=''ACTIVE'' THEN TRUE ELSE FALSE END AS ACTIVE_CLIENT_FLAG,
    NOT FIRST_VALUE(TRIM(CASE WHEN UPPER(TRIM(CLIENT_STATUS))=''ACTIVE'' THEN TRUE ELSE FALSE END)) OVER (PARTITION BY CLI.PATIENT_ID ORDER BY TRY_TO_DATE(TRIM(CP.CAREPERIOD_START_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM'') DESC) AS ACTIVE_CLIENT_FLAG,
	CP.CLIENT_STATUS,			  
	NULL AS ON_HOLD_FLAG
FROM
	DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_CAREPERIODS CP
	INNER JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST CLI ON	CLI.PATIENT_ID = CP.CLIENT_ID
),
DISCHARGE_REASON 
AS 
(
-- HOME HEALTH :
SELECT
		DISTINCT CES.MASTER_ID, --ES.PATIENT_ID,
		    FIRST_VALUE(TRIM(ES.EPISODE_DISCHARGE_REASON)) OVER (PARTITION BY ES.PATIENT_ID ORDER BY NVL(TRY_TO_DATE(TRIM(ES.START_OF_CARE_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''),
			TRY_TO_DATE(TRIM(ES.START_OF_CARE_DATE),''YYYY-MM-DD'')) DESC ,NVL(TRY_TO_DATE(TRIM(ES.EPISODE_START_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''),
			TRY_TO_DATE(TRIM(ES.EPISODE_START_DATE),''YYYY-MM-DD'')) DESC,
		 NVL(TRY_TO_DATE(TRIM(ES.EPISODE_END_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''),
			TRY_TO_DATE(TRIM(ES.EPISODE_END_DATE),''YYYY-MM-DD'')) DESC ) AS DISCHARGE_REASON		
	FROM
		DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_EPISODESNAPSHOTS ES
	    LEFT JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST CES ON ES.PATIENT_ID = CES.PATIENT_ID  -- CES.MASTER_ID
		WHERE ES.BRANCH_ID IS NOT NULL 
-- HOME CARE :
UNION 

SELECT
	DISTINCT 
	CLI.MASTER_ID,
	FIRST_VALUE(TRIM(CP.ADMISSION_DISCHARGE_REASON)) OVER (PARTITION BY CLI.PATIENT_ID ORDER BY NVL(TRY_TO_DATE(TRIM(CP.CAREPERIOD_START_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''),
	TRY_TO_DATE(TRIM(CP.ADMISSION_STARTOFCARE_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM'' )) DESC) AS DISCHARGE_REASON
FROM
	DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_CAREPERIODS CP
	INNER JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST CLI ON	CLI.PATIENT_ID = CP.CLIENT_ID
)
,
CLIENT_ETH AS (
-- HOME_CARE
 SELECT FIRST_VALUE(COALESCE (CLIENT_RACES, CLIENT_ETHNICITIES)) OVER(PARTITION BY CP.CLIENT_ID  ORDER BY COALESCE (CLIENT_RACES, CLIENT_ETHNICITIES) ASC ) AS CLIENT_RACES,
--COALESCE (CLIENT_RACES, CLIENT_ETHNICITIES ) AS CLIENT_RACES,
 CP.CLIENT_ID AS PATIENT_ID, MASTER_ID
 FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_CAREPERIODS CP 
 JOIN  DEDUP_LEVERAGE DL ON DL.PATIENT_ID = CP.CLIENT_ID 
 UNION
 --HOME_HEALTH
  SELECT FIRST_VALUE(COALESCE (RACE, ENTHNICITY)) OVER(PARTITION BY CP.PATIENT_ID  ORDER BY COALESCE (RACE, ENTHNICITY) ASC ) AS CLIENT_RACES,
-- COALESCE (RACE, ENTHNICITY) AS CLIENT_RACES, 
 CP.PATIENT_ID, MASTER_ID
 FROM  DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_PATIENTINFO CP
 JOIN  DEDUP_LEVERAGE DL ON DL.PATIENT_ID = CP.PATIENT_ID 
)
SELECT DISTINCT
		MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(CLI.MASTER_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS CLIENT_KEY	-- Added by Pinkal on 02/08/22
		,CLI.MASTER_ID  AS CLIENT_NUMBER
		,''PRIME'' AS SYSTEM_CODE
		,14 AS SOURCE_SYSTEM_ID,
		CASE 
     		WHEN LENGTH(NULLIF(REGEXP_REPLACE(TRIM(CLI.SSN),''\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]''),'''')) = 9 
				AND NULLIF(REGEXP_REPLACE(TRIM(CLI.SSN),''\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]''),'''') NOT IN (SELECT SSN FROM DATA_MANAGEMENT.DATA_QUALITY.INVALID_SSN)
				THEN HEX_ENCODE(NULLIF(REGEXP_REPLACE(TRIM(CLI.SSN),''\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]''),''''))
     		ELSE NULL
     	END AS CLIENT_PID	-- Added by Pinkal on 02/08/22
		,TRY_TO_DATE(TRIM(CLI.DATE_OF_BIRTH),''YYYY-MM-DD'') AS CLIENT_DOB
		,NULL AS CLIENT_DATE_OF_DEATH 
		,UPPER(TRIM(CLI.GENDER)) AS CLIENT_GENDER
		,LEFT (CASE WHEN TRIM(CE.CLIENT_RACES)= '''' THEN NULL
			 WHEN TRIM(CE.CLIENT_RACES) ILIKE ''%BLACK OR AFRICAN%'' THEN ''BLACK OR AFRICAN AMERICAN''
			 WHEN  TRIM(CE.CLIENT_RACES) ILIKE ''%WHITE%'' THEN ''WHITE''
			 WHEN  TRIM(CE.CLIENT_RACES) ILIKE ''%NATIVE HAWAIIAN%'' THEN ''NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER''
			 WHEN  TRIM(UPPER(CE.CLIENT_RACES)) IN (''ASIAN'',''KOREAN'') THEN ''ASIAN''
			 WHEN  TRIM(CE.CLIENT_RACES) ILIKE ''%HISPANIC%'' THEN NULL
		 ELSE TRIM(UPPER(CE.CLIENT_RACES)) END,50) AS CLIENT_ETHNICITY
		,CASE WHEN CE.CLIENT_RACES ILIKE ANY  (''%not%HISPANIC%OR%LATINO%'')THEN FALSE 
	  		  WHEN CE.CLIENT_RACES ILIKE ANY  (''%HISPANIC%OR%LATINO%'') THEN TRUE 
	     ELSE FALSE END AS HISPANIC_OR_LATINO
		,NULL AS CLIENT_MARITAL_STATUS
		,NULL AS CLIENT_SALUTATION
		,UPPER(TRIM(CLI.FIRST_NAME)) AS CLIENT_FIRST_NAME
		,UPPER(TRIM(CLI.MIDDLE_INITIAL)) AS CLIENT_MIDDLE_NAME -- GET MIDDLE INITIAL FROM PATIENT_INFO
		,UPPER(TRIM(CLI.LAST_NAME)) AS CLIENT_LAST_NAME
		,UPPER(TRIM(CLI.LAST_NAME)) || '', '' || UPPER(TRIM(CLI.FIRST_NAME)) || '' '' || IFNULL(UPPER(TRIM(CLI.MIDDLE_INITIAL)),'''') AS CLIENT_NAME
		,BR.CLIENT_ADDRESS1
		,BR.CLIENT_ADDRESS2	
		,REGEXP_SUBSTR(UPPER(CLI.CITY), ''[a-zA-Z0-9]+'') AS CLIENT_CITY	-- Added by Pinkal on 02/08/22
		,UPPER(TRIM(CLI.STATE)) AS CLIENT_STATE_CODE
		,BR.CLIENT_ZIP
		,NULL AS CLIENT_CLN_ADDRESS1
		,NULL AS CLIENT_CLN_ADDRESS2
		,NULL AS CLIENT_CLN_CITY
		,NULL AS CLIENT_CLN_STATE_CODE
		,NULL AS CLIENT_CLN_ZIP
		,NULL AS CLIENT_STD_ADDRESS1
		,NULL AS CLIENT_STD_ADDRESS2
		,NULL AS CLIENT_STD_CITY
		,NULL AS CLIENT_STD_STATE_CODE
		,NULL AS CLIENT_STD_ZIP
		,NULLIF(TRIM(REGEXP_REPLACE(UPPER(CLI.EMERGENCY_CONTACT_PHONE),''[A-Z]|\\\\\\\\(|\\\\\\\\)|\\:|\\-|\\\\\\\\s|\\\\\\\\.|\\\\#|\\\\\\\\*|\\/'')),'''') AS CLIENT_HOME_PHONE	-- Added by Pinkal on 02/08/22
     	,NULLIF(TRIM(REGEXP_REPLACE(UPPER(CLI.PHONE),''[A-Z]|\\\\\\\\(|\\\\\\\\)|\\:|\\-|\\\\\\\\s|\\\\\\\\.|\\\\#|\\\\\\\\*|\\/'')),'''') AS CLIENT_CELL_PHONE	-- Added by Pinkal on 02/08/22
		,NULL AS CLIENT_WORK_PHONE
		,NULL AS CLIENT_FAX_NUMBER
		,BR.CLIENT_PERSONAL_EMAIL
		,TRY_TO_DATE(TRIM(CLI.REFERRAL_DATE),''YYYY-MM-DD'') AS REFERRAL_DATE --EMPTY FOR the extra patients coming FOR PATIENTINFO
		--,IFF(
		--DATEDIFF(DAY, TRY_TO_DATE(TRIM(CLI.REFERRAL_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''), SERV.FIRST_SERVICE_DATE) < 0, 
		--	0, 
		--	DATEDIFF(DAY, TRY_TO_DATE(TRIM(CLI.REFERRAL_DATE),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM''), SERV.FIRST_SERVICE_DATE)
		--) AS DAYS_TO_SERVICE*/
          ,IFF( DATEDIFF(DAY, TRY_TO_DATE(TRIM(COALESCE(CLI.REFERRAL_DATE, BR.BEGIN_DATE)),''YYYY-MM-DD''), SERV.FIRST_SERVICE_DATE) < 0,
          0,
          DATEDIFF(DAY, TRY_TO_DATE(TRIM(COALESCE(CLI.REFERRAL_DATE, BR.BEGIN_DATE)),''YYYY-MM-DD''),SERV.FIRST_SERVICE_DATE) ) AS DAYS_TO_SERVICE
		,NULL AS CONTRACT_BEGIN_DATE -- EPISODE START DATE - NULL FOR ALL other SOURCE systems
		,NULL AS CONTRACT_END_DATE -- EPISODE DISCHARGED DATE - NULL FOR ALL other SOURCE systems
		,SERV.FIRST_SERVICE_DATE AS FIRST_SERVICE_DATE 
		,SERV.LAST_SERVICE_DATE AS LAST_SERVICE_DATE 
    -- 	,TRY_TO_DATE(TRIM(BR.BEGIN_DATE ),''MM/DD/YYYY HH12:MI:SS AM +TZH:TZM'') AS BEGIN_DATE
         ,TRY_TO_DATE(TRIM(BR.BEGIN_DATE ),''YYYY-MM-DD'') AS BEGIN_DATE
		,NULL AS END_DATE
    	,BR.ACTIVE_CLIENT_FLAG 	
		,UPPER(BR.CLIENT_STATUS) AS CLIENT_STATUS										 
		,CASE  WHEN len(DR.DISCHARGE_REASON) > 4995 
		       THEN LEFT(TRIM(DR.DISCHARGE_REASON), 4995) 
		       ELSE TRIM(DR.DISCHARGE_REASON) END AS DISCHARGE_REASON									  
		,BR.ON_HOLD_FLAG
		,NULL AS ON_HOLD_START_DATE
		,NULL AS ON_HOLD_END_DATE
		,NULL AS LINKED_ID
		,NULL AS ACQUIRED_FROM_COMPANY_KEY
		,NULL AS ACQUIRED_FROM_COMPANY_ID
		,NULL AS ACQUIRED_FROM_COMPANY_FULL_NAME
		,NULL AS ACQUISITION_DATE
		,NULL AS ACQUISITION_FLAG
		,NULL AS ADMISSION_DATE
		,NULL AS ADMISSION_FLAG
		,NULL AS CLIENT_CONVERTED_FLAG 
		,MD5(''PRIME'' || ''-''  || IFNULL(UPPER(TRIM(SUP.CASE_MANAGER_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS PRIMARY_SUPERVISOR_KEY	-- Added by Pinkal on 02/08/22
		,SUP.CASE_MANAGER_ID AS PRIMARY_SUPERVISOR_CODE
		,SUP.SUPERVISOR_NAME AS PRIMARY_SUPERVISOR_NAME --- LEVERAGED EMPLOYEE DEDUP ADDED BY PJSHAH ON 07/01 --Parag : TO be PUT AFTER EMPLOYEE_NAME IS PUT IN EMPLOYEE_INFO
		,NULL AS SECONDARY_SUPERVISOR_KEY
		,NULL AS SECONDARY_SUPERVISOR_CODE
		,NULL AS SECONDARY_SUPERVISOR_NAME
		,MD5(''PRIME'' || ''-'' || COALESCE (UPPER(TRIM(BR.BRANCH_ID)),UPPER(TRIM(BI.BRANCH_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS PRIMARY_BRANCH_KEY	-- Added by Pinkal on 02/08/22
		,UPPER(TRIM(COALESCE(BR.ADDRESS_STATECODE,BI.LOCATION_ADDRESS_STATE_CODE,''OH''))) || '' - '' || COALESCE(UPPER(TRIM(BR.BRANCH)),UPPER(TRIM(BI."NAME")),''UNKNOWN'') || '' ('' || COALESCE(O.OFFICE_CODE ,''-1'') || '')'' AS PRIMARY_BRANCH_NAME
		,COALESCE(BR.ADDRESS_STATECODE,BI.LOCATION_ADDRESS_STATE_CODE,''OH'') AS PRIMARY_BRANCH_STATE
		,NULL AS GUARANTOR_NAME
		,CLI.MEDICAL_RECORD_NUMBER AS NOTES -- ADDED BY PJSHAH ON 07/01 TILL WE GET MRN ADDED TO DIM_CLIENT 
        ,NULL AS AGENCY
		,TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
		,TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
		,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
   		,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
		,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ as ETL_INSERTED_DATE
		,CURRENT_USER as ETL_INSERTED_BY
		,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ as ETL_UPDATED_DATE
		,CURRENT_USER as ETL_LAST_UPDATED_BY
		,0 as ETL_DELETED_FLAG
		,0 as ETL_INFERRED_MEMBER_FLAG
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST CLI 
	   	LEFT JOIN SERVICE_DATES SERV ON TRIM(CLI.MASTER_ID) = TRIM(SERV.MASTER_ID) 
		LEFT JOIN SUPERVISORS SUP ON TRIM(CLI.MASTER_ID) = TRIM(SUP.MASTER_ID)
		LEFT JOIN BRANCH BR ON TRIM(CLI.MASTER_ID) = TRIM(BR.MASTER_ID)
		LEFT JOIN BRANCHINFO BI ON BI.BRANCH_ID = TRIM(BR.BRANCH_ID )													   
		LEFT JOIN DISCHARGE_REASON DR ON TRIM(CLI.MASTER_ID) = TRIM(DR.MASTER_ID)																   
		LEFT JOIN CLIENT_ETH CE ON TRIM(CLI.MASTER_ID) = TRIM(CE.MASTER_ID) AND TRIM(CLI.PATIENT_ID) = TRIM(CE.PATIENT_ID)
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_BRANCH_OFFICE_MAPPING O ON O.BRANCH_ID = TRIM(BR.BRANCH_ID );
RETURN ''SUCCESS'';
end;                        

 EOT
}

