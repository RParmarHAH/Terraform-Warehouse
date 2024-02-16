CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_VIVENTIUM_DIM_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '

BEGIN

--*****************************************************************************************************************************
-- NAME: VIVENTIUM_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per employee_id/database according to Viventium
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 07/27/23		Meet Dalwadi		 Initial Development
-- 11/10/2023  Deepen Gajjar         Added a column for HISPANIC_OR_LATINO for ethnicity as per ticket - IDDOX- 388.
-- 12/13/2023	Saurav Purohit		 Added Acquired system column
--*****************************************************************************************************************************



INSERT OVERWRITE INTO dw_prod.STAGE.viventium_dim_employee 
with checkdate as (
select companycode,employeekey,employeenumber ,min(checkdate) as EMPLOYEE_FIRST_CHECK_DATE
,max(checkdate) as EMPLOYEE_LAST_CHECK_DATE
 from disc_prod.viventium.exportchecks
group by companycode,employeekey,employeenumber
)
select DISTINCT
MD5(EM.COMPANYCODE ||''-'' ||trim(EM.MASTER_ID) || ''-'' ||''VIVENTIUM'') as EMPLOYEE_KEY,
trim(EM.employeeNumber) as EMPLOYEE_ID,
EM.COMPANYCODE as SYSTEM_CODE,
34 as SOURCE_SYSTEM_ID ,
	CASE WHEN 
		TRIM(REGEXP_REPLACE(EM.SSN,''\\\\-|\\\\(|\\\\)|\\\\ '','''')) NOT IN (SELECT SSN FROM DATA_MANAGEMENT.DATA_QUALITY.INVALID_SSN) 
		AND TRIM(REGEXP_REPLACE(EM.SSN,''\\\\-|\\\\(|\\\\)|\\\\ '','''')) NOT LIKE ''00000%''
		AND LENGTH(TRIM(REGEXP_REPLACE(EM.SSN,''\\\\-|\\\\(|\\\\)|\\\\ '','''')))=9 
		THEN HEX_ENCODE(TRIM(REGEXP_REPLACE(EM.SSN,''\\\\-|\\\\(|\\\\)|\\\\ '','''')))
	END AS EMPLOYEE_PID,
TRY_CAST(EM.EMPLOYEENUMBER AS NUMBER) as EMPLOYEE_NUMBER,
EM.dateOfBirth as EMPLOYEE_DOB,
null as EMPLOYEE_DATE_OF_DEATH,
EM.hireDate as EMPLOYEE_HIRE_DATE,
EM.rehireDate as EMPLOYEE_REHIRE_DATE,
TO_DATE(EM.benefitCategoryStartDate) as EMPLOYEE_BENEFIT_START_DATE ,
CD.EMPLOYEE_FIRST_CHECK_DATE as EMPLOYEE_FIRST_CHECK_DATE,
COALESCE(CD.EMPLOYEE_LAST_CHECK_DATE,EM.LASTCHECKDATE)  as EMPLOYEE_LAST_CHECK_DATE,
EM.terminationDate as EMPLOYEE_LAST_WORKED_DATE,
EM.terminationDate as EMPLOYEE_TERMINATE_DATE,
EM.terminationReason as REASON_TO_TERMINATE,
CASE WHEN EM.EMPLOYEESTATUS = ''Active'' OR EM.EMPLOYEESTATUSCODE = ''A'' OR LEFT(EM.EMPLOYEESTATUS,1) IN (''a'',''A'') THEN True ELSE False END AS ACTIVE_EMPLOYEE_FLAG ,
CASE WHEN EM.notEligibleForRehire = ''false'' THEN True ELSE False END as able_to_rehire_flag ,
null as EMPLOYEE_PREFIX ,
UPPER(TRIM(EM.firstName)) as EMPLOYEE_FIRST_NAME,
UPPER(TRIM(EM.middleInitial)) as EMPLOYEE_MIDDLE_NAME,
UPPER(TRIM(EM.lastName)) as EMPLOYEE_LAST_NAME,
null as Employee_Suffix,
CASE WHEN EM.addressLine1 <> '''' AND EM.addressLine1 IS NOT NULL THEN UPPER(TRIM(EM.addressLine1)) ELSE NULL END AS Employee_Address1 ,
CASE WHEN EM.addressLine2 <> '''' AND EM.addressLine2 IS NOT NULL THEN UPPER(TRIM(EM.addressLine2)) ELSE NULL END AS Employee_Address2 ,
CASE WHEN EM.city <> '''' AND EM.city IS NOT NULL THEN UPPER(TRIM(EM.city)) ELSE NULL END AS Employee_City,
EM.state as EMPLOYEE_STATE_CODE,
EM.zipCode as Employee_Zip,
CASE WHEN LENGTH(TRIM(REGEXP_REPLACE(EM.homePhone,''[^\\\\d]*'','''')))=10 THEN TRIM(REGEXP_REPLACE(EM.homePhone,''[^\\\\d]*'',''''))
	ELSE NULL END AS Employee_Home_Phone ,
CASE WHEN LENGTH(TRIM(REGEXP_REPLACE(EM.mobilePhone,''[^\\\\d]*'','''')))=10 THEN TRIM(REGEXP_REPLACE(EM.mobilePhone,''[^\\\\d]*'',''''))
	ELSE NULL END AS Employee_Cell_Phone,
CASE WHEN LENGTH(TRIM(REGEXP_REPLACE(EM.workPhone,''[^\\\\d]*'','''')))=10 THEN TRIM(REGEXP_REPLACE(EM.workPhone,''[^\\\\d]*'',''''))
	ELSE NULL END AS Employee_Work_Phone,
EM.email as Employee_Personal_Email,
EM.email as Employee_Work_Email,
null as Linked_In_Profile_URL,
CASE WHEN UPPER(EM.gender) NOT IN (''MALE'',''FEMALE'') THEN ''N/A''
ELSE UPPER(EM.gender) END as Employee_Gender,
null as Employee_Ethnicity,
FALSE AS HISPANIC_OR_LATINO,
CASE WHEN EM.primaryLanguage = ''en'' THEN ''ENGLISH'' ELSE EM.primaryLanguage END as EMPLOYEE_LANGUAGE,
null as EMPLOYEE_MARITAL_STATUS,
case when UPPER(EM.FULLORPARTTIME) = ''PERDIEM''  THEN ''FullTime'' 
WHEN UPPER(EM.FULLORPARTTIME) = ''PRN'' THEN ''PartTime''
else EM.FULLORPARTTIME end as EMPLOYEE_TYPE,--ASK perDiem
CASE WHEN c.value:costCenterCode = ''101'' or c.value:costCenterCode = ''001'' THEN ''ADMIN''
ELSE ''FIELD''
END as EMPLOYEE_CATEGORY,--ASK
null as EXEMPT_FLAG,
EM.jobTitle as JOB_TITLE,
EM.jobDescription as JOB_DESCRIPTION,
null as CLASS_ID,
EM.workersCompCode as WORKERS_COMP,
TRIM(EM.EMPLOYEENUMBER) as PAYROLL_ID,
null as PERCENT_401K_DEDUCTION,
null as AMOUNT_401K_DEDUCTION,
null as JAZZHR_APPLICANT_ID,
null as JAZZHR_USER_ID,
null as JAZZHR_CONTACT_ID,
''FL'' as WORK_STATE,
''FL'' as SUTA_STATE,
null as EMPLOYEE_DEPARTMENT,
EM.divisionCode as EMPLOYEE_OFFICE_CODE,
MD5( BR.SYSTEM_CODE || ''-'' || BR.OFFICE_NAME || ''-'' || ''VIVENTIUM'') as PRIMARY_BRANCH_KEY,
''FL'' as PRIMARY_BRANCH_STATE,
BR.OFFICE_NAME as PRIMARY_BRANCH_NAME,
BR.SYSTEM_CODE as PRIMARY_BRANCH_SYSTEM_CODE,
null as CASE_MANAGER_FLAG,
EM.isASupervisor as SUPERVISOR_FLAG,
null as COORDINATOR_FLAG,
CASE WHEN UPPER(EM.PAYTYPE) = ''HOURLY'' THEN EM.BASERATE*52*40 
WHEN UPPER(EM.PAYTYPE) = ''DAILY'' THEN EM.BASERATE*52*5 
WHEN UPPER(EM.PAYTYPE) = ''SALARY'' THEN EM.BASERATE END as SALARY ,
EM.BASERATE as PAY_RATE,
IFF( EM.rehireDate IS NULL, IFF( EM.hireDate IS NULL, CAST( ''1900-01-01'' AS DATE), EM.hireDate ), EM.rehireDate)  as EFFECTIVE_FROM_DATE,
IFF( EM.terminationDate IS NULL, CAST( ''2070-12-31'' AS DATE), EM.terminationDate)  as EFFECTIVE_TO_DATE,
null as MDM_DIM_EMPLOYEE_KEY,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
			:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
			CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY ,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	0 AS ETL_DELETED_FLAG,
	0 AS ETL_INFERRED_MEMBER_FLAG,
   ''PREFERRED'' as ACQUIRED_SYSTEM
from DISC_DEDUPE_PROD.VIVENTIUM.EMPLOYEE_MASTER_LIST  EM left join checkdate CD on CD.EMPLOYEENUMBER = EM.EMPLOYEENUMBER and CD.employeekey = EM.employeekey and CD.companycode = EM.companycode
left join dw_prod.hah.dim_branch BR on EM.COMPANYCODE  = BR.SYSTEM_CODE ,
LATERAL flatten(INPUT => EM.costCenters::variant ,OUTER => True) c ;

RETURN ''Success'';

END;
';