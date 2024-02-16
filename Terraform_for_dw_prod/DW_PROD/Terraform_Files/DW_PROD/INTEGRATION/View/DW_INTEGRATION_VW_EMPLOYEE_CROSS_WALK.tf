resource "snowflake_view" "DW_INTEGRATION_VW_EMPLOYEE_CROSS_WALK" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "VW_EMPLOYEE_CROSS_WALK"
	statement = <<-SQL
	 
WITH MAPPED_EMPLOYEES AS 
	(
	    SELECT 	APM.*,
	    		APP.APPLICANT_KEY, APP.APPLICANT_SOURCE_SYSTEM_ID , APP.APPLICANT_SYSTEM_CODE, APP.APPLICANT_ID 
	    FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_AMS_PAYROLL_MAPPING APM
	    FULL OUTER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.APPLICANT_WORKDAY_EMPLOYEE_MAPPING APP 
	    	ON APM.AMS_EMPLOYEE_KEY = APP.EMPLOYEE_KEY 
	    WHERE NVL(APM.PAYROLL_STATE_CODE,'') NOT IN ('NY', 'DC','FL') 
--	    	APM.AMS_STATE_CODE in ('IN','PA','IL','MS','MO','AL','MI','GA','OH','DE','KY','TN','FL','SC') 
--	        OR APM.PAYROLL_STATE_CODE in ('IN','PA','IL','MS','MO','AL','MI','GA','OH','DE','KY','TN','FL','SC') 
	)
 -- SELECT COUNT(*) FROM MAPPED_EMPLOYEES;
, BR_STATE_NULL_EMPLOYEES AS 
	(
	    SELECT DISTINCT E.EMPLOYEE_KEY
	    FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_PAYROLL_MERGE_DEDUPE E
	    INNER JOIN MAPPED_EMPLOYEES M
	        ON M.PAYROLL_EMPLOYEE_KEY = E.EMPLOYEE_KEY
	    LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_BRANCH_MERGED BR
	        on E.PRIMARY_BRANCH_KEY = BR.original_branch_key
	    WHERE COALESCE(E.PRIMARY_BRANCH_STATE, BR.OFFICE_STATE_CODE) IS NULL 
	) -- select * from BR_STATE_NULL_EMPLOYEES; -- 5113
, ACTIVE_PAYROLL_EMPLOYEE AS (
    SELECT EMPLOYEE_KEY, 
        PAYROLL_DATE LAST_PAYROLL_DATE,
        BRANCH_KEY,
        ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_KEY ORDER BY PAYROLL_DATE DESC) R
     FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_PAYROLL_MERGED
--     WHERE PAYROLL_DATE >= CAST( '2020-01-01' AS DATE)
	 ----------
     QUALIFY R = 1
) 
, ACTIVE_VISIT_EMPLOYEE AS (
    SELECT EMPLOYEE_KEY, 
        SERVICE_DATE LAST_SERVICE_DATE,
        BRANCH_KEY,
        ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_KEY ORDER BY SERVICE_DATE DESC) R
     FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_VISIT_MERGED
--     WHERE SERVICE_DATE >= CAST( '2020-01-01' AS DATE) AND CONFIRMED_FLAG ='YES'
     WHERE CONFIRMED_FLAG ='YES'
     QUALIFY R = 1
) -- SELECT * FROM ACTIVE_VISIT_EMPLOYEE; -- 
-----------------------
, ACROSS_DUPS_EXCLUDE AS 
	(
		WITH MAPPING_OUTPUT AS 
		(
		SELECT CLUSTER_ID , SOURCE_SYSTEM, ID, SOURCE_SYSTEM_ID , SYSTEM_CODE, "NAME"  
		FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.AMS_PAYROLL_MAPPING_OUTPUT
		WHERE CLUSTER_ID IN 
			(SELECT CLUSTER_ID
			FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.AMS_PAYROLL_MAPPING_OUTPUT
			GROUP BY 1 HAVING COUNT(*)>2)
		)
		,NOT_IN_AMS_P_MAPPING AS
			(SELECT * FROM MAPPING_OUTPUT
			WHERE ID NOT IN 
				(SELECT DISTINCT AMS_EMPLOYEE_KEY FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_AMS_PAYROLL_MAPPING
				UNION 
				SELECT DISTINCT PAYROLL_EMPLOYEE_KEY FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_AMS_PAYROLL_MAPPING)
			)
		SELECT * FROM NOT_IN_AMS_P_MAPPING
	)
, UNMAPPED_APPLIANTS AS
	(WITH APP AS
		(
		-- WD applicants which don't have any linked id for paradox
		SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE , APPLICANT_ID , APPLICANT_KEY , APPLICANT_ID AS WORKDAY_ID
		FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_APPLICANT 
		WHERE SOURCE_SYSTEM_ID = 36 
		AND LINKED_ID IS NULL
		---- 
		UNION 
		----
		SELECT PARADOX_SOURCE_SYSTEM_ID, PARADOX_SYSTEM_CODE, PARADOX_APPLICANT_ID, PARADOX_APPLICANT_KEY, WORKDAY_ID  
		FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.VW_WORKDAY_PARADOX_APPLICANT_MAPPING
		)
	SELECT * FROM APP 
	-- Filter to exclude the applicants which are already mapped with any AMS
	WHERE NOT APPLICANT_KEY IN 
		(SELECT DISTINCT APPLICANT_KEY FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.APPLICANT_WORKDAY_EMPLOYEE_MAPPING)
	)
, FINAL AS (

------------------------------------------------------------------------------
-- ** This Union gets data for only the employees which have AMS and Payroll both mapped 
-------------------------------------------------------------------------------
        SELECT DISTINCT 
        	EMP.EMPLOYEE_FIRST_NAME FIRST_NAME, 
            EMP.EMPLOYEE_LAST_NAME LAST_NAME, 
            COALESCE(BR_PAYROLL.Office_State_Code,EMP.PRIMARY_BRANCH_STATE,BR_AMS.Office_State_Code) AS BRANCH_STATE_CODE,
            VI.EMP_ID AS BROADSPIRE_ID,
            M.AMS_EMPLOYEE_KEY,
            M.AMS_SOURCE_SYSTEM_ID,
			M.AMS_SYSTEM_CODE,
			M.AMS_EMPLOYEE_ID,
			OBJECT_CONSTRUCT_KEEP_NULL
                (
               'NAME_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_FIRST_NAME', EM.EMPLOYEE_FIRST_NAME,
                                   'EMPLOYEE_MIDDLE_NAME', EM.EMPLOYEE_MIDDLE_NAME,
                                   'EMPLOYEE_LAST_NAME', EM.EMPLOYEE_LAST_NAME,
                                   'EMPLOYEE_SUFFIX',EM.EMPLOYEE_SUFFIX,
                                   'JOB_TITLE',EM.JOB_TITLE
                                   ),
                'EMAIL_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_PERSONAL_EMAIL', EM.EMPLOYEE_PERSONAL_EMAIL,
                                   'EMPLOYEE_WORK_EMAIL', EM.EMPLOYEE_WORK_EMAIL                           
                                   ),
                'ADDRESS_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_ADDRESS1', EM.EMPLOYEE_ADDRESS1,
                                   'EMPLOYEE_ADDRESS2', EM.EMPLOYEE_ADDRESS2,
                                   'EMPLOYEE_CITY', EM.EMPLOYEE_CITY,
                                   'EMPLOYEE_STATE_CODE', EM.EMPLOYEE_STATE_CODE,
                                   'EMPLOYEE_ZIP', EM.EMPLOYEE_ZIP
                                   ),--PHONE_DATA
                'PHONE_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_HOME_PHONE', EM.EMPLOYEE_HOME_PHONE,
                                   'EMPLOYEE_CELL_PHONE', EM.EMPLOYEE_CELL_PHONE,
                                   'EMPLOYEE_WORK_PHONE', EM.EMPLOYEE_WORK_PHONE
                                   ),--JOB_DATA
                'JOB_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_ID', EM.EMPLOYEE_ID ,
                                   'WORKDAY_INTERNAL_ID', NULL,
                                   'EMPLOYEE_TYPE', EM.EMPLOYEE_TYPE,
                                   'EMPLOYEE_HIRE_DATE', EM.EMPLOYEE_HIRE_DATE, 
                                   'DERIVED_EMPLOYEE_HIRE_DATE', EM.DERIVED_EMPLOYEE_HIRE_DATE, 
                                   'EMPLOYEE_BENEFIT_START_DATE', EM.EMPLOYEE_BENEFIT_START_DATE, 
                                   'EMPLOYEE_FIRST_CHECK_DATE', EM.EMPLOYEE_FIRST_CHECK_DATE, 
                                   'JOB_TITLE', EM.JOB_TITLE, 
                                   'WORK_STATE', EM.WORK_STATE, 
                                   'PRIMARY_BRANCH_NAME', EM.PRIMARY_BRANCH_NAME,
                                   'EMPLOYEE_CATEGORY', EM.EMPLOYEE_CATEGORY ,
                                   'EMPLOYEE_TERMINATE_DATE', EM.EMPLOYEE_TERMINATE_DATE ,
                                   'DERIVED_EMPLOYEE_TERMINATE_DATE', EM.DERIVED_EMPLOYEE_TERMINATE_DATE ,
                                   'REASON_TO_TERMINATE', EM.REASON_TO_TERMINATE,
                                   'ABLE_TO_REHIRE_FLAG', EM.ABLE_TO_REHIRE_FLAG
                                   ),   
                'PERSONAL_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_MARITAL_STATUS', EM.EMPLOYEE_MARITAL_STATUS, 
                                   'EMPLOYEE_ETHNICITY', EM.EMPLOYEE_ETHNICITY, 
                                   'EMPLOYEE_DOB', EM.EMPLOYEE_DOB, 
                                   'EMPLOYEE_DATE_OF_DEATH', EM.EMPLOYEE_DATE_OF_DEATH, 
                                   'EMPLOYEE_GENDER', EM.EMPLOYEE_GENDER
                                   )
           )  AS AMS_METADATA,
            M.PAYROLL_EMPLOYEE_KEY,
            M.PAYROLL_SOURCE_SYSTEM_ID,
			M.PAYROLL_SYSTEM_CODE,
			M.PAYROLL_EMPLOYEE_ID,
			OBJECT_CONSTRUCT_KEEP_NULL
                (
               'NAME_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_FIRST_NAME', EMP.EMPLOYEE_FIRST_NAME,
                                   'EMPLOYEE_MIDDLE_NAME', EMP.EMPLOYEE_MIDDLE_NAME,
                                   'EMPLOYEE_LAST_NAME', EMP.EMPLOYEE_LAST_NAME,
                                   'EMPLOYEE_SUFFIX',EMP.EMPLOYEE_SUFFIX,
                                   'JOB_TITLE',EMP.JOB_TITLE
                                   ),
                'EMAIL_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_PERSONAL_EMAIL', EMP.EMPLOYEE_PERSONAL_EMAIL,
                                   'EMPLOYEE_WORK_EMAIL', EMP.EMPLOYEE_WORK_EMAIL                           
                                   ),
                'ADDRESS_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_ADDRESS1', EMP.EMPLOYEE_ADDRESS1,
                                   'EMPLOYEE_ADDRESS2', EMP.EMPLOYEE_ADDRESS2,
                                   'EMPLOYEE_CITY', EMP.EMPLOYEE_CITY,
                                   'EMPLOYEE_STATE_CODE', EMP.EMPLOYEE_STATE_CODE,
                                   'EMPLOYEE_ZIP', EMP.EMPLOYEE_ZIP
                                   ),--PHONE_DATA
                'PHONE_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_HOME_PHONE', EMP.EMPLOYEE_HOME_PHONE,
                                   'EMPLOYEE_CELL_PHONE', EMP.EMPLOYEE_CELL_PHONE,
                                   'EMPLOYEE_WORK_PHONE', EMP.EMPLOYEE_WORK_PHONE
                                   ),--JOB_DATA
                'JOB_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_ID', EMP.EMPLOYEE_ID ,
                                   'WORKDAY_INTERNAL_ID', NULL,
                                   'EMPLOYEE_TYPE', EMP.EMPLOYEE_TYPE,
                                   'EMPLOYEE_HIRE_DATE', EMP.EMPLOYEE_HIRE_DATE, 
                                   'DERIVED_EMPLOYEE_HIRE_DATE', EMP.DERIVED_EMPLOYEE_HIRE_DATE, 
                                   'EMPLOYEE_BENEFIT_START_DATE', EMP.EMPLOYEE_BENEFIT_START_DATE, 
                                   'EMPLOYEE_FIRST_CHECK_DATE', EMP.EMPLOYEE_FIRST_CHECK_DATE, 
                                   'JOB_TITLE', EMP.JOB_TITLE, 
                                   'WORK_STATE', EMP.WORK_STATE,
                                   'PRIMARY_BRANCH_NAME', EMP.PRIMARY_BRANCH_NAME,
                                   'PRIMARY_BRANCH_STATE', EMP.PRIMARY_BRANCH_STATE,
                                   'EMPLOYEE_CATEGORY', EMP.EMPLOYEE_CATEGORY ,
                                   'EMPLOYEE_TERMINATE_DATE', EMP.EMPLOYEE_TERMINATE_DATE,
                                   'DERIVED_EMPLOYEE_TERMINATE_DATE', EMP.DERIVED_EMPLOYEE_TERMINATE_DATE,
                                   'REASON_TO_TERMINATE', EMP.REASON_TO_TERMINATE,
                                   'ABLE_TO_REHIRE_FLAG', EMP.ABLE_TO_REHIRE_FLAG
                                   ),   
                'PERSONAL_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_MARITAL_STATUS', EMP.EMPLOYEE_MARITAL_STATUS, 
                                   'EMPLOYEE_ETHNICITY', EMP.EMPLOYEE_ETHNICITY, 
                                   'EMPLOYEE_DOB', EMP.EMPLOYEE_DOB, 
                                   'EMPLOYEE_DATE_OF_DEATH', EMP.EMPLOYEE_DATE_OF_DEATH, 
                                   'EMPLOYEE_GENDER', EMP.EMPLOYEE_GENDER
                                   )
            )  AS PAYROLL_METADATA,
            M.APPLICANT_KEY AS APPLICANT_EMPLOYEE_KEY,
            M.APPLICANT_SOURCE_SYSTEM_ID AS APPLICANT_SOURCE_SYSTEM_ID,
			M.APPLICANT_SYSTEM_CODE AS APPLICANT_SYSTEM_CODE,
			M.APPLICANT_ID AS APPLICANT_EMPLOYEE_ID,
            CASE 
              WHEN M.AMS_EMPLOYEE_KEY IS NOT NULL AND M.PAYROLL_EMPLOYEE_KEY IS NOT NULL
--                    AND NULL_BR.EMPLOYEE_KEY IS NULL  --to make exception flag true for null branch_state employees
              THEN FALSE 
              ELSE TRUE 
            END AS EXCEPTION_FLAG,
            EM.PAYROLL_ID AS AMS_PAYROLL_ID,
            COALESCE(EMP.EMPLOYEE_PID, EM.EMPLOYEE_PID) AS EMPLOYEE_SSN
        FROM MAPPED_EMPLOYEES M 
        LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_AMS_MERGED EM
            ON M.AMS_EMPLOYEE_KEY = EM.EMPLOYEE_KEY 
        LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_PAYROLL_MERGE_DEDUPE EMP
        	ON M.PAYROLL_EMPLOYEE_KEY = EMP.EMPLOYEE_KEY 
        LEFT JOIN ACTIVE_PAYROLL_EMPLOYEE AS FP 
            ON FP.EMPLOYEE_KEY = M.PAYROLL_EMPLOYEE_KEY
        LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_Branch_Merged AS BR_AMS
            ON COALESCE(EM.PRIMARY_BRANCH_KEY,FP.BRANCH_KEY) = BR_AMS.ORIGINAL_Branch_Key 
        LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_Branch_Merged AS BR_PAYROLL
            ON COALESCE(EMP.PRIMARY_BRANCH_KEY,FP.BRANCH_KEY) = BR_PAYROLL.ORIGINAL_Branch_Key
        LEFT JOIN BR_STATE_NULL_EMPLOYEES NULL_BR
            ON M.PAYROLL_EMPLOYEE_KEY = NULL_BR.EMPLOYEE_KEY
        LEFT JOIN APP_DB_${var.SF_ENVIRONMENT}.BROADSPIRE.VW_BROADSPIRE_WEEKLY_REPORT VI
        ON VI.EMPLOYEE_KEY = M.PAYROLL_EMPLOYEE_KEY
        AND VI.BAD_DATA_FLAG = 0
          WHERE M.PAYROLL_EMPLOYEE_KEY IS NOT NULL AND M.AMS_EMPLOYEE_KEY IS NOT NULL
--          COALESCE(BR_PAYROLL.Office_State_Code,EMP.PRIMARY_BRANCH_STATE ,BR_AMS.Office_State_Code) IN ('IN','PA','IL','MS','MO','AL','MI','GA','OH','DE','KY','TN','FL','SC')
          AND TRIM(COALESCE(BR_PAYROLL.Office_State_Code,EMP.WORK_STATE, EMP.PRIMARY_BRANCH_STATE ,BR_AMS.Office_State_Code, '')) NOT IN ('NY', 'DC','FL')
------------------------------------------------------------------------------
-- ** TO get those payroll records which were not be able to mapped with any AMS
-------------------------------------------------------------------------------
        union 
        SELECT DISTINCT 
        	EMP.EMPLOYEE_FIRST_NAME FIRST_NAME, 
            EMP.EMPLOYEE_LAST_NAME LAST_NAME,
            COALESCE(EMP.WORK_STATE, EMP.PRIMARY_BRANCH_STATE, BR.Office_State_Code) AS BRANCH_STATE_CODE,
            VI.EMP_ID AS BROADSPIRE_ID,
            NULL AS AMS_EMPLOYEE_KEY, 
            NULL AS AMS_SOURCE_SYSTEM_ID,
			NULL AS AMS_SYSTEM_CODE,
			NULL AS AMS_EMPLOYEE_ID,
			NULL AS AMS_METADATA,
            EMP.EMPLOYEE_KEY AS PAYROLL_EMPLOYEE_KEY,
            EMP.SOURCE_SYSTEM_ID AS PAYROLL_SOURCE_SYSTEM_ID,
			EMP.SYSTEM_CODE AS PAYROLL_SYSTEM_CODE,
			EMP.EMPLOYEE_ID AS PAYROLL_EMPLOYEE_ID,
			OBJECT_CONSTRUCT_KEEP_NULL
                (
               'NAME_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_FIRST_NAME', EMP.EMPLOYEE_FIRST_NAME,
                                   'EMPLOYEE_MIDDLE_NAME', EMP.EMPLOYEE_MIDDLE_NAME,
                                   'EMPLOYEE_LAST_NAME', EMP.EMPLOYEE_LAST_NAME,
                                   'EMPLOYEE_SUFFIX',EMP.EMPLOYEE_SUFFIX,
                                   'JOB_TITLE',EMP.JOB_TITLE
                                   ),
                'EMAIL_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_PERSONAL_EMAIL', EMP.EMPLOYEE_PERSONAL_EMAIL,
                                   'EMPLOYEE_WORK_EMAIL', EMP.EMPLOYEE_WORK_EMAIL                           
                                   ),
                'ADDRESS_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_ADDRESS1', EMP.EMPLOYEE_ADDRESS1,
                                   'EMPLOYEE_ADDRESS2', EMP.EMPLOYEE_ADDRESS2,
                                   'EMPLOYEE_CITY', EMP.EMPLOYEE_CITY,
                                   'EMPLOYEE_STATE_CODE', EMP.EMPLOYEE_STATE_CODE,
                                   'EMPLOYEE_ZIP', EMP.EMPLOYEE_ZIP
                                   ),--PHONE_DATA
                'PHONE_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_HOME_PHONE', EMP.EMPLOYEE_HOME_PHONE,
                                   'EMPLOYEE_CELL_PHONE', EMP.EMPLOYEE_CELL_PHONE,
                                   'EMPLOYEE_WORK_PHONE', EMP.EMPLOYEE_WORK_PHONE
                                   ),--JOB_DATA
                'JOB_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_ID', EMP.EMPLOYEE_ID ,
                                   'WORKDAY_INTERNAL_ID', NULL,
                                   'EMPLOYEE_TYPE', EMP.EMPLOYEE_TYPE,
                                   'EMPLOYEE_HIRE_DATE', EMP.EMPLOYEE_HIRE_DATE, 
                                   'DERIVED_EMPLOYEE_HIRE_DATE', EMP.DERIVED_EMPLOYEE_HIRE_DATE, 
                                   'EMPLOYEE_BENEFIT_START_DATE', EMP.EMPLOYEE_BENEFIT_START_DATE, 
                                   'EMPLOYEE_FIRST_CHECK_DATE', EMP.EMPLOYEE_FIRST_CHECK_DATE, 
                                   'JOB_TITLE', EMP.JOB_TITLE, 
                                   'WORK_STATE', EMP.WORK_STATE,
                                   'PRIMARY_BRANCH_NAME', EMP.PRIMARY_BRANCH_NAME,
                                   'PRIMARY_BRANCH_STATE', EMP.PRIMARY_BRANCH_STATE,
                                   'EMPLOYEE_CATEGORY', EMP.EMPLOYEE_CATEGORY ,
                                   'EMPLOYEE_TERMINATE_DATE', EMP.EMPLOYEE_TERMINATE_DATE,
                                   'DERIVED_EMPLOYEE_TERMINATE_DATE', EMP.DERIVED_EMPLOYEE_TERMINATE_DATE,
                                   'REASON_TO_TERMINATE', EMP.REASON_TO_TERMINATE,
                                   'ABLE_TO_REHIRE_FLAG', EMP.ABLE_TO_REHIRE_FLAG
                                   ),   
                'PERSONAL_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_MARITAL_STATUS', EMP.EMPLOYEE_MARITAL_STATUS, 
                                   'EMPLOYEE_ETHNICITY', EMP.EMPLOYEE_ETHNICITY, 
                                   'EMPLOYEE_DOB', EMP.EMPLOYEE_DOB, 
                                   'EMPLOYEE_DATE_OF_DEATH', EMP.EMPLOYEE_DATE_OF_DEATH, 
                                   'EMPLOYEE_GENDER', EMP.EMPLOYEE_GENDER
                                   )
            )  AS PAYROLL_METADATA,
            NULL AS APPLICANT_EMPLOYEE_KEY,
            NULL AS APPLICANT_SOURCE_SYSTEM_ID,
			NULL AS APPLICANT_SYSTEM_CODE,
			NULL AS APPLICANT_EMPLOYEE_ID,
            CASE 
              WHEN (AMS_EMPLOYEE_KEY IS NOT NULL AND PAYROLL_EMPLOYEE_KEY IS NOT NULL)
                OR (AMS_EMPLOYEE_KEY IS NULL AND EMP.EMPLOYEE_CATEGORY IN ('CORP','ADMIN'))
              THEN FALSE 
              ELSE TRUE 
            END AS EXCEPTION_FLAG,
            NULL AS AMS_PAYROLL_ID,
            EMP.EMPLOYEE_PID  AS EMPLOYEE_SSN
        FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_PAYROLL_MERGE_DEDUPE EMP 
        LEFT JOIN ACTIVE_PAYROLL_EMPLOYEE AS FP 
                ON FP.EMPLOYEE_KEY = EMP.ORIGINAL_EMPLOYEE_KEY
        LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_Branch_Merged AS BR
        ON COALESCE(EMP.PRIMARY_Branch_Key,FP.BRANCH_KEY) = br.original_Branch_Key
        LEFT JOIN APP_DB_${var.SF_ENVIRONMENT}.BROADSPIRE.VW_BROADSPIRE_WEEKLY_REPORT VI
        ON VI.EMPLOYEE_KEY = EMP.EMPLOYEE_KEY
        AND VI.BAD_DATA_FLAG = 0
        WHERE 
--            BR.Office_State_Code IN ('IN','PA','IL','MS','MO','AL','MI','GA','OH','DE','KY','TN','FL','SC')
			COALESCE(EMP.WORK_STATE, EMP.PRIMARY_BRANCH_STATE, BR.Office_State_Code) NOT IN ('NY', 'DC','FL')  
            AND EMP.EMPLOYEE_KEY NOT IN (SELECT DISTINCT PAYROLL_EMPLOYEE_KEY FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_AMS_PAYROLL_MAPPING ) 
--         -- Added on 22th nov to exclude across dups which were not identified at integration layer but falls in same cluster
			AND EMP.EMPLOYEE_KEY NOT IN (SELECT DISTINCT ID FROM ACROSS_DUPS_EXCLUDE WHERE SOURCE_SYSTEM = 'PAYROLL')
		--------------------------------------------------------
		---------- TEMPORARY CONDITION
		-- Added on 09.02.2024 to avoid non migrated GP records
			AND EMP.EMPLOYEE_KEY NOT IN 
				(SELECT EMPLOYEE_KEY 
				FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE 
				WHERE SOURCE_SYSTEM_ID = 36
				AND
					(PAYROLL_SOURCE_SYSTEM <> 'GREAT PLAINS'
					OR (PAYROLL_SOURCE_SYSTEM IS NULL AND PRIMARY_BRANCH_STATE NOT IN ('IL', 'MS', 'IN', 'MO'))
					))
------------------------------------------------------------------------------
-- ** TO get those AMS records which were not be able to mapped with any Payroll
-------------------------------------------------------------------------------
        union 
        SELECT DISTINCT 
        	EM.EMPLOYEE_FIRST_NAME FIRST_NAME, 
            EM.EMPLOYEE_LAST_NAME LAST_NAME, 
            COALESCE(BR.OFFICE_STATE_CODE, EM.WORK_STATE,EM.PRIMARY_BRANCH_STATE) AS BRANCH_STATE_CODE,
            NULL AS BROADSPIRE_ID,
            EM.EMPLOYEE_KEY AS AMS_EMPLOYEE_KEY, 
            EM.SOURCE_SYSTEM_ID AS AMS_SOURCE_SYSTEM_ID,
			EM.SYSTEM_CODE AS AMS_SYSTEM_CODE,
			EM.EMPLOYEE_ID  AS AMS_EMPLOYEE_ID,
			OBJECT_CONSTRUCT_KEEP_NULL
                (
               'NAME_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_FIRST_NAME', EM.EMPLOYEE_FIRST_NAME,
                                   'EMPLOYEE_MIDDLE_NAME', EM.EMPLOYEE_MIDDLE_NAME,
                                   'EMPLOYEE_LAST_NAME', EM.EMPLOYEE_LAST_NAME,
                                   'EMPLOYEE_SUFFIX',EM.EMPLOYEE_SUFFIX,
                                   'JOB_TITLE',EM.JOB_TITLE
                                   ),
                'EMAIL_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_PERSONAL_EMAIL', EM.EMPLOYEE_PERSONAL_EMAIL,
                                   'EMPLOYEE_WORK_EMAIL', EM.EMPLOYEE_WORK_EMAIL                           
                                   ),
                'ADDRESS_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_ADDRESS1', EM.EMPLOYEE_ADDRESS1,
                                   'EMPLOYEE_ADDRESS2', EM.EMPLOYEE_ADDRESS2,
                                   'EMPLOYEE_CITY', EM.EMPLOYEE_CITY,
                                   'EMPLOYEE_STATE_CODE', EM.EMPLOYEE_STATE_CODE,
                                   'EMPLOYEE_ZIP', EM.EMPLOYEE_ZIP
                                   ),--PHONE_DATA
                'PHONE_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_HOME_PHONE', EM.EMPLOYEE_HOME_PHONE,
                                   'EMPLOYEE_CELL_PHONE', EM.EMPLOYEE_CELL_PHONE,
                                   'EMPLOYEE_WORK_PHONE', EM.EMPLOYEE_WORK_PHONE
                                   ),--JOB_DATA
                'JOB_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_ID', EM.EMPLOYEE_ID ,
                                   'WORKDAY_INTERNAL_ID', NULL,
                                   'EMPLOYEE_TYPE', EM.EMPLOYEE_TYPE,
                                   'EMPLOYEE_HIRE_DATE', EM.EMPLOYEE_HIRE_DATE, 
                                   'DERIVED_EMPLOYEE_HIRE_DATE', EM.DERIVED_EMPLOYEE_HIRE_DATE, 
                                   'EMPLOYEE_BENEFIT_START_DATE', EM.EMPLOYEE_BENEFIT_START_DATE, 
                                   'EMPLOYEE_FIRST_CHECK_DATE', EM.EMPLOYEE_FIRST_CHECK_DATE, 
                                   'JOB_TITLE', EM.JOB_TITLE, 
                                   'WORK_STATE', EM.WORK_STATE, 
                                   'PRIMARY_BRANCH_NAME', EM.PRIMARY_BRANCH_NAME,
                                   'EMPLOYEE_CATEGORY', EM.EMPLOYEE_CATEGORY ,
                                   'EMPLOYEE_TERMINATE_DATE', EM.EMPLOYEE_TERMINATE_DATE ,
                                   'DERIVED_EMPLOYEE_TERMINATE_DATE', EM.DERIVED_EMPLOYEE_TERMINATE_DATE ,
                                   'REASON_TO_TERMINATE', EM.REASON_TO_TERMINATE,
                                   'ABLE_TO_REHIRE_FLAG', EM.ABLE_TO_REHIRE_FLAG
                                   ),   
                'PERSONAL_DATA', OBJECT_CONSTRUCT_KEEP_NULL
                                   (
                                   'EMPLOYEE_MARITAL_STATUS', EM.EMPLOYEE_MARITAL_STATUS, 
                                   'EMPLOYEE_ETHNICITY', EM.EMPLOYEE_ETHNICITY, 
                                   'EMPLOYEE_DOB', EM.EMPLOYEE_DOB, 
                                   'EMPLOYEE_DATE_OF_DEATH', EM.EMPLOYEE_DATE_OF_DEATH, 
                                   'EMPLOYEE_GENDER', EM.EMPLOYEE_GENDER
                                   )
           )  AS AMS_METADATA,
            NULL AS PAYROLL_EMPLOYEE_KEY,
            NULL AS PAYROLL_SOURCE_SYSTEM_ID,
			NULL AS PAYROLL_SYSTEM_CODE,
			NULL AS PAYROLL_EMPLOYEE_ID,
			NULL AS PAYROLL_METADATA,
            APP.APPLICANT_KEY AS APPLICANT_EMPLOYEE_KEY,
            APP.APPLICANT_SOURCE_SYSTEM_ID  AS APPLICANT_SOURCE_SYSTEM_ID,
			APP.APPLICANT_SYSTEM_CODE  AS APPLICANT_SYSTEM_CODE,
			APP.APPLICANT_ID AS APPLICANT_EMPLOYEE_ID,
            CASE 
              WHEN AMS_EMPLOYEE_KEY IS NOT NULL AND PAYROLL_EMPLOYEE_KEY IS NOT NULL 
              THEN FALSE 
              ELSE TRUE 
            END AS EXCEPTION_FLAG,
            EM.PAYROLL_ID AS AMS_PAYROLL_ID,
            EM.EMPLOYEE_PID AS EMPLOYEE_SSN
        FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_AMS_MERGED EM
        INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SOURCE_SYSTEM SS
                ON EM.SOURCE_SYSTEM_ID = SS.SOURCE_SYSTEM_ID AND SS.SOURCE_SYSTEM_TYPE = 'AMS'
        LEFT JOIN ACTIVE_VISIT_EMPLOYEE AS AE 
                ON AE.EMPLOYEE_KEY = EM.ORIGINAL_EMPLOYEE_KEY
        LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_Branch_Merged AS BR
                ON COALESCE(EM.PRIMARY_Branch_Key,AE.BRANCH_KEY) = br.original_Branch_Key
        LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.APPLICANT_WORKDAY_EMPLOYEE_MAPPING APP 
                ON EM.EMPLOYEE_KEY = APP.EMPLOYEE_KEY 
--        WHERE BR.Office_State_Code IN ('IN','PA','IL','MS','MO','AL','MI','GA','OH','DE','KY','TN','FL','SC') 
        --	AND EM.SOURCE_SYSTEM_ID <> 14 -- for ASR and Clearcare only in OH state
        WHERE EM.EMPLOYEE_KEY NOT IN (SELECT DISTINCT AMS_EMPLOYEE_KEY FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_AMS_PAYROLL_MAPPING)
	-- Added on 22th nov to exclude across dups which were not identified at integration layer but falls in same cluster
		AND EM.EMPLOYEE_KEY NOT IN (SELECT DISTINCT ID FROM ACROSS_DUPS_EXCLUDE WHERE SOURCE_SYSTEM = 'AMS')
------------------------------------------------------------------------------
-- ** TO get those Applicant records which were not be able to mapped with any AMS
-------------------------------------------------------------------------------
        union 
        SELECT DISTINCT 
        	APPLICANT.FIRST_NAME FIRST_NAME, 
            APPLICANT.LAST_NAME LAST_NAME, 
            APPLICANT.STATE_CODE AS BRANCH_STATE_CODE,
            NULL AS BROADSPIRE_ID,
            NULL AS AMS_EMPLOYEE_KEY,
            NULL AS AMS_SOURCE_SYSTEM_ID,
			NULL AS AMS_SYSTEM_CODE,
			NULL AS AMS_METADATA,
			NULL AS AMS_EMPLOYEE_ID,
            NULL AS PAYROLL_EMPLOYEE_KEY,
            NULL AS PAYROLL_SOURCE_SYSTEM_ID,
			NULL AS PAYROLL_SYSTEM_CODE,
			NULL AS PAYROLL_EMPLOYEE_ID,
			NULL AS PAYROLL_METADATA,
            STATUS.APPLICANT_KEY AS APPLICANT_EMPLOYEE_KEY,
            STATUS.SOURCE_SYSTEM_ID  AS APPLICANT_SOURCE_SYSTEM_ID,
			STATUS.SYSTEM_CODE AS APPLICANT_SYSTEM_CODE,
			APPLICANT.APPLICANT_ID AS APPLICANT_EMPLOYEE_ID,
            CASE 
              WHEN (AMS_EMPLOYEE_KEY IS NOT NULL AND PAYROLL_EMPLOYEE_KEY IS NOT NULL)
                --OR (AMS_EMPLOYEE_KEY IS NULL AND EMPLOYEE_CATEGORY IN ('CORP','ADMIN'))
              THEN FALSE 
              ELSE TRUE 
            END AS EXCEPTION_FLAG,
            NULL AS AMS_PAYROLL_ID,
            APPLICANT.SSN AS EMPLOYEE_SSN
        FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_APPLICANT_STATUS STATUS
        INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_APPLICANT APPLICANT
            ON STATUS.APPLICANT_KEY = APPLICANT.APPLICANT_KEY
        WHERE
            STATUS.HIRED_DATETIME IS NOT NULL
            AND STATUS.APPLICANT_KEY NOT IN ( SELECT DISTINCT APPLICANT_KEY FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.APPLICANT_WORKDAY_EMPLOYEE_MAPPING APP ) -- 3223
)
SELECT COALESCE((SELECT MAX(EMPLOYEE_ENTERPRISE_ID) FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK WHERE EMPLOYEE_ENTERPRISE_ID < 50000000),10000000)+ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS EMPLOYEE_ENTERPRISE_ID
		,*
FROM FINAL;
SQL
	or_replace = true 
	is_secure = false 
}

