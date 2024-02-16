resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_FACT_ADMISSION" {
	name ="GET_STAGE_MATRIXCARE_FACT_ADMISSION"
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

 DECLARE
    return_result VARCHAR;
BEGIN
--*****************************************************************************************************************************
-- NAME:  MATRIXCARE_FACT_ADMISSION
--12/07/2022     SAM HUFF                Initial development
--03/13/2023	 Rajat Sapkal			 Modified initial logic
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.MATRIXCARE_FACT_ADMISSION

WITH SCHEDULE_PAYERS AS
	(
	SELECT DISTINCT SCHCP_SCHEDULEID
	,FIRST_VALUE(SCHCP_PAYERID) OVER (PARTITION BY SCHCP_SCHEDULEID ORDER BY SCHCP_SEQNO,SCHCP_ID) SCHCP_PAYERID
	,MAX(COALESCE(ETL_LAST_UPDATED_DATE, ''1/1/1900'')) OVER (PARTITION BY SCHCP_SCHEDULEID) ETL_LAST_UPDATED_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULEPAYERS
	)
, CLIENT_PAYERS AS
	(
		SELECT DISTINCT CLIPAY_CLIENTID
		,FIRST_VALUE(CLIPAY_PAYERID) OVER (PARTITION BY CLIPAY_CLIENTID ORDER BY CLIPAY_SEQNO DESC) CLIPAY_PAYERID
		,FIRST_VALUE(COALESCE(ETL_LAST_UPDATED_DATE, ''1/1/1900'')) OVER (PARTITION BY CLIPAY_CLIENTID ORDER BY CLIPAY_SEQNO DESC) ETL_LAST_UPDATED_DATE
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CLIENTPAYERS
	)
, INVOICE_PAYERS AS
	(
		SELECT DISTINCT INVD_SCHEDULEID --,INH.INVH_ID AS INVH_ID
		,FIRST_VALUE(INH.INVH_ID) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) INVH_ID
		,FIRST_VALUE(INVD_SCHEDULEPAYERID) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) INV_PAYERID
		,FIRST_VALUE(INH.ETL_LAST_UPDATED_DATE) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) ETL_LAST_UPDATED_DATE
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEHEADER INH
	 	JOIN  DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEDETAILS IND ON INH.INVH_ID = IND.INVD_INVHID
	),
		CLIENT AS
(
	SELECT * FROM
	(
		SELECT CLI_ID,MASTER_ID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT ID AS CLI_ID,MASTER_ID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MATCH_LIST
		WHERE CLI_ID NOT IN (SELECT CLI_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MASTER_LIST)
	)),
	 EMPLOYEE AS
(
	SELECT * FROM
	(
		SELECT CAR_ID, MASTER_ID,CAR_LASTNAME,CAR_FIRSTNAME
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CAR_ID, MASTER_ID,CAR_LASTNAME,CAR_FIRSTNAME
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MATCH_LIST
		WHERE CAR_ID NOT IN (SELECT CAR_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST )
	) )
SELECT DISTINCT
MD5(
        NVL(SCH.SCH_ADMISSIONID,-1) || ''-'' || 
        NVL(COALESCE(CLI.MASTER_ID::STRING,CLI.CLI_ID::STRING), '' '') || ''-'' || 
        NVL(sc.svcc_id,-1) || ''-'' ||
        NVL(COALESCE(SCHPAYER.SCHCP_PAYERID,CP.CLIPAY_PAYERID),-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                      
    as CLIENT_ADMISSION_KEY   
    ,''7''                                                                                                    AS SOURCE_SYSTEM_ID
    ,''MATRIXCARE''                                                                                           AS SYSTEM_CODE  
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        NVL(COALESCE(CLI.MASTER_ID::STRING,CLI.CLI_ID::STRING), '' '') || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                      AS CLIENT_KEY
    ,MD5 (
        ''MATRIXCARE'' || ''-'' || 
        NVL(ADM.ADM_REFERRALTYPEID, ''-1'') || ''-'' || 
        ''MATRIXCARE''
    )                                                                                                       AS REFERRER_KEY
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        sc.svcc_id || ''-'' ||
        ''MATRIXCARE''
    )                                                                                        				AS SERVICE_KEY
    ,MD5(
        ''MATRIXCARE'' || ''-'' ||
        NVL(COALESCE(SCHPAYER.SCHCP_PAYERID,CP.CLIPAY_PAYERID),-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS PARTNER_CONTRACT_KEY
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        NVL(ADM.ADM_PRIMARYDIAGNOSIS ,''-1'') || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS PRIMARY_DIAGNOSIS_KEY
 --   
    --,ADM.ADM_REFERRALDATE                                                                                   AS REFERRAL_DATE
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_REFERRALDATE)))			AS REFERRAL_DATE
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        IFNULL(ADM_REFERRALTAKENBYID, -1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS REFERRAL_INTAKE_BY_EMP_KEY
    ,CASE
        WHEN ADM.ADM_REFERRALDATE IS NOT NULL THEN SC.SVCC_NAME ELSE NULL END                               AS REFERRAL_ACCEPTED_SERVICES
    ,REFCAMP.REFTYP_NAME                                                                                    AS REFERRAL_CAMPAGIN
    ,NULL                                                                                                   AS PREVIOUS_PROVIDER
    --,ADM.ADM_ACTUALSOCDATE                                                                                  AS ADMISSION_DATE
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_ACTUALSOCDATE)))			AS ADMISSION_DATE
   -- ,IFF(CURRENT_DATE() BETWEEN
           -- ADM.ADM_ACTUALSOCDATE AND 
           -- NVL(ADM.ADM_DISCHARGEDATE,''2999-01-01''), TRUE
        -- , FALSE)                                                                                           AS STATUS
	,ADMSTS.ADMSTS_NAME                                                                                       AS STATUS
    ,ADM.ADM_PRIMARYDIAGNOSIS                                                                               AS PRIMARY_DIAGNOSIS
    ,ADM.ADM_DIAGNOSISNOTES                                                                                 AS DIAGNOSIS_NOTES
    --,ADM.ADM_DISCHARGEDATE                                                                                  AS DISCHARGE_DATE
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_DISCHARGEDATE)))			AS DISCHARGE_DATE
    ,ADM.ADM_DISCHARGESUMMARYREASON                                                                         AS DISCHARGE_REASON
	,:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
      :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
     CURRENT_USER                                              as ETL_INSERTED_BY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
     CURRENT_USER                                              as ETL_LAST_UPDATED_BY,
     0                                                         as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCH
 INNER JOIN EMPLOYEE AS EMP ON EMP.CAR_ID = SCH.SCH_CAREGIVERID
LEFT JOIN CLIENT AS CLI ON CLI.CLI_ID = SCH.SCH_CLIENTID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES AS BRANCH ON BRANCH.BR_ID = SCH.SCH_BRANCHID
AND  BRANCH.BR_NAME NOT LIKE  ''%Training%''
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING BRANCH_MAPPING ON BRANCH_MAPPING.OFFICE_CODE = SCH.SCH_BRANCHID::STRING
AND BRANCH_MAPPING.SOURCE_SYSTEM_ID = 7 AND BRANCH_MAPPING.SYSTEM_CODE = ''MATRIXCARE''
LEFT JOIN SCHEDULE_PAYERS AS SCHPAYER ON SCH.SCH_ID = SCHPAYER.SCHCP_SCHEDULEID
LEFT JOIN CLIENT_PAYERS CP ON SCH.SCH_CLIENTID = CP.CLIPAY_CLIENTID
LEFT JOIN INVOICE_PAYERS INV ON INV.INVD_SCHEDULEID = SCH.SCH_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEHEADER AS INVOICE_HEADER ON INVOICE_HEADER.INVH_ID = INV.INVH_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONS  ADM ON ADM.ADM_ID = SCH.SCH_ADMISSIONID
left join DISC_${var.SF_ENVIRONMENT}.matrixcare.STVHC_T_SERVICECODE sc on sc.svcc_id = SCH_SERVICECODEID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONSDISCHARGEREASONS ADMDISC ON ADMDISC.ADMDCR_ID = ADM.ADM_DISCHARGEREASONID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_REFERRALTYPES REFCAMP ON REFCAMP.REFTYP_ID = ADM.ADM_REFERRALCAMPAIGNID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONSTATUS ADMSTS ON ADMSTS.ADMSTS_ID = ADM.ADM_STATUSID
WHERE UPPER(TRIM(CAR_FIRSTNAME)) NOT IN (''TEST'',''MATRIX'') AND UPPER(TRIM(CAR_LASTNAME)) NOT IN (''TEST'',''SUBJECT'',''TRAINING'')
UNION -- to include admissions which are missing from schedule table
SELECT DISTINCT
MD5(
		NVL(au.AUTH_ADMISSIONID,-1) || ''-'' ||
        NVL(COALESCE(CLI.MASTER_ID::STRING,CLI.CLI_ID::STRING), '' '') || ''-'' || 
        NVL(sc.svcc_id,-1) || ''-'' ||
        NVL(au.AUTH_PAYERID,-1) || ''-'' ||
        ''MATRIXCARE''
   )                                                                                                      
   as CLIENT_ADMISSION_KEY
    ,''7''                                                                                                    AS SOURCE_SYSTEM_ID
    ,''MATRIXCARE''                                                                                           AS SYSTEM_CODE   
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        NVL(COALESCE(CLI.MASTER_ID::STRING,CLI.CLI_ID::STRING), '' '') || ''-'' || 
        ''MATRIXCARE''
    )                                                                                                      AS CLIENT_KEY
    ,MD5 (
        ''MATRIXCARE'' || ''-'' || 
        NVL(ADM.ADM_REFERRALTYPEID, ''-1'') || ''-'' || 
        ''MATRIXCARE''
    )                                                                                                       AS REFERRER_KEY
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        sc.svcc_id || ''-'' ||
        ''MATRIXCARE''
    )                                                                                        				AS SERVICE_KEY
    ,MD5(
        ''MATRIXCARE'' || ''-'' ||
        NVL(au.AUTH_PAYERID,-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS PARTNER_CONTRACT_KEY
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        NVL(ADM.ADM_PRIMARYDIAGNOSIS ,''-1'') || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS PRIMARY_DIAGNOSIS_KEY   
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_REFERRALDATE)))			AS REFERRAL_DATE
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        IFNULL(ADM_REFERRALTAKENBYID, -1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS REFERRAL_INTAKE_BY_EMP_KEY
    ,CASE
        WHEN ADM.ADM_REFERRALDATE IS NOT NULL THEN SC.SVCC_NAME ELSE NULL END                               AS REFERRAL_ACCEPTED_SERVICES
    ,REFCAMP.REFTYP_NAME                                                                                    AS REFERRAL_CAMPAGIN
    ,NULL                                                                                                   AS PREVIOUS_PROVIDER
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_ACTUALSOCDATE)))			AS ADMISSION_DATE
    ,ADMSTS.ADMSTS_NAME                                                                                     AS STATUS
    ,ADM.ADM_PRIMARYDIAGNOSIS                                                                               AS PRIMARY_DIAGNOSIS
    ,ADM.ADM_DIAGNOSISNOTES                                                                                 AS DIAGNOSIS_NOTES
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_DISCHARGEDATE)))			AS DISCHARGE_DATE
    ,ADM.ADM_DISCHARGESUMMARYREASON                                                                         AS DISCHARGE_REASON
	,:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
     CURRENT_USER                                              as ETL_INSERTED_BY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
     CURRENT_USER                                              as ETL_LAST_UPDATED_BY,
     0                                                         as ETL_DELETED_FLAG
    FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_AUTHORIZATION AU
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONS ADM ON adm.adm_id = au.AUTH_ADMISSIONID
    LEFT JOIN CLIENT AS CLI ON CLI.CLI_ID = ADM.ADM_CLIENTID
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.matrixcare.STVHC_T_SERVICECODE sc on sc.svcc_id = au.AUTH_SERVICECODEID
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONSDISCHARGEREASONS ADMDISC ON ADMDISC.ADMDCR_ID = ADM.ADM_DISCHARGEREASONID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_REFERRALTYPES REFCAMP ON REFCAMP.REFTYP_ID = ADM.ADM_REFERRALCAMPAIGNID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONSTATUS ADMSTS ON ADMSTS.ADMSTS_ID = ADM.ADM_STATUSID
UNION -- To include admissions which are missing from AUTHORIZATION table
SELECT DISTINCT
MD5(
        NVL(ADM.ADM_ID,-1) || ''-'' || 
        NVL(COALESCE(CLI.MASTER_ID::STRING,CLI.CLI_ID::STRING), '' '') || ''-'' || 
        NVL(sc.svcc_id,-1) || ''-'' ||
        NVL(au.AUTH_PAYERID,-1) || ''-'' ||
        ''MATRIXCARE''
   )                                                                                                      
   as CLIENT_ADMISSION_KEY
    ,''7''                                                                                                    AS SOURCE_SYSTEM_ID
    ,''MATRIXCARE''                                                                                           AS SYSTEM_CODE   
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        NVL(COALESCE(CLI.MASTER_ID::STRING,CLI.CLI_ID::STRING), '' '') || ''-'' || 
        ''MATRIXCARE''
    )                                                                                                      AS CLIENT_KEY
    ,MD5 (
        ''MATRIXCARE'' || ''-'' || 
        NVL(ADM.ADM_REFERRALTYPEID, ''-1'') || ''-'' || 
        ''MATRIXCARE''
    )                                                                                                       AS REFERRER_KEY
   ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        sc.svcc_id || ''-'' ||
        ''MATRIXCARE''
    )                                                                                        				AS SERVICE_KEY
    ,MD5(
        ''MATRIXCARE'' || ''-'' ||
        NVL(au.AUTH_PAYERID,-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS PARTNER_CONTRACT_KEY
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        NVL(ADM.ADM_PRIMARYDIAGNOSIS ,''-1'') || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS PRIMARY_DIAGNOSIS_KEY   
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_REFERRALDATE)))			AS REFERRAL_DATE
    ,MD5(
        ''MATRIXCARE'' || ''-'' || 
        IFNULL(ADM_REFERRALTAKENBYID, -1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS REFERRAL_INTAKE_BY_EMP_KEY
    ,CASE
        WHEN ADM.ADM_REFERRALDATE IS NOT NULL THEN SC.SVCC_NAME ELSE NULL END                               AS REFERRAL_ACCEPTED_SERVICES
    ,REFCAMP.REFTYP_NAME                                                                                    AS REFERRAL_CAMPAGIN
    ,NULL                                                                                                   AS PREVIOUS_PROVIDER
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_ACTUALSOCDATE)))			AS ADMISSION_DATE
    ,ADMSTS.ADMSTS_NAME                                                                                     AS STATUS
    ,ADM.ADM_PRIMARYDIAGNOSIS                                                                               AS PRIMARY_DIAGNOSIS
    ,ADM.ADM_DIAGNOSISNOTES                                                                                 AS DIAGNOSIS_NOTES
	,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ADM.ADM_DISCHARGEDATE)))			AS DISCHARGE_DATE
    ,ADM.ADM_DISCHARGESUMMARYREASON                                                                         AS DISCHARGE_REASON
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
      ,:STR_ETL_TASK_KEY  AS ETL_INSERTED_TASK_KEY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
     CURRENT_USER                                              as ETL_INSERTED_BY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
     CURRENT_USER                                              as ETL_LAST_UPDATED_BY,
     0                                                         as ETL_DELETED_FLAG
    FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONS ADM
    LEFT JOIN CLIENT AS CLI ON CLI.CLI_ID = ADM.ADM_CLIENTID
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_AUTHORIZATION AU ON adm.adm_id = au.AUTH_ADMISSIONID
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.matrixcare.STVHC_T_SERVICECODE sc on sc.svcc_id = au.AUTH_SERVICECODEID
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONSDISCHARGEREASONS ADMDISC ON ADMDISC.ADMDCR_ID = ADM.ADM_DISCHARGEREASONID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_REFERRALTYPES REFCAMP ON REFCAMP.REFTYP_ID = ADM.ADM_REFERRALCAMPAIGNID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONSTATUS ADMSTS ON ADMSTS.ADMSTS_ID = ADM.ADM_STATUSID;


	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN return_result;

END;


 EOT
}

