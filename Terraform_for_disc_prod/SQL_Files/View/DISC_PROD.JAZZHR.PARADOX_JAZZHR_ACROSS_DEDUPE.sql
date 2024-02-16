create or replace view DISC_PROD.JAZZHR.PARADOX_JAZZHR_ACROSS_DEDUPE(
	ID,
	SOURCE_SYSTEM_ID,
	SYSTEM_CODE,
	LAST_NAME,
	MIDDLE_NAME,
	FIRST_NAME,
	NAME,
	APPLICANT_ID,
	SSN,
	EMAIL,
	MOBILE_PHONE,
	PHONE,
	HOME_PHONE,
	DATE_OF_BIRTH,
	ADDRESS,
	ADDRESS_LINE_2,
	CITY,
	STATE,
	STATE_CODE,
	POSTAL,
	HIRED_DATE,
	REFERRER,
	CATEGORIES,
	REFERENCES,
	LINKEDIN,
	WEBSITE_BLOG_PORTFOLIO,
	TWITTER,
	EARLIEST_START_DATE,
	AVAILABLE_WEEKENDS,
	AVAILABLE_EVENINGS,
	AVAILABLE_OVERTIME,
	LANGUAGES,
	DRIVERS_LICENSE,
	COMMERCIAL_DRIVERS_LICENSE,
	CAN_RELOCATE,
	CITIZEN_EMPLOYMENT_STATUS,
	HIGHEST_EDUCATION,
	COLLEGE_UNIVERSITY,
	GRADE_POINT_AVG,
	AGE_18,
	PILOT_FLIGHT_HOURS,
	PILOT_GRADE_RATINGS,
	FELONY_CONVICTION,
	FELONY_EXPLANATION,
	EEO_CATEGORY,
	EEO_SEX,
	EEO_RACE,
	EEO_ETHNICITY,
	EEO_DISABILITY,
	EEOC_VETERAN_STATUS,
	EEOC_DISABILITY_STATUS,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
) as
with hire as (
select distinct APPLICANT_ID,max(HIRED_DATE) as HIRED_DATE  from DISC_DEV.JAZZHR.HIRES group by 1
) 
 select 
  TRIM(APPLICANT.APPLICANT_KEY) AS ID,
  TRIM(APPLICANT.SOURCE_SYSTEM_ID) AS SOURCE_SYSTEM_ID,
  TRIM(APPLICANT.SYSTEM_CODE) AS SYSTEM_CODE,
  TRIM(APPLICANT.LAST_NAME) AS LAST_NAME,
  TRIM(APPLICANT.MIDDLE_NAME) AS MIDDLE_NAME,
  TRIM(APPLICANT.FIRST_NAME) AS FIRST_NAME,
  TRIM(UPPER(REGEXP_REPLACE(APPLICANT.FIRST_NAME, '[^A-Za-z]', '')) || UPPER(REGEXP_REPLACE(APPLICANT.LAST_NAME, '[^A-Za-z]', '')))  AS NAME,
  TRIM(APPLICANT.APPLICANT_ID) AS APPLICANT_ID,
  TRIM(APPLICANT.SSN) AS SSN,
  TRIM(APPLICANT.EMAIL) AS EMAIL,
  TRIM(APPLICANT.MOBILE_PHONE) AS MOBILE_PHONE,
  TRIM(COALESCE(APPLICANT.MOBILE_PHONE,APPLICANT.HOME_PHONE)) AS PHONE ,
  TRIM(APPLICANT.HOME_PHONE) AS HOME_PHONE,
  TRIM(APPLICANT.DATE_OF_BIRTH) AS DATE_OF_BIRTH,
  TRIM(APPLICANT.ADDRESS) AS ADDRESS,
  TRIM(APPLICANT.ADDRESS_LINE_2) AS ADDRESS_LINE_2,
  TRIM(APPLICANT.CITY) AS CITY,
  TRIM(APPLICANT.STATE) AS STATE,
  TRIM(APPLICANT.STATE_CODE) AS STATE_CODE,
  TRIM(APPLICANT.POSTAL) AS POSTAL,
  TRIM(HIRES.HIRED_DATE) AS HIRED_DATE,
  TRIM(APPLICANT.REFERRER) AS REFERRER,
  TRIM(APPLICANT.CATEGORIES) AS CATEGORIES,
  TRIM(APPLICANT.REFERENCES) AS REFERENCES,
  TRIM(APPLICANT.LINKEDIN) AS LINKEDIN,
  TRIM(APPLICANT.WEBSITE_BLOG_PORTFOLIO) AS WEBSITE_BLOG_PORTFOLIO,
  TRIM(APPLICANT.TWITTER) AS TWITTER,
  TRIM(APPLICANT.EARLIEST_START_DATE) AS EARLIEST_START_DATE,
  TRIM(APPLICANT.AVAILABLE_WEEKENDS) AS AVAILABLE_WEEKENDS,
  TRIM(APPLICANT.AVAILABLE_EVENINGS) AS AVAILABLE_EVENINGS,
  TRIM(APPLICANT.AVAILABLE_OVERTIME) AS AVAILABLE_OVERTIME,
  TRIM(APPLICANT.LANGUAGES) AS LANGUAGES,
  TRIM(APPLICANT.DRIVERS_LICENSE) AS DRIVERS_LICENSE,
  TRIM(APPLICANT.COMMERCIAL_DRIVERS_LICENSE) AS COMMERCIAL_DRIVERS_LICENSE,
  TRIM(APPLICANT.CAN_RELOCATE) AS CAN_RELOCATE,
  TRIM(APPLICANT.CITIZEN_EMPLOYMENT_STATUS) AS CITIZEN_EMPLOYMENT_STATUS,
  TRIM(APPLICANT.HIGHEST_EDUCATION) AS HIGHEST_EDUCATION,
  TRIM(APPLICANT.COLLEGE_UNIVERSITY) AS COLLEGE_UNIVERSITY,
  TRIM(APPLICANT.GRADE_POINT_AVG) AS GRADE_POINT_AVG,
  TRIM(APPLICANT.AGE_18) AS AGE_18,
  TRIM(APPLICANT.PILOT_FLIGHT_HOURS) AS PILOT_FLIGHT_HOURS,
  TRIM(APPLICANT.PILOT_GRADE_RATINGS) AS PILOT_GRADE_RATINGS,
  TRIM(APPLICANT.FELONY_CONVICTION) AS FELONY_CONVICTION,
  TRIM(APPLICANT.FELONY_EXPLANATION) AS FELONY_EXPLANATION,
  TRIM(APPLICANT.EEO_CATEGORY) AS EEO_CATEGORY,
  TRIM(APPLICANT.EEO_SEX) AS EEO_SEX,
  TRIM(APPLICANT.EEO_RACE) AS EEO_RACE,
  TRIM(APPLICANT.EEO_ETHNICITY) AS EEO_ETHNICITY,
  TRIM(APPLICANT.EEO_DISABILITY) AS EEO_DISABILITY,
  TRIM(APPLICANT.EEOC_VETERAN_STATUS) AS EEOC_VETERAN_STATUS,
  TRIM(APPLICANT.EEOC_DISABILITY_STATUS) AS EEOC_DISABILITY_STATUS,
  TRIM(APPLICANT.ETL_TASK_KEY) AS ETL_TASK_KEY,
  TRIM(APPLICANT.ETL_INSERTED_TASK_KEY) AS ETL_INSERTED_TASK_KEY,
  TRIM(APPLICANT.ETL_INSERTED_DATE) AS ETL_INSERTED_DATE,
  TRIM(APPLICANT.ETL_INSERTED_BY) AS ETL_INSERTED_BY,
  TRIM(APPLICANT.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE,
  TRIM(APPLICANT.ETL_LAST_UPDATED_BY) AS ETL_LAST_UPDATED_BY,
  TRIM(APPLICANT.ETL_DELETED_FLAG) AS ETL_DELETED_FLAG
from DW_DEV.HAH.DIM_APPLICANT APPLICANT 
join hire HIRES on APPLICANT.APPLICANT_ID=hires.APPLICANT_ID
where applicant.SYSTEM_CODE = 'JAZZHR' and  hires.HIRED_DATE is not null    
UNION 
select
  TRIM(APPLICANT1.APPLICANT_KEY ) AS ID,
  TRIM(APPLICANT1.SOURCE_SYSTEM_ID) AS SOURCE_SYSTEM_ID,
  TRIM(APPLICANT1.SYSTEM_CODE) AS SYSTEM_CODE,
  TRIM(APPLICANT1.LAST_NAME) AS LAST_NAME,
  TRIM(APPLICANT1.MIDDLE_NAME) AS MIDDLE_NAME,
  TRIM(APPLICANT1.FIRST_NAME) AS FIRST_NAME,
  TRIM(UPPER(REGEXP_REPLACE(APPLICANT1.FIRST_NAME, '[^A-Za-z]', '')) || UPPER(REGEXP_REPLACE(APPLICANT1.LAST_NAME, '[^A-Za-z]', ''))) AS NAME,
  TRIM(APPLICANT1.APPLICANT_ID) AS APPLICANT_ID,
  TRIM(APPLICANT1.SSN) AS SSN,
  TRIM(APPLICANT1.EMAIL) AS EMAIL,
  TRIM(APPLICANT1.MOBILE_PHONE) AS MOBILE_PHONE,
  TRIM(COALESCE(APPLICANT1.MOBILE_PHONE,APPLICANT1.HOME_PHONE)) AS PHONE,
  TRIM(APPLICANT1.HOME_PHONE) AS HOME_PHONE,
  TRIM(APPLICANT1.DATE_OF_BIRTH) AS DATE_OF_BIRTH,
  TRIM(APPLICANT1.ADDRESS) AS ADDRESS,
  TRIM(APPLICANT1.ADDRESS_LINE_2) AS ADDRESS_LINE_2,
  TRIM(APPLICANT1.CITY) AS CITY,
  TRIM(APPLICANT1.STATE) AS STATE,
  TRIM(APPLICANT1.STATE_CODE) AS STATE_CODE,
  TRIM(APPLICANT1.POSTAL) AS POSTAL,
  TRIM(status.HIRED_DATETIME) AS HIRED_DATE,
  TRIM(APPLICANT1.REFERRER) AS REFERRER,
  TRIM(APPLICANT1.CATEGORIES) AS CATEGORIES,
  TRIM(APPLICANT1.REFERENCES) AS REFERENCES,
  TRIM(APPLICANT1.LINKEDIN) AS LINKEDIN,
  TRIM(APPLICANT1.WEBSITE_BLOG_PORTFOLIO) AS WEBSITE_BLOG_PORTFOLIO,
  TRIM(APPLICANT1.TWITTER) AS TWITTER,
  TRIM(APPLICANT1.EARLIEST_START_DATE) AS EARLIEST_START_DATE,
  TRIM(APPLICANT1.AVAILABLE_WEEKENDS) AS AVAILABLE_WEEKENDS,
  TRIM(APPLICANT1.AVAILABLE_EVENINGS) AS AVAILABLE_EVENINGS,
  TRIM(APPLICANT1.AVAILABLE_OVERTIME) AS AVAILABLE_OVERTIME,
  TRIM(APPLICANT1.LANGUAGES) AS LANGUAGES,
  TRIM(APPLICANT1.DRIVERS_LICENSE) AS DRIVERS_LICENSE,
  TRIM(APPLICANT1.COMMERCIAL_DRIVERS_LICENSE) AS COMMERCIAL_DRIVERS_LICENSE,
  TRIM(APPLICANT1.CAN_RELOCATE) AS CAN_RELOCATE,
  TRIM(APPLICANT1.CITIZEN_EMPLOYMENT_STATUS) AS CITIZEN_EMPLOYMENT_STATUS,
  TRIM(APPLICANT1.HIGHEST_EDUCATION) AS HIGHEST_EDUCATION,
  TRIM(APPLICANT1.COLLEGE_UNIVERSITY) AS COLLEGE_UNIVERSITY,
  TRIM(APPLICANT1.GRADE_POINT_AVG) AS GRADE_POINT_AVG,
  TRIM(APPLICANT1.AGE_18) AS AGE_18,
  TRIM(APPLICANT1.PILOT_FLIGHT_HOURS) AS PILOT_FLIGHT_HOURS,
  TRIM(APPLICANT1.PILOT_GRADE_RATINGS) AS PILOT_GRADE_RATINGS,
  TRIM(APPLICANT1.FELONY_CONVICTION) AS FELONY_CONVICTION,
  TRIM(APPLICANT1.FELONY_EXPLANATION) AS FELONY_EXPLANATION,
  TRIM(APPLICANT1.EEO_CATEGORY) AS EEO_CATEGORY,
  TRIM(APPLICANT1.EEO_SEX) AS EEO_SEX,
  TRIM(APPLICANT1.EEO_RACE) AS EEO_RACE,
  TRIM(APPLICANT1.EEO_ETHNICITY) AS EEO_ETHNICITY,
  TRIM(APPLICANT1.EEO_DISABILITY) AS EEO_DISABILITY,
  TRIM(APPLICANT1.EEOC_VETERAN_STATUS) AS EEOC_VETERAN_STATUS,
  TRIM(APPLICANT1.EEOC_DISABILITY_STATUS) AS EEOC_DISABILITY_STATUS,
  TRIM(APPLICANT1.ETL_TASK_KEY) AS ETL_TASK_KEY,
  TRIM(APPLICANT1.ETL_INSERTED_TASK_KEY) AS ETL_INSERTED_TASK_KEY,
  TRIM(APPLICANT1.ETL_INSERTED_DATE) AS ETL_INSERTED_DATE,
  TRIM(APPLICANT1.ETL_INSERTED_BY) AS ETL_INSERTED_BY,
  TRIM(APPLICANT1.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE,
  TRIM(APPLICANT1.ETL_LAST_UPDATED_BY) AS ETL_LAST_UPDATED_BY,
  TRIM(APPLICANT1.ETL_DELETED_FLAG) AS ETL_DELETED_FLAG  
from DW_PROD.HAH.DIM_APPLICANT APPLICANT1 
JOIN (select APPLICANT_KEY,max(HIRED_DATETIME) HIRED_DATETIME from DW_PROD.HAH.FACT_APPLICANT_STATUS group by 1) status ON APPLICANT1.applicant_key = status.applicant_key  
where APPLICANT1.SYSTEM_CODE = 'PARADOX' and HIRED_DATETIME is not null;