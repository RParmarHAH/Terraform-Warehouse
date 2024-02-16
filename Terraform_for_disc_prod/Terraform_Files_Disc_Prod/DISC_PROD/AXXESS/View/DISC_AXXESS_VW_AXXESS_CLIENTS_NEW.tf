resource "snowflake_view" "DISC_AXXESS_VW_AXXESS_CLIENTS_NEW" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "VW_AXXESS_CLIENTS_NEW"
	statement = <<-SQL
	 
SELECT PATIENT_ID,
	MEDICAL_RECORD_NUMBER,
	LAST_NAME,
	FIRST_NAME,
	MIDDLE_INITIAL,
	SSN,
	DATE_OF_BIRTH,
	EMAIL,
	GENDER,
	ADDRESS,
	CITY,
	STATE,
	ZIP_CODE,
	REFERRAL_DATE,
	PHONE,
	EMERGENCY_CONTACT_PHONE,
	CASE_MANAGER_FIRST_NAME,
	CASE_MANAGER_LAST_NAME,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG,
	REVENUE_CATEGORY
FROM (	
select ROW_NUMBER() OVER (PARTITION BY PATIENT_ID ORDER BY MEDICAL_RECORD_NUMBER  DESC) AS RANK,*  from (
SELECT 
SYSTEM_ID AS PATIENT_ID
,MEDICAL_RECORD_NUMBER
,REPLACE(REPLACE(LAST_NAME,'"',''),$$\$$,'') LAST_NAME
,REPLACE(REPLACE(FIRST_NAME,'"',''),$$\$$,'') FIRST_NAME
,MIDDLE_INITIAL
,SSN
,DATE_OF_BIRTH
,EMAIL
,GENDER
,PRIMARY_ADDRESS_LINE_1 AS ADDRESS
,PRIMARY_ADDRESS_CITY AS CITY
,PRIMARY_ADDRESS_STATE AS STATE
,PRIMARY_ADDRESS_ZIP AS ZIP_CODE
,NULL AS REFERRAL_DATE
,PRIMARY_PHONE_NUMBER AS PHONE
,NULL AS EMERGENCY_CONTACT_PHONE
,NULL AS CASE_MANAGER_FIRST_NAME
,NULL AS CASE_MANAGER_LAST_NAME
,ETL_TASK_KEY
,ETL_INSERTED_TASK_KEY
,ETL_INSERTED_DATE
,ETL_INSERTED_BY
,ETL_LAST_UPDATED_DATE
,ETL_LAST_UPDATED_BY
,ETL_DELETED_FLAG
,'HH' AS REVENUE_CATEGORY
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HH_CLIENTINFO
WHERE PATIENT_ID IS NOT NULL
UNION ALL 
SELECT DISTINCT        
SYSTEM_ID AS PATIENT_ID 
,MEDICAL_RECORD_NUMBER AS MEDICAL_RECORD_NUMBER 
,LAST_NAME AS LAST_NAME      
,FIRST_NAME AS FIRST_NAME
,MIDDLE_INITIAL AS MIDDLE_INITIAL
,SSN      
,DATE_OF_BIRTH AS DATE_OF_BIRTH
,EMAIL
,GENDER AS GENDER
,PRIMARY_ADDRESS_LINE_1 AS ADDRESS
,PRIMARY_ADDRESS_CITY AS CITY            
,PRIMARY_ADDRESS_STATE AS STATE
,PRIMARY_ADDRESS_ZIP AS ZIP_CODE
,NULL AS REFERRAL_DATE
,PRIMARY_PHONE_NUMBER AS PHONE     
,NULL AS EMERGENCY_CONTACT_PHONE
,NULL AS CASE_MANAGER_FIRST_NAME
,NULL AS CASE_MANAGER_LAST_NAME 
,ETL_TASK_KEY
,ETL_INSERTED_TASK_KEY
,ETL_INSERTED_DATE      
,ETL_INSERTED_BY   
,ETL_LAST_UPDATED_DATE  
,ETL_LAST_UPDATED_BY
,ETL_DELETED_FLAG
,'HC' AS REVENUE_CATEGORY
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HC_CLIENTINFO
WHERE PATIENT_ID IS NOT NULL
)QUALIFY RANK = 1)t;
SQL
	or_replace = true 
	is_secure = false 
}

