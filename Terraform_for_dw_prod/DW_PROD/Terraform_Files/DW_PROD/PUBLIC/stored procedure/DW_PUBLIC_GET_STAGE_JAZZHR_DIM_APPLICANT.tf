resource "snowflake_procedure" "DW_PUBLIC_GET_STAGE_JAZZHR_DIM_APPLICANT" {
	name ="GET_STAGE_JAZZHR_DIM_APPLICANT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

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

        var sql = `
--*****************************************************************************************************************************
-- NAME:  DIM_APPLICANT_JAZZHR
--
-- PURPOSE: Creates one row per DIM_APPLICANT from JAZZHR
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR                        NOTES:
-- ----------   -------------------          ---------------------------------------------------------------------------
-- 05/08/2022   Aditya Shukla/Rutvi Vyas     Initial development
-- 05/09/2022   Hasnain Motagamwala          Leveraged VW_APPLICANT_DETAILS created from recordlinkage to populate DIM_APPLICANT
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.JAZZHR_DIM_APPLICANT
SELECT
    DISTINCT
    MD5(TRIM(NVL(AD.ID, ''UNKNOWN'')) || ''-'' || ''JAZZHR'') AS APPLICANT_KEY,
    20 AS SOURCE_SYSTEM_ID,
    ''JAZZHR'' AS SYSTEM_CODE,
    AD.LAST_NAME AS LAST_NAME,
    AD.FIRST_NAME AS FIRST_NAME,
    NULL AS MIDDLE_NAME,
    AD.ID AS APPLICANT_ID,
    NULL AS SSN,
    TRIM(AD.EMAIL) AS EMAIL,
    TRIM(AD.PHONE) AS MOBILE_PHONE,
    NULL AS HOME_PHONE,
    NULL AS DATE_OF_BIRTH,
    AD.ADDRESS AS ADDRESS,
    AD."LOCATION" AS ADDRESS_LINE_2,
    NULL AS CITY,
    CASE WHEN UPPER(AD."LOCATION") LIKE ''%ILLINOIS%'' OR UPPER(AD."LOCATION") LIKE ''% IL %'' THEN ''IL'' 
        WHEN UPPER(AD."LOCATION") LIKE ''%GEORGIA%'' OR UPPER(AD."LOCATION") LIKE ''% GA %'' THEN ''GA''
        WHEN UPPER(AD."LOCATION") LIKE ''%CHICAGO%'' THEN ''IL''
        WHEN UPPER(AD."LOCATION") LIKE ''%NEW YORK%'' OR UPPER(AD."LOCATION") LIKE ''% NY %'' THEN ''NY''
        WHEN UPPER(AD."LOCATION") LIKE ''%MICHIGAN%'' OR UPPER(AD."LOCATION") LIKE ''% MI %'' THEN ''MI''
        WHEN UPPER(AD."LOCATION") LIKE  ''%MISSISSIPPI%''OR UPPER(AD."LOCATION") LIKE ''% MS %''THEN ''MS''
        WHEN UPPER(AD."LOCATION") LIKE ''%ALABAMA%'' OR UPPER(AD."LOCATION") LIKE ''% AL %''THEN ''AL''
        WHEN UPPER(AD."LOCATION") LIKE ''%KENTUCKY%'' OR UPPER(AD."LOCATION") LIKE ''% KY %''THEN ''KY''
        WHEN UPPER(AD."LOCATION") LIKE ''%MISSOURI%'' OR UPPER(AD."LOCATION") LIKE ''% MO %''THEN ''MO''
        WHEN UPPER(AD."LOCATION") LIKE ''%IOWA%'' OR UPPER(AD."LOCATION") LIKE ''% IA %''THEN ''IA''
        WHEN UPPER(AD."LOCATION") LIKE ''%NEW JERSEY%'' OR UPPER(AD."LOCATION") LIKE ''% NJ %''THEN ''NJ''
        WHEN UPPER(AD."LOCATION") LIKE ''%WISCONSIN%'' OR UPPER(AD."LOCATION") LIKE ''% WI %''THEN ''WI''
        WHEN UPPER(AD."LOCATION") LIKE ''%PENNSYLVANIA%'' OR UPPER(AD."LOCATION") LIKE ''% PA %''THEN ''PA''
        WHEN UPPER(AD."LOCATION") LIKE ''%ARIZONA%'' OR UPPER(AD."LOCATION") LIKE ''% AZ %''THEN ''AZ''
        WHEN UPPER(AD."LOCATION") LIKE ''%FLORIDA%'' OR UPPER(AD."LOCATION") LIKE ''% FL %''THEN ''FL''
        WHEN UPPER(AD."LOCATION") LIKE ''%WISCONSIN%'' OR UPPER(AD."LOCATION") LIKE ''% WI %''THEN ''WI''
        WHEN UPPER(AD."LOCATION") LIKE ''%TEXAS%'' OR UPPER(AD."LOCATION") LIKE ''% TX %''THEN ''TX''
        WHEN UPPER(AD."LOCATION") LIKE ''%CALIFORNIA%'' OR UPPER(AD."LOCATION") LIKE ''% CA %''THEN ''CA''
        WHEN UPPER(AD."LOCATION") LIKE ''%INDIANA%'' OR UPPER(AD."LOCATION") LIKE ''% IN %''THEN ''IN''
        WHEN UPPER(AD."LOCATION") LIKE ''%VIRGINIA%'' OR UPPER(AD."LOCATION") LIKE ''% VA %''THEN ''VA''
        ELSE NULL 
    END AS STATE,
    CASE WHEN UPPER(AD."LOCATION") LIKE ''%ILLINOIS%'' OR UPPER(AD."LOCATION") LIKE ''% IL %'' THEN ''IL'' 
        WHEN UPPER(AD."LOCATION") LIKE ''%GEORGIA%'' OR UPPER(AD."LOCATION") LIKE ''% GA %'' THEN ''GA''
        WHEN UPPER(AD."LOCATION") LIKE ''%CHICAGO%'' THEN ''IL''
        WHEN UPPER(AD."LOCATION") LIKE ''%NEW YORK%'' OR UPPER(AD."LOCATION") LIKE ''% NY %'' THEN ''NY''
        WHEN UPPER(AD."LOCATION") LIKE ''%MICHIGAN%'' OR UPPER(AD."LOCATION") LIKE ''% MI %'' THEN ''MI''
        WHEN UPPER(AD."LOCATION") LIKE  ''%MISSISSIPPI%''OR UPPER(AD."LOCATION") LIKE ''% MS %''THEN ''MS''
        WHEN UPPER(AD."LOCATION") LIKE ''%ALABAMA%'' OR UPPER(AD."LOCATION") LIKE ''% AL %''THEN ''AL''
        WHEN UPPER(AD."LOCATION") LIKE ''%KENTUCKY%'' OR UPPER(AD."LOCATION") LIKE ''% KY %''THEN ''KY''
        WHEN UPPER(AD."LOCATION") LIKE ''%MISSOURI%'' OR UPPER(AD."LOCATION") LIKE ''% MO %''THEN ''MO''
        WHEN UPPER(AD."LOCATION") LIKE ''%IOWA%'' OR UPPER(AD."LOCATION") LIKE ''% IA %''THEN ''IA''
        WHEN UPPER(AD."LOCATION") LIKE ''%NEW JERSEY%'' OR UPPER(AD."LOCATION") LIKE ''% NJ %''THEN ''NJ''
        WHEN UPPER(AD."LOCATION") LIKE ''%WISCONSIN%'' OR UPPER(AD."LOCATION") LIKE ''% WI %''THEN ''WI''
        WHEN UPPER(AD."LOCATION") LIKE ''%PENNSYLVANIA%'' OR UPPER(AD."LOCATION") LIKE ''% PA %''THEN ''PA''
        WHEN UPPER(AD."LOCATION") LIKE ''%ARIZONA%'' OR UPPER(AD."LOCATION") LIKE ''% AZ %''THEN ''AZ''
        WHEN UPPER(AD."LOCATION") LIKE ''%FLORIDA%'' OR UPPER(AD."LOCATION") LIKE ''% FL %''THEN ''FL''
        WHEN UPPER(AD."LOCATION") LIKE ''%WISCONSIN%'' OR UPPER(AD."LOCATION") LIKE ''% WI %''THEN ''WI''
        WHEN UPPER(AD."LOCATION") LIKE ''%TEXAS%'' OR UPPER(AD."LOCATION") LIKE ''% TX %''THEN ''TX''
        WHEN UPPER(AD."LOCATION") LIKE ''%CALIFORNIA%'' OR UPPER(AD."LOCATION") LIKE ''% CA %''THEN ''CA''
        WHEN UPPER(AD."LOCATION") LIKE ''%INDIANA%'' OR UPPER(AD."LOCATION") LIKE ''% IN %''THEN ''IN''
        WHEN UPPER(AD."LOCATION") LIKE ''%VIRGINIA%'' OR UPPER(AD."LOCATION") LIKE ''% VA %''THEN ''VA''
        ELSE NULL
    END AS STATE_CODE,
    CASE 
        WHEN RIGHT(UPPER(AD."LOCATION"), 5) BETWEEN ''0'' AND ''9'' 
        THEN RIGHT(UPPER(AD."LOCATION"), 5) 
        ELSE NULL 
    END AS POSTAL,
    CASE WHEN AD.REFERRER = '''' THEN NULL ELSE AD.REFERRER END AS REFERRER,
    NULL AS CATEGORIES,
    CASE WHEN AD."REFERENCES" = '''' THEN NULL ELSE AD."REFERENCES" END AS REFERENCES,
    CASE WHEN AD.LINKEDIN_URL = '''' THEN NULL ELSE AD.LINKEDIN_URL END AS LINKEDIN,
    CASE WHEN AD.WEBSITE = '''' THEN NULL ELSE AD.WEBSITE END AS WEBSITE_BLOG_PORTFOLIO,
    CASE WHEN AD.TWITTER_USERNAME = '''' THEN NULL ELSE AD.TWITTER_USERNAME END AS TWITTER,
    CASE WHEN AD.DESIRED_START_DATE = '''' THEN NULL ELSE AD.DESIRED_START_DATE END AS EARLIEST_START_DATE,
    CASE WHEN AD.CAN_WORK_WEEKENDS = ''No answer'' THEN NULL ELSE AD.CAN_WORK_WEEKENDS END AS AVAILABLE_WEEKENDS,
    CASE WHEN AD.CAN_WORK_EVENINGS = ''No answer'' THEN NULL ELSE AD.CAN_WORK_EVENINGS END AS AVAILABLE_EVENINGS,
    CASE WHEN AD.CAN_WORK_OVERTIME = ''No answer'' THEN NULL ELSE AD.CAN_WORK_OVERTIME END AS AVAILABLE_OVERTIME,
    CASE WHEN AD.LANGUAGES = '''' THEN NULL ELSE AD.LANGUAGES END AS LANGUAGES,
    CASE WHEN AD.HAS_DRIVER_LICENSE = ''No answer'' THEN NULL ELSE AD.HAS_DRIVER_LICENSE END AS DRIVERS_LICENSE,
    NULL AS COMMERCIAL_DRIVERS_LICENSE,
    CASE WHEN AD.WILLING_TO_RELOCATE = ''No answer'' THEN NULL ELSE AD.WILLING_TO_RELOCATE END AS CAN_RELOCATE,
    CASE WHEN AD.CITIZENSHIP_STATUS = ''No answer'' THEN NULL ELSE AD.CITIZENSHIP_STATUS END AS CITIZEN_EMPLOYMENT_STATUS,
    CASE WHEN AD.EDUCATION_LEVEL = ''No answer'' THEN NULL ELSE AD.EDUCATION_LEVEL END AS HIGHEST_EDUCATION,
    CASE WHEN AD.COLLEGE = '''' THEN NULL ELSE AD.COLLEGE END AS COLLEGE_UNIVERSITY,
    NULL AS GRADE_POINT_AVG,
    CASE WHEN AD.OVER_18 = ''No answer'' THEN NULL ELSE AD.OVER_18 END AS AGE_18,
    NULL AS PILOT_FLIGHT_HOURS,
    NULL AS PILOT_GRADE_RATINGS,
    CASE WHEN AD.HAS_FELONY = ''No answer'' THEN NULL ELSE AD.HAS_FELONY END AS FELONY_CONVICTION,
    CASE WHEN AD.FELONY_EXPLANATION = '''' THEN NULL ELSE AD.FELONY_EXPLANATION END AS FELONY_EXPLANATION,
    NULL AS EEO_CATEGORY,
    CASE WHEN AD.EEO_GENDER = ''Decline to answer'' THEN NULL ELSE AD.EEO_GENDER END AS EEO_SEX,
    CASE WHEN AD.EEO_RACE = ''Decline to answer'' THEN NULL ELSE AD.EEO_RACE END AS EEO_RACE,
    NULL AS EEO_ETHNICITY,
    CASE WHEN AD.EEO_DISABILITY = ''Decline to answer'' THEN NULL ELSE AD.EEO_DISABILITY END AS EEO_DISABILITY,
    CASE WHEN AD.EEOC_VETERAN = ''No answer'' THEN NULL ELSE AD.EEOC_VETERAN END AS EEOC_VETERAN_STATUS,
    CASE WHEN AD.EEOC_DISABILITY = ''I DON�T WISH TO ANSWER'' THEN NULL ELSE AD.EEOC_DISABILITY END AS EEOC_DISABILITY_STATUS,
    `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
     `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE,
    CURRENT_USER AS ETL_INSERTED_BY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_LAST_UPDATED_DATE,
    CURRENT_USER AS ETL_LAST_UPDATED_BY,
    FALSE AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.JAZZHR.APPLICANT_DETAILS AD
INNER JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.JAZZHR.EMPLOYEE_MASTER_LIST M ON AD.ID = M.ID
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          
 EOT
}

