CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_JAZZHR_DIM_APPLICANT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
    MERGE INTO HAH.DIM_APPLICANT TGT 
USING STAGE.JAZZHR_DIM_APPLICANT STAGE 
ON TGT.APPLICANT_KEY = STAGE.APPLICANT_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.LAST_NAME= STAGE.LAST_NAME
   ,TGT.FIRST_NAME= STAGE.FIRST_NAME
   ,TGT.MIDDLE_NAME= STAGE.MIDDLE_NAME
   ,TGT.APPLICANT_ID= STAGE.APPLICANT_ID
   ,TGT.SSN= STAGE.SSN
   ,TGT.EMAIL= STAGE.EMAIL
   ,TGT.MOBILE_PHONE= STAGE.MOBILE_PHONE
   ,TGT.HOME_PHONE= STAGE.HOME_PHONE
   ,TGT.DATE_OF_BIRTH= STAGE.DATE_OF_BIRTH
   ,TGT.ADDRESS= STAGE.ADDRESS
   ,TGT.ADDRESS_LINE_2= STAGE.ADDRESS_LINE_2
   ,TGT.CITY= STAGE.CITY
   ,TGT.STATE= STAGE.STATE
   ,TGT.STATE_CODE= STAGE.STATE_CODE
   ,TGT.POSTAL= STAGE.POSTAL
   ,TGT.REFERRER= STAGE.REFERRER
   ,TGT.CATEGORIES= STAGE.CATEGORIES
   ,TGT.REFERENCES= STAGE.REFERENCES
   ,TGT.LINKEDIN= STAGE.LINKEDIN
   ,TGT.WEBSITE_BLOG_PORTFOLIO= STAGE.WEBSITE_BLOG_PORTFOLIO
   ,TGT.TWITTER= STAGE.TWITTER
   ,TGT.EARLIEST_START_DATE= STAGE.EARLIEST_START_DATE
   ,TGT.AVAILABLE_WEEKENDS= STAGE.AVAILABLE_WEEKENDS
   ,TGT.AVAILABLE_EVENINGS= STAGE.AVAILABLE_EVENINGS
   ,TGT.AVAILABLE_OVERTIME= STAGE.AVAILABLE_OVERTIME
   ,TGT.LANGUAGES= STAGE.LANGUAGES
   ,TGT.DRIVERS_LICENSE= STAGE.DRIVERS_LICENSE
   ,TGT.COMMERCIAL_DRIVERS_LICENSE= STAGE.COMMERCIAL_DRIVERS_LICENSE
   ,TGT.CAN_RELOCATE= STAGE.CAN_RELOCATE
   ,TGT.CITIZEN_EMPLOYMENT_STATUS= STAGE.CITIZEN_EMPLOYMENT_STATUS
   ,TGT.HIGHEST_EDUCATION= STAGE.HIGHEST_EDUCATION
   ,TGT.COLLEGE_UNIVERSITY= STAGE.COLLEGE_UNIVERSITY
   ,TGT.GRADE_POINT_AVG= STAGE.GRADE_POINT_AVG
   ,TGT.AGE_18= STAGE.AGE_18
   ,TGT.PILOT_FLIGHT_HOURS= STAGE.PILOT_FLIGHT_HOURS
   ,TGT.PILOT_GRADE_RATINGS= STAGE.PILOT_GRADE_RATINGS
   ,TGT.FELONY_CONVICTION= STAGE.FELONY_CONVICTION
   ,TGT.FELONY_EXPLANATION= STAGE.FELONY_EXPLANATION
   ,TGT.EEO_CATEGORY= STAGE.EEO_CATEGORY
   ,TGT.EEO_SEX= STAGE.EEO_SEX
   ,TGT.EEO_RACE= STAGE.EEO_RACE
   ,TGT.EEO_ETHNICITY= STAGE.EEO_ETHNICITY
   ,TGT.EEO_DISABILITY= STAGE.EEO_DISABILITY
   ,TGT.EEOC_VETERAN_STATUS= STAGE.EEOC_VETERAN_STATUS
   ,TGT.EEOC_DISABILITY_STATUS= STAGE.EEOC_DISABILITY_STATUS
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    APPLICANT_KEY
   ,SOURCE_SYSTEM_ID
   ,SYSTEM_CODE
   ,LAST_NAME
   ,FIRST_NAME
   ,MIDDLE_NAME
   ,APPLICANT_ID
   ,SSN
   ,EMAIL
   ,MOBILE_PHONE
   ,HOME_PHONE
   ,DATE_OF_BIRTH
   ,ADDRESS
   ,ADDRESS_LINE_2
   ,CITY
   ,STATE
   ,STATE_CODE
   ,POSTAL
   ,REFERRER
   ,CATEGORIES
   ,REFERENCES
   ,LINKEDIN
   ,WEBSITE_BLOG_PORTFOLIO
   ,TWITTER
   ,EARLIEST_START_DATE
   ,AVAILABLE_WEEKENDS
   ,AVAILABLE_EVENINGS
   ,AVAILABLE_OVERTIME
   ,LANGUAGES
   ,DRIVERS_LICENSE
   ,COMMERCIAL_DRIVERS_LICENSE
   ,CAN_RELOCATE
   ,CITIZEN_EMPLOYMENT_STATUS
   ,HIGHEST_EDUCATION
   ,COLLEGE_UNIVERSITY
   ,GRADE_POINT_AVG
   ,AGE_18
   ,PILOT_FLIGHT_HOURS
   ,PILOT_GRADE_RATINGS
   ,FELONY_CONVICTION
   ,FELONY_EXPLANATION
   ,EEO_CATEGORY
   ,EEO_SEX
   ,EEO_RACE
   ,EEO_ETHNICITY
   ,EEO_DISABILITY
   ,EEOC_VETERAN_STATUS
   ,EEOC_DISABILITY_STATUS
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
) 
VALUES (
    STAGE.APPLICANT_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SYSTEM_CODE
   ,STAGE.LAST_NAME
   ,STAGE.FIRST_NAME
   ,STAGE.MIDDLE_NAME
   ,STAGE.APPLICANT_ID
   ,STAGE.SSN
   ,STAGE.EMAIL
   ,STAGE.MOBILE_PHONE
   ,STAGE.HOME_PHONE
   ,STAGE.DATE_OF_BIRTH
   ,STAGE.ADDRESS
   ,STAGE.ADDRESS_LINE_2
   ,STAGE.CITY
   ,STAGE.STATE
   ,STAGE.STATE_CODE
   ,STAGE.POSTAL
   ,STAGE.REFERRER
   ,STAGE.CATEGORIES
   ,STAGE.REFERENCES
   ,STAGE.LINKEDIN
   ,STAGE.WEBSITE_BLOG_PORTFOLIO
   ,STAGE.TWITTER
   ,STAGE.EARLIEST_START_DATE
   ,STAGE.AVAILABLE_WEEKENDS
   ,STAGE.AVAILABLE_EVENINGS
   ,STAGE.AVAILABLE_OVERTIME
   ,STAGE.LANGUAGES
   ,STAGE.DRIVERS_LICENSE
   ,STAGE.COMMERCIAL_DRIVERS_LICENSE
   ,STAGE.CAN_RELOCATE
   ,STAGE.CITIZEN_EMPLOYMENT_STATUS
   ,STAGE.HIGHEST_EDUCATION
   ,STAGE.COLLEGE_UNIVERSITY
   ,STAGE.GRADE_POINT_AVG
   ,STAGE.AGE_18
   ,STAGE.PILOT_FLIGHT_HOURS
   ,STAGE.PILOT_GRADE_RATINGS
   ,STAGE.FELONY_CONVICTION
   ,STAGE.FELONY_EXPLANATION
   ,STAGE.EEO_CATEGORY
   ,STAGE.EEO_SEX
   ,STAGE.EEO_RACE
   ,STAGE.EEO_ETHNICITY
   ,STAGE.EEO_DISABILITY
   ,STAGE.EEOC_VETERAN_STATUS
   ,STAGE.EEOC_DISABILITY_STATUS
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
);

 SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted & '',"number of rows updated",'' Rows Updated. '') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
END;
    ';