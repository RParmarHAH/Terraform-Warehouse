resource "snowflake_procedure" "DW_HAH_GET_STAGE_AXXESS_FACT_REVENUE" {
	name ="GET_STAGE_AXXESS_FACT_REVENUE"
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
        -- NAME:  AXXESS_FACT_REVENUE
        --
        --
        -- DEVELOPMENT LOG:
        -- DATE			AUTHOR					NOTES:
        -- --------		-------------------		---------------------------------------------------------------------------------------
        -- 07/08/2022	JIGAR		            Initial Development
		-- 14/06/2023	ABHISHEK SUNIL			Changed SP to reflect ARS date format changes
		-- 24/11/2023	Preeti Sharma			Added Bill_Unit_Type Column for RCM(Requested By Natalie)
		-- 30/11/2023   Pinkal Panchal		  	Added VISIT_ID to REVENUE_KEY and divided measures partitioned by VISIT_KEY(Requested By Phil)
		-- 15/01/2024   POONIT MISTRY (OLLION)  Changed logic for homecare to not use transctions
        --*****************************************************************************************************************************

        INSERT OVERWRITE INTO STAGE.AXXESS_FACT_REVENUE
        WITH DEDUPE_LEVERAGE AS
                 (SELECT *
                  FROM (SELECT MASTER_ID,
                               PATIENT_ID
                        FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST)
                  UNION
                  SELECT *
                  FROM (SELECT DISTINCT MASTER_ID,
                                        PATIENT_ID
                        FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MATCH_LIST
                        WHERE PATIENT_ID NOT IN (SELECT PATIENT_ID
                                                 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.CLIENT_MASTER_LIST)))
                ,
             EMPLOYEE_DEDUPE AS
                 (SELECT *
                  FROM (SELECT MASTER_ID,
                               EMPLOYEE_ID,
                               (FIRST_NAME || ''  '' || LAST_NAME) AS EMP_NAME
                        FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.EMPLOYEE_MASTER_LIST)
                  UNION
                  SELECT *
                  FROM (SELECT DISTINCT MASTER_ID,
                                        EMPLOYEE_ID,
                                        (FIRST_NAME || ''  '' || LAST_NAME) AS EMP_NAME
                        FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.EMPLOYEE_MATCH_LIST
                        WHERE EMPLOYEE_ID NOT IN
                              (SELECT EMPLOYEE_ID
                               FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.AXXESS.EMPLOYEE_MASTER_LIST)))
                ,
             SUPERVISOR AS
                 ( -- THERE ARE NO PATIENTS WITH MULTIPLE SUPERVISORS. CHECKED MANUALLY ON 07/11
                     SELECT DISTINCT PATIENT_ID
                                   , PV.CASE_MANAGER_ID AS CASE_MANAGER_ID
                                   , MD5(''PRIME'' ||
                                         IFNULL(UPPER(TRIM(PV.CASE_MANAGER_ID)), ''UNKNOWN'') || ''-'' ||
                                         ''AXXESS'')    AS SUPERVISOR_KEY  -- ADDED BY PJSHAH ON 07/11
                                   , EMP.EMP_NAME       AS SUPERVISOR_NAME -- ADDED BY PJSHAH ON 07/11
                     FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_PATIENTVISITS PV
                              LEFT JOIN EMPLOYEE_DEDUPE EMP ON EMP.EMPLOYEE_ID = PV.CASE_MANAGER_ID),
             HOMEHEALTH
                 AS (SELECT DISTINCT MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(ARS.ID)), ''UNKNOWN'') || ''-'' ||
                                         IFNULL(UPPER(TRIM(VISIT.VISIT_ID)), ''UNKNOWN'') || ''-'' ||
                                         ''AXXESS'')                                             AS REVENUE_KEY,    -- Added by Pinkal on 02/08/22
                                     NVL(TRY_to_timestamp(COALESCE(FINAL_OR_MANAGEDCARE_BILL_DATE, RAP_BILL_DATE,
                                                                   ''12/31/1999 12:00:00 AM +00:00''),
                                                          ''mm/dd/yyyy HH12:MI:SS AM TZH:TZM''),
                                         TRY_to_timestamp(COALESCE(FINAL_OR_MANAGEDCARE_BILL_DATE, RAP_BILL_DATE,
                                                                   ''12/31/1999 12:00:00 AM +00:00''),
                                                          ''YYYY-MM-DD''))::date                 AS REPORT_DATE,    --need to change later
                                     MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(ARS.BRANCH_ID)), ''UNKNOWN'') ||
                                         ''-'' ||
                                         ''AXXESS'')                                             AS BRANCH_KEY,     -- Added by Pinkal on 02/08/22
                                     MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(EMP.MASTER_ID)), ''UNKNOWN'') ||
                                         ''-'' ||
                                         ''AXXESS'')                                             AS EMPLOYEE_KEY,   -- Added by Pinkal on 02/08/22
                                     MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(CLI.MASTER_ID)), ''UNKNOWN'') ||
                                         ''-'' ||
                                         ''AXXESS'')                                             AS CLIENT_KEY,     -- Added by Pinkal on 18/08/22
                                     MD5(''PRIME'' || ''-'' ||
                                         IFNULL(UPPER(TRIM(PRIMARY_INSURANCE_NAME)), ''UNKNOWN'') || ''-'' ||
                                         ''AXXESS'')                                             AS CONTRACT_KEY,   -- Added by Pinkal on 18/08/22
                                     MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(ARS.ID)), ''UNKNOWN'') || ''-'' ||
                                         ''AXXESS'')                                             AS INVOICE_KEY,    -- Added by Pinkal on 18/08/22
                                     14                                                          AS SOURCE_SYSTEM_ID,
                                     MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(SUP.CASE_MANAGER_ID)), ''UNKNOWN'') ||
                                         ''-'' ||
                                         ''AXXESS'')                                             AS SUPERVISOR_KEY, -- Added by Pinkal on 02/08/22
                                     NVL(TRY_to_timestamp(COALESCE(FINAL_OR_MANAGEDCARE_BILL_DATE, RAP_BILL_DATE,
                                                                   ''12/31/1999 12:00:00 AM +00:00''),
                                                          ''mm/dd/yyyy HH12:MI:SS AM TZH:TZM''),
                                         TRY_to_timestamp(COALESCE(FINAL_OR_MANAGEDCARE_BILL_DATE, RAP_BILL_DATE,
                                                                   ''12/31/1999 12:00:00 AM +00:00''),
                                                          ''YYYY-MM-DD''))::date                 AS REVENUE_DATE,   --TO TO CHANGE later
                                     NVL(TRY_to_timestamp(COALESCE(FINAL_CLAIM_PAYMENT_DATE, RAP_CLAIM_PAYMENT_DATE,
                                                                   ''12/31/1999 12:00:00 AM +00:00''),
                                                          ''mm/dd/yyyy HH12:MI:SS AM TZH:TZM''),
                                         TRY_to_timestamp(COALESCE(FINAL_CLAIM_PAYMENT_DATE, RAP_CLAIM_PAYMENT_DATE,
                                                                   ''12/31/1999 12:00:00 AM +00:00''),
                                                          ''YYYY-MM-DD''))::date                 AS PAYMENT_DATE,
                                     IFNULL(TRIM(BR.BRANCH), ''UNKNOWN'')                        AS BRANCH_NAME,    -- Added by Pinkal on 02/08/22
                                     IFNULL(UPPER(TRIM(EMP.MASTER_ID)), ''UNKNOWN'')             AS EMPLOYEE_ID,    -- Need to make it Nullable column.
                                     IFNULL(UPPER(TRIM(CLI.MASTER_ID)), ''UNKNOWN'')             AS CLIENT_NUMBER,  --getting null because alpha num value
                                     MD5(''PRIME'' || ''-'' ||
                                         IFNULL(UPPER(TRIM(PRIMARY_INSURANCE_NAME)), ''UNKNOWN'') || ''-'' ||
                                         ''AXXESS'')                                             AS CONTRACT_CODE,
                                     ID                                                          AS INVOICE_NUMBER,
                                     ''REGULAR''                                                 AS INVOICE_TYPE,

                                     CASE
                                         WHEN UPPER(TRIM(VISIT.BILLED_UNIT_TYPE)) IN (''EPISODE'', ''PER VISIT'')
                                             THEN ''VISIT''
                                         WHEN UPPER(TRIM(VISIT.BILLED_UNIT_TYPE)) IN
                                              (''PER VISIT / PER 15 MIN'', ''PER 15 MIN'', ''HOURLY'', ''NA'')
                                             THEN ''HOURLY''
                                         ELSE ''HOURLY''
                                         END                                                     AS BILL_UNIT_TYPE,
                                     1                                                           AS NUMBER_OF_CLIENTS,
                                     ''AXXESS''                                                  AS SYSTEM_CODE,
                                     SUP.CASE_MANAGER_ID                                         AS SUPERVISOR_CODE,
                                     null                                                        AS BILL_CODE,
                                     null                                                        AS INVOICE_HOURS,
                                     null                                                        AS INVOICE_RATE,
                                     DIV0((NVL(RAP_AMOUNT, 0) + NVL(FINAL_OR_MANAGEDCARE_AMOUNT, 0) +
                                           NVL(NET_ADJUSTMENTS, 0)), (COUNT(1) OVER
                                         (PARTITION BY ARS.ID ORDER BY ARS.ID)))                 AS AMOUNT_BILLED,
                                     DIV0(NVL(CASH_RECEIVED, 0), (COUNT(1) OVER
                                         (PARTITION BY ARS.ID ORDER BY ARS.ID)))                 AS AMOUNT_COLLECTED,
                                     DIV0(NVL(NET_RECEIVABLE, 0), (COUNT(1) OVER
                                         (PARTITION BY ARS.ID ORDER BY ARS.ID)))                 AS AMOUNT_OUTSTANDING,
                                     :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY,
                                     :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY
                             ,
                                     CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
                             ,
                                     CURRENT_USER                                                AS ETL_INSERTED_BY
                             ,
                                     CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE
                             ,
                                     CURRENT_USER                                                AS ETL_LAST_UPDATED_BY
                             ,
                                     FALSE                                                       AS ETL_DELETED_FLAG
                     FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_ARS ARS
                              LEFT JOIN DEDUPE_LEVERAGE CLI ON ARS.PATIENT_ID = CLI.PATIENT_ID
                              LEFT JOIN SUPERVISOR SUP ON SUP.PATIENT_ID = ARS.PATIENT_ID
                              LEFT JOIN DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HH_VISITS_UPPER VISIT ON VISIT.FACT_AR_ID = ARS.ID
                              LEFT JOIN EMPLOYEE_DEDUPE EMP ON EMP.EMPLOYEE_ID = VISIT.CLINICIAN_ID
                              LEFT JOIN (SELECT BRANCH_ID, BRANCH
                                         FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_EPISODESNAPSHOTS
                                         WHERE BRANCH_ID IS NOT NULL
                                         GROUP BY BRANCH_ID, BRANCH) BR ON BR.BRANCH_ID = ARS.BRANCH_ID),
             HOMECARE AS (SELECT DISTINCT MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(VF.CLAIM_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              IFNULL(UPPER(TRIM(VF.SCHEDULED_TASK_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              ''AXXESS'')                                                                             AS REVENUE_KEY,
                                          ifnull(try_to_date(vf.VISIT_START), ''1900-01-01'')                                         as report_date,
                                          MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(VF.BRANCH_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              ''AXXESS'')                                                                             AS BRANCH_KEY,
                                          MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(EMP.MASTER_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              ''AXXESS'')                                                                             AS EMPLOYEE_KEY,
                                          MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(CLI.MASTER_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              ''AXXESS'')                                                                             AS CLIENT_KEY,
                                          MD5(''PRIME'' || ''-'' ||
                                              IFNULL(UPPER(TRIM(VF.PRIMARY_INSURANCE_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              ''AXXESS'')                                                                             AS CONTRACT_KEY,
                                          MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(VISIT.CLAIM_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              ''AXXESS'')                                                                             AS INVOICE_KEY,
                                          14                                                                                          AS SOURCE_SYSTEM_ID,
                                          MD5(''PRIME'' || ''-'' ||
                                              IFNULL(UPPER(TRIM(VISIT.CAREPERIOD_CASEMANAGER_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              ''AXXESS'')                                                                             AS SUPERVISOR_KEY,
                                          TRY_TO_DATE(COALESCE(VF.VISIT_START, ''1999-12-31''),
                                                      ''YYYY-MM-DD'')                                                                 AS REVENUE_DATE,
                                          TRY_TO_DATE(VF.PAYMENT_DATE, ''YYYY-MM-DD'')                                                AS PAYMENT_DATE,
                                          IFNULL(TRIM(VF.BRANCH_NAME), ''UNKNOWN'')                                                   AS BRANCH_NAME,
                                          IFNULL(UPPER(TRIM(EMP.MASTER_ID)), ''UNKNOWN'')                                             AS EMPLOYEE_ID,   -- NEED TO MAKE IT NON-NULLABLE COLUMN
                                          IFNULL(UPPER(TRIM(CLI.MASTER_ID)), ''UNKNOWN'')                                             AS CLIENT_NUMBER, -- DATA TYPE NEEDS TO BE CHANGED
                                          MD5(''PRIME'' || ''-'' ||
                                              IFNULL(UPPER(TRIM(VF.PRIMARY_INSURANCE_ID)), ''UNKNOWN'') ||
                                              ''-'' ||
                                              ''AXXESS'')                                                                             AS CONTRACT_CODE,
                                          VISIT.CLAIM_ID                                                                              AS INVOICE_NUMBER,
                                          ''REGULAR''                                                                                 AS INVOICE_TYPE,
                                          VISIT.BILL_UNIT_TYPE                                                                        AS BILL_UNIT_TYPE,
                                          1                                                                                           AS NUMBER_OF_CLIENTS,
                                          ''AXXESS''                                                                                  AS SYSTEM_CODE,
                                          VISIT.CAREPERIOD_CASEMANAGER_ID
                                                                                                                                      AS SUPERVISOR_CODE,
                                          null                                                                                        AS BILL_CODE,
                                          null                                                                                        AS INVOICE_HOURS,
                                          null                                                                                        AS INVOICE_RATE,
                                          DIV0(NVL(VF.CLAIM_AMOUNT, 0), (COUNT(1)
                                                                               OVER (PARTITION BY VF.CLAIM_ID ORDER BY VF.CLAIM_ID))) AS AMOUNT_BILLED,
                                          DIV0(
                                                  (NVL(VF.CASH_RECEIVED, 0) + NVL(VF.NEGATIVE_ADJUSTMENT_AMOUNT, 0) -
                                                   NVL(VF.ADJUSTMENT_AMOUNT, 0)),
                                                  (COUNT(1) OVER (PARTITION BY VF.CLAIM_ID ORDER BY VF.CLAIM_ID)))                    AS AMOUNT_COLLECTED,
                                          DIV0((NVL(VF.CLAIM_AMOUNT, 0) - NVL(VF.CASH_RECEIVED, 0))
                                                   + NVL(VF.ADJUSTMENT_AMOUNT, 0) -
                                               NVL(VF.NEGATIVE_ADJUSTMENT_AMOUNT, 0),
                                               (COUNT(1)
                                                      OVER (PARTITION BY VF.CLAIM_ID ORDER BY VF.CLAIM_ID)))                          AS AMOUNT_OUTSTANDING,
                                          :STR_ETL_TASK_KEY                                                                           AS ETL_TASK_KEY,
                                          :STR_ETL_TASK_KEY                                                                           AS ETL_INSERTED_TASK_KEY
                                  ,
                                          CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                 AS ETL_INSERTED_DATE
                                  ,
                                          CURRENT_USER                                                                                AS ETL_INSERTED_BY
                                  ,
                                          CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                 AS ETL_UPDATED_DATE
                                  ,
                                          CURRENT_USER                                                                                AS ETL_LAST_UPDATED_BY
                                  ,
                                          FALSE                                                                                       AS ETL_DELETED_FLAG
                          FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_VISITFINANCIALS VF
                                   LEFT JOIN
                               (SELECT DISTINCT CLAIM_ID
                                        ,
                                                FIRST_VALUE(CAREPERIOD_CASEMANAGER_ID)
                                                            over (partition by CLAIM_ID order by CLAIM_ID) as CAREPERIOD_CASEMANAGER_ID
                                        ,
                                                CASE
                                                    WHEN UPPER(TRIM(BILLED_UNIT_TYPE)) IN (''EPISODE'', ''PER VISIT'')
                                                        THEN ''VISIT''
                                                    WHEN UPPER(TRIM(BILLED_UNIT_TYPE)) IN
                                                         (''PER VISIT / PER 15 MIN'', ''PER 15 MIN'', ''HOURLY'',
                                                          ''NA'')
                                                        THEN ''HOURLY''
                                                    ELSE ''HOURLY''
                                                    END                                                    AS BILL_UNIT_TYPE
                                FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HC_TASKDETAILS
                                WHERE CLAIM_ID IS NOT NULL
                                  AND CAREPERIOD_CASEMANAGER_ID IS NOT NULL) VISIT
                               ON VISIT.CLAIM_ID = VF.CLAIM_ID
                                   LEFT JOIN
                               (SELECT DISTINCT CLAIM_ID,
                                                FIRST_VALUE(CLINICIAN_ID) over (partition by CLAIM_ID order by CLAIM_ID) as CLINICIAN_ID
                                FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HC_TASKDETAILS
                                WHERE CLAIM_ID IS NOT NULL
                                  AND CLINICIAN_ID IS NOT NULL) VEMP
                               ON VISIT.CLAIM_ID = VEMP.CLAIM_ID
                                   LEFT JOIN EMPLOYEE_DEDUPE EMP ON EMP.EMPLOYEE_ID = VEMP.CLINICIAN_ID
                                   LEFT JOIN DEDUPE_LEVERAGE CLI ON VF.CLIENT_ID = CLI.PATIENT_ID
                          WHERE VF.SCHEDULED_TASK_ID IS NOT NULL)
        SELECT *
        FROM HOMEHEALTH
        UNION ALL
        SELECT *
        FROM HOMECARE;
        RETURN ''SUCCESS'';
    end ;

 EOT
}

