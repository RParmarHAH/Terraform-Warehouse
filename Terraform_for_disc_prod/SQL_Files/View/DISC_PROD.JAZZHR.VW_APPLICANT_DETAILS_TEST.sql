create or replace view DISC_PROD.JAZZHR.VW_APPLICANT_DETAILS_TEST(
	ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	ADDRESS,
	LOCATION,
	PHONE,
	LINKEDIN_URL,
	EEO_GENDER,
	EEO_RACE,
	EEO_DISABILITY,
	WEBSITE,
	DESIRED_SALARY,
	DESIRED_START_DATE,
	REFERRER,
	LANGUAGES,
	WMYU,
	HAS_DRIVER_LICENSE,
	WILLING_TO_RELOCATE,
	CITIZENSHIP_STATUS,
	EDUCATION_LEVEL,
	HAS_CDL,
	OVER_18,
	CAN_WORK_WEEKENDS,
	CAN_WORK_EVENINGS,
	CAN_WORK_OVERTIME,
	HAS_FELONY,
	FELONY_EXPLANATION,
	TWITTER_USERNAME,
	COLLEGE,
	REFERENCES,
	NOTES,
	APPLY_DATE,
	COMMENTS_COUNT,
	SOURCE,
	RECRUITER_ID,
	EEOC_VETERAN,
	EEOC_DISABILITY,
	EEOC_DISABILITY_SIGNATURE,
	EEOC_DISABILITY_DATE,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
) as (
	SELECT * FROM DISC_PROD.JAZZHR.APPLICANT_DETAILS AD 
WHERE ID NOT IN (SELECT ID FROM DISC_DEDUPE_PROD.JAZZHR.EMPLOYEE_DEDUPE_OUTPUT) 
AND ID IS NOT NULL 
UNION 
SELECT EML.MASTER_ID, AD.FIRST_NAME, AD.LAST_NAME, AD.EMAIL, AD.ADDRESS, AD.LOCATION, AD.PHONE, AD.LINKEDIN_URL, AD.EEO_GENDER, AD.EEO_RACE, AD.EEO_DISABILITY, AD.WEBSITE, AD.DESIRED_SALARY, AD.DESIRED_START_DATE, AD.REFERRER, AD.LANGUAGES, AD.WMYU, AD.HAS_DRIVER_LICENSE, AD.WILLING_TO_RELOCATE, AD.CITIZENSHIP_STATUS, AD.EDUCATION_LEVEL, AD.HAS_CDL, AD.OVER_18, AD.CAN_WORK_WEEKENDS, AD.CAN_WORK_EVENINGS, AD.CAN_WORK_OVERTIME, AD.HAS_FELONY, AD.FELONY_EXPLANATION, AD.TWITTER_USERNAME, AD.COLLEGE, AD.REFERENCES, AD.NOTES, AD.APPLY_DATE, AD.COMMENTS_COUNT, AD.SOURCE, AD.RECRUITER_ID, AD.EEOC_VETERAN, AD.EEOC_DISABILITY, AD.EEOC_DISABILITY_SIGNATURE, AD.EEOC_DISABILITY_DATE, AD.ETL_TASK_KEY, AD.ETL_INSERTED_TASK_KEY, AD.ETL_INSERTED_DATE, AD.ETL_INSERTED_BY, AD.ETL_LAST_UPDATED_DATE, AD.ETL_LAST_UPDATED_BY, AD.ETL_DELETED_FLAG 
FROM DISC_PROD.JAZZHR.APPLICANT_DETAILS AD 
INNER JOIN DISC_DEDUPE_PROD.JAZZHR.EMPLOYEE_MASTER_LIST EML ON AD.ID = EML.MASTER_ID 
WHERE AD.ID IS NOT NULL
);