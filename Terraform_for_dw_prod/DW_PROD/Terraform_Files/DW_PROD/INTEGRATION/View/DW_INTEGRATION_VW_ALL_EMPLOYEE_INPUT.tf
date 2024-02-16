resource "snowflake_view" "DW_INTEGRATION_VW_ALL_EMPLOYEE_INPUT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "VW_ALL_EMPLOYEE_INPUT"
	statement = <<-SQL
	  
  SELECT EMPLOYEE_KEY AS ID,SOURCE_SYSTEM_TYPE, RANDOM() AS SYSTEM_CODE,CASE WHEN EMPLOYEE_PID IS NULL OR trim(EMPLOYEE_PID)= '' THEN LEFT(random() ,32) ELSE EMPLOYEE_PID END AS SSN,coalesce(EMPLOYEE_FIRST_NAME||EMPLOYEE_LAST_NAME,randstr(4,random())) AS NAME,
  coalesce(STRTOK(EMPLOYEE_FIRST_NAME,'- ',1),randstr(4,random())) AS FIRST_NAME,
  coalesce(STRTOK(EMPLOYEE_LAST_NAME,'- ',1),randstr(4,random())) AS LAST_NAME,
  CASE WHEN EMPLOYEE_DOB is NULL OR trim(EMPLOYEE_DOB)='' THEN left(random() ,8)::varchar ELSE EMPLOYEE_DOB::varchar END AS DOB,CASE WHEN (EMPLOYEE_PERSONAL_EMAIL is NULL OR trim(EMPLOYEE_PERSONAL_EMAIL)='') AND (EMPLOYEE_WORK_EMAIL is NULL OR trim(EMPLOYEE_WORK_EMAIL)='') THEN randstr(10, random()) ELSE COALESCE(EMPLOYEE_PERSONAL_EMAIL,EMPLOYEE_WORK_EMAIL) END AS EMAIL,CASE WHEN COALESCE(EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE) IS NULL OR TRIM(COALESCE(EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE)) = '' THEN LEFT(random() ,32) ELSE COALESCE(EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE) END AS PHONE_NUMBER, CASE  WHEN EMPLOYEE_ADDRESS1 is NULL OR trim(EMPLOYEE_ADDRESS1)='' THEN randstr(5, random()) ELSE EMPLOYEE_ADDRESS1 END AS ADDRESS,CASE WHEN EMPLOYEE_CITY is NULL OR trim(EMPLOYEE_CITY)='' THEN randstr(5, random()) ELSE TRIM(UPPER(EMPLOYEE_CITY)) END AS CITY,CASE WHEN EMPLOYEE_STATE_CODE is NULL OR trim(EMPLOYEE_STATE_CODE)='' THEN randstr(5, random()) ELSE TRIM(UPPER(EMPLOYEE_STATE_CODE)) END AS STATE,
  CASE WHEN e.SYSTEM_CODE IN ('MS', 'OSHAH - MS')
     THEN CASE WHEN e.SYSTEM_CODE  = 'MS' 
               THEN 'MS-' || EMPLOYEE_ID 
               ELSE IFF(LINKED_ID IS NULL OR NULLIF(TRIM(LINKED_ID), '') IS NULL,RANDSTR(3,RANDOM()),'MS-' || LINKED_ID)
          END
     WHEN e.SYSTEM_CODE IN ('OPENSYSTEMS - PA', 'OSHAH - PA', '8485')
     THEN CASE WHEN e.SYSTEM_CODE = '8485' 
               THEN 'PA-' || EMPLOYEE_ID
               ELSE IFF(LINKED_ID IS NULL OR NULLIF(TRIM(LINKED_ID), '') IS NULL,RANDSTR(3,RANDOM()),'PA-' || LINKED_ID)
          END 
     WHEN e.sYSTEM_CODE IN ('OPENSYSTEMS - DE', 'OSHAH - DE') 
        THEN  IFF(LINKED_ID IS NULL OR NULLIF(TRIM(LINKED_ID), '') IS NULL,RANDSTR(3,RANDOM()), TRIM(LINKED_ID))
     ELSE RANDOM()::VARCHAR
     END AS  LINKED_ID  
  FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE E 
  INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SOURCE_SYSTEM S ON E.SOURCE_SYSTEM_ID = S.SOURCE_SYSTEM_ID  WHERE SOURCE_SYSTEM_TYPE IN ('AMS','Payroll','HCM');
SQL
	or_replace = true 
	is_secure = false 
}

