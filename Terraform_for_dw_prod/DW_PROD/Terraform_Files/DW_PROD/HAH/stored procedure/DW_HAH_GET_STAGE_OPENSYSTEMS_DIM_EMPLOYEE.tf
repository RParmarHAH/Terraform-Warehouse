resource "snowflake_procedure" "DW_HAH_GET_STAGE_OPENSYSTEMS_DIM_EMPLOYEE" {
	name ="GET_STAGE_OPENSYSTEMS_DIM_EMPLOYEE"
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

Begin
--*****************************************************************************************************************************
-- NAME:  OPENSYSTEMS_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per EMPLOYEE according to OPENSYSTEM
--
-- DEVELOPMENT LOG:
-- DATE        	AUTHOR                	NOTES:
-- --------    	-------------------   	-----------------------------------------------------------------------------------------------
-- 11/09/2022	Jashvant Patel     		Initial development
-- 09/25/2023   Trushali Ramoliya       updated the logic for EMPLOYEE_PID 
-- 09/25/2023   Trushali Ramoliya       updated the logic for PHONE_NUMBER ALL THREE FIELDS, SUBTASK OF HHAX PHONE CLEANUP - IDDOX- 386 
-- 11/10/2023   Trushali Ramoliya       Added a logic for HISPANIC_OR_LATINO and update the logic for ethnicity as per ticket - IDDOX- 388.

--***************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.OPENSYSTEMS_DIM_EMPLOYEE
WITH CHECK_DATE AS 
(
	SELECT  CAREGIVERID
	       , TO_DATE(MIN(VISITDATE)) AS FIRST_CHECK_DATE
	       , TO_DATE(MAX(VISITDATE)) AS LAST_CHECK_DATE
	FROM  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.TBLVISITS_REPL

	GROUP BY 1
)
SELECT DISTINCT
	  MD5(''OPENSYSTEMS'' || ''-'' || EM.MASTER_ID  || ''-'' || ''HHAEXCHANGE'') AS EMPLOYEE_KEY
	, NVL(EM.CAREGIVERID, EM.MASTER_ID)  AS EMPLOYEE_ID
	, CONCAT(''OPENSYSTEMS - '', TRIM(O.STATE)) AS SYSTEM_CODE
	, 17 AS SOURCE_SYSTEM_ID
	, CASE WHEN TRIM(REPLACE(ssn, ''-'')) NOT IN (SELECT SSN FROM DATA_MANAGEMENT.DATA_QUALITY.INVALID_SSN) 
							AND NOT (REPLACE(ssn, ''-'') LIKE ANY (''666%'',''000%'',''9%'',''%0000'',''___00%''))
							AND LENGTH(TRIM(REPLACE(ssn, ''-'')))= 9 
							THEN HEX_ENCODE(TRIM(REPLACE(ssn, ''-'')))  
					   ELSE NULL 
				  END AS EMPLOYEE_PID
	, EM.CAREGIVERID AS EMPLOYEE_NUMBER
	, TO_DATE(EM.DATEOFBIRTH)  AS EMPLOYEE_DOB
	, NULL AS EMPLOYEE_DATE_OF_DEATH
	, TO_DATE(EM.HIREDATE)  AS EMPLOYEE_HIRE_DATE
	, TO_DATE(EM.REHIREDATE)  AS EMPLOYEE_REHIRE_DATE
	, NULL AS EMPLOYEE_BENEFIT_START_DATE
	, CD.FIRST_CHECK_DATE AS EMPLOYEE_FIRST_CHECK_DATE    --- MIN OF FIRST CHECK DATE FROM PAYROLL TABLE
	, CD.LAST_CHECK_DATE AS EMPLOYEE_LAST_CHECK_DATE      --- MAX OF FIRST CHECK DATE FROM PAYROLL TABLE
	, TO_DATE(EM.TERMINATEDDATE)  AS EMPLOYEE_LAST_WORKED_DATE
	, TO_DATE (EM.TERMINATEDDATE)  AS EMPLOYEE_TERMINATE_DATE
	, NULL AS REASON_TO_TERMINATE
	, CASE WHEN UPPER(TRIM(EM.STATUS)) =''ACTIVE'' THEN TRUE ELSE FALSE 
	  END AS ACTIVE_EMPLOYEE_FLAG
	, NULL AS ABLE_TO_REHIRE_FLAG
	, NULL AS EMPLOYEE_PREFIX
	, TRIM(UPPER(EM.FIRSTNAME))  AS EMPLOYEE_FIRST_NAME
	, TRIM(UPPER(EM.MIDDLENAME))  AS EMPLOYEE_MIDDLE_NAME
	, TRIM(UPPER(EM.LASTNAME))  AS EMPLOYEE_LAST_NAME
	, NULL AS EMPLOYEE_SUFFIX
	, TRIM(UPPER(EM.STREET1)) AS EMPLOYEE_ADDRESS1
	, TRIM(UPPER(EM.STREET2)) AS EMPLOYEE_ADDRESS2
	, TRIM(UPPER(EM.CITY)) AS EMPLOYEE_CITY
	, CASE WHEN UPPER(EM.STATE)= ''PENNSYLVANIA'' THEN ''PA''
		 WHEN UPPER(EM.STATE)= ''OHIO'' THEN ''OH''
	     ELSE UPPER(TRIM(EM.STATE)) 
	  END AS EMPLOYEE_STATE_CODE
	, COALESCE (TRIM(EM.ZIP5), TRIM(EM.ZIP4))  AS EMPLOYEE_ZIP
	, IFF(LENGTH(REGEXP_REPLACE(TRIM(EM.HOMEPHONE),''[^[:digit:]$]'')) = 10,REGEXP_REPLACE(TRIM(EM.HOMEPHONE),''[^[:digit:]$]''), NULL ) AS EMPLOYEE_HOME_PHONE,
 IFF(LENGTH(REGEXP_REPLACE(TRIM(EM.PHONE2),''[^[:digit:]$]'')) = 10,REGEXP_REPLACE(TRIM(EM.PHONE2),''[^[:digit:]$]''), NULL )  AS EMPLOYEE_CELL_PHONE,
	IFF(LENGTH(REGEXP_REPLACE(TRIM(EM.PHONE3),''[^[:digit:]$]'')) = 10,REGEXP_REPLACE(TRIM(EM.PHONE3),''[^[:digit:]$]''), NULL )  AS EMPLOYEE_WORK_PHONE
	, UPPER(EM.NOTIFICATIONEMAIL) AS EMPLOYEE_PERSONAL_EMAIL        
	, UPPER(EM.NOTIFICATIONEMAIL) AS EMPLOYEE_WORK_EMAIL             
	, NULL AS LINKED_IN_PROFILE_URL
	, UPPER(TRIM(EM.GENDER))  AS EMPLOYEE_GENDER
	,CASE WHEN TRIM(EM.ETHNICITY)= '''' THEN NULL 
	     WHEN  UPPER(TRIM(EM.ETHNICITY)) IN (''AMERICAN INDIAN'',''ALASKA NATIVE'') THEN ''AMERICAN INDIAN OR ALASKA NATIVE''
	     WHEN  UPPER(TRIM(EM.ETHNICITY)) IN (''AFRICAN AMERICAN'',''BLACK'') THEN ''BLACK OR AFRICAN AMERICAN''
	     WHEN  UPPER(TRIM(EM.ETHNICITY)) ILIKE ANY (''%LATINO%'',''%HISPANIC%'') THEN NULL
	     WHEN  UPPER(TRIM(EM.ETHNICITY)) IN (''NATIVE HAWAIIAN'',''PACIFIC ISLANDER'') THEN ''NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER''
				  WHEN TRIM(EM.ETHNICITY) = ''Two or More Races'' THEN UPPER(''Two or More'')
					  ELSE UPPER(TRIM(EM.ETHNICITY)) END AS EMPLOYEE_ETHNICITY 
    ,IFF(TRIM(EM.ETHNICITY) ILIKE ANY(''HISPANIC%'',''LATINO%'',''HISPANIC OR LATINO%''), TRUE, FALSE) AS HISPANIC_OR_LATINO
	, UPPER(TRIM(L."LANGUAGE"))  AS EMPLOYEE_LANGUAGE
	, CASE WHEN TRIM(UPPER(EM.MARITALSTATUS))=''S'' THEN ''SINGLE''
	       WHEN TRIM(UPPER(EM.MARITALSTATUS))=''M'' THEN ''MARRIED'' ELSE NULL 
	  END AS EMPLOYEE_MARITAL_STATUS
	, UPPER(TRIM(EM.EMPLOYEETYPE))  AS EMPLOYEE_TYPE
	, ''FIELD'' AS EMPLOYEE_CATEGORY     
	, NULL AS EXEMPT_FLAG
	, UPPER(TRIM(EM.EMPLOYEETYPE)) AS JOB_TITLE     
	, NULL AS JOB_DESCRIPTION      
	, NULL AS CLASS_ID
	, NULL AS WORKERS_COMP
	, EM.ALTERNATECAREGIVERCODE  AS PAYROLL_ID
	, NULL AS PERCENT_401K_DEDUCTION
	, NULL AS AMOUNT_401K_DEDUCTION
	, NULL AS JAZZHR_APPLICANT_ID
	, NULL AS JAZZHR_USER_ID
	, NULL AS JAZZHR_CONTACT_ID
	, UPPER(TRIM(O.STATE))  AS WORK_STATE        
	, NULL AS SUTA_STATE
	, NULL AS EMPLOYEE_DEPARTMENT        
	, UPPER(TRIM(O.OFFICECODE)) AS EMPLOYEE_OFFICE_CODE      
	, MD5(''OPENSYSTEMS'' || ''-'' || O.OFFICEID || ''-'' || ''HHAEXCHANGE'') AS BRANCH_KEY
	, UPPER(TRIM(O.STATE)) AS PRIMARY_BRANCH_STATE  
	, TRIM(UPPER(O.OFFICENAME)) AS PRIMARY_BRANCH_NAME 
	, CONCAT(''OPENSYSTEMS - '', TRIM(O.STATE))  AS PRIMARY_BRANCH_SYSTEM_CODE
	, NULL AS CASE_MANAGER_FLAG        
	, NULL AS SUPERVISOR_FLAG
	, NULL AS COORDINATOR_FLAG
	, TRIM(EM.ALTERNATECAREGIVERCODE) AS LINKED_ID
	, NULL AS SALARY
	, NULL AS PAY_RATE
	, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
	, TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
	, NULL AS MDM_DIM_EMPLOYEE_KEY
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY  
	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	, CURRENT_USER AS ETL_INSERTED_BY 
	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	, CURRENT_USER AS ETL_LAST_UPDATED_BY
	, 0 AS ETL_DELETED_FLAG
	, 0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.EMPLOYEE_MASTER_LIST EM
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.LANGUAGES L ON L.LANGUAGEID = EM.LANGUAGE1
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.OFFICE_OFFICES_REPL  O ON EM.OFFICEID = O.OFFICEID AND EM.AGENCYID = O.AGENCYID
LEFT JOIN CHECK_DATE CD ON CD.CAREGIVERID = EM.CAREGIVERID
WHERE TRIM(O.STATE) IN (''PA'',''DE'');
RETURN ''SUCCESS'';
end;

 EOT
}

