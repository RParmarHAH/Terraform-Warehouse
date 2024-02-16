CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_MASTER_FACT_AMS_PAYROLL_MAPPING()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN
--*****************************************************************************************************************************
-- NAME:  _AMS_PAYROLL_MAPPING
--
-- PURPOSE: Populates MAPPING BETWEEN AMS AND PAYROLL
--			
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/09/23   Jigar Prajapati        Initial version
--*****************************************************************************************************************************

    INSERT OVERWRITE INTO DW_PROD.INTEGRATION.FACT_AMS_PAYROLL_MAPPING
select 
*
from (
 --  INSERT OVERWRITE INTO DW_PROD.INTEGRATION.FACT_AMS_PAYROLL_MAPPING
    WITH MAPPING_DATA AS (  -- PULL THE LIST OF DUPLICATES
      SELECT * FROM (
        SELECT *,COUNT(DISTINCT SOURCE_SYSTEM) OVER(PARTITION BY CLUSTER_ID) SYSTEM_COUNT
        FROM DW_PROD.INTEGRATION.AMS_PAYROLL_MAPPING_OUTPUT) 
        WHERE SYSTEM_COUNT > 1
    ) ,DIM_EMPLOYEE AS (   -- GET ADDITIONAL FIELDS FROM THE DIM_EMPLOYEE
  SELECT DISTINCT EMPLOYEE_KEY, EMPLOYEE_REHIRE_DATE,DERIVED_LAST_SERVICE_DATE,DERIVED_FIRST_SERVICE_DATE 
    ,DERIVED_PAYROLL_FIRST_CHECK_DATE, DERIVED_PAYROLL_LAST_CHECK_DATE FROM DW_PROD.HAH.DIM_EMPLOYEE
  )
  , AMS_DERIVED_FILEDS AS   -- DERIVED DATES 
  ( 
  SELECT  DISTINCT      
                 
                 MAX (EMPLOYEE_LAST_CHECK_DATE) OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_LAST_CHECK_DATE,
                MAX (EMPLOYEE_LAST_WORKED_DATE)OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_LAST_WORKED_DATE,
                MAX (EMPLOYEE_TERMINATE_DATE)OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_TERMINATE_DATE,
                MAX (EMPLOYEE_FIRST_CHECK_DATE)OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_FIRST_CHECK_DATE,
                MAX (EMPLOYEE_HIRE_DATE)OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_HIRE_DATE,
    ID
    FROM MAPPING_DATA WHERE SOURCE_SYSTEM = ''AMS'' AND  CLUSTER_ID IS NOT NULL
  ) 
    , AMS_RECORDS AS (   --- FIND THE LATEST RECORDS IF WE HAVE TWO AMS RECORDS 
      SELECT * FROM (
        SELECT 
          ROW_NUMBER() OVER(PARTITION BY CLUSTER_ID ORDER BY 
                            coalesce( 
                                     DERIVED_LAST_SERVICE_DATE,
                                     coalesce(EMPLOYEE_REHIRE_DATE,EMPLOYEE_HIRE_DATE,DERIVED_EMPLOYEE_HIRE_DATE),
                                     coalesce(EMPLOYEE_LAST_CHECK_DATE,DERIVED_EMPLOYEE_LAST_CHECK_DATE),
                                     coalesce(EMPLOYEE_LAST_WORKED_DATE,DERIVED_EMPLOYEE_LAST_WORKED_DATE), 
                                     EMPLOYEE_TERMINATE_DATE) desc,
                            coalesce(EMPLOYEE_FIRST_CHECK_DATE,DERIVED_EMPLOYEE_FIRST_CHECK_DATE) desc,
                              EMPLOYEE_ID DESC 
                           )
        RN, 
          M.ID AS EMPLOYEE_KEY,EMPLOYEE_ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,NAME,EMPLOYEE_FIRST_NAME,EMPLOYEE_LAST_NAME,EMPLOYEE_PID,EMPLOYEE_DOB,EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE,EMPLOYEE_WORK_PHONE,EMPLOYEE_PERSONAL_EMAIL,EMPLOYEE_WORK_EMAIL,EMPLOYEE_ADDRESS1,EMPLOYEE_ADDRESS2,EMPLOYEE_CITY,EMPLOYEE_STATE_CODE,EMPLOYEE_ZIP,EMPLOYEE_NUMBER,EMPLOYEE_HIRE_DATE,EMPLOYEE_FIRST_CHECK_DATE,EMPLOYEE_LAST_CHECK_DATE,EMPLOYEE_LAST_WORKED_DATE,EMPLOYEE_TERMINATE_DATE,PAYROLL_ID,STATE_CODE,SOURCE_SYSTEM,CLUSTER_ID,RULE_ID
        FROM MAPPING_DATA M
        LEFT JOIN DIM_EMPLOYEE E ON E.EMPLOYEE_KEY = M.ID
        LEFT JOIN AMS_DERIVED_FILEDS A ON A.ID  =M.ID
        WHERE SOURCE_SYSTEM = ''AMS'' AND CLUSTER_ID IS NOT NULL
      ) WHERE RN = 1
    )  
    ,PAYROLL_DERIVED_FILEDS AS   -- DERIVED DATES
  (
  SELECT   DISTINCT      MAX (EMPLOYEE_LAST_CHECK_DATE) OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_LAST_CHECK_DATE,
                MAX (EMPLOYEE_LAST_WORKED_DATE)OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_LAST_WORKED_DATE,
                MAX (EMPLOYEE_TERMINATE_DATE)OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_TERMINATE_DATE,
                MAX (EMPLOYEE_FIRST_CHECK_DATE)OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_FIRST_CHECK_DATE,
                MAX (EMPLOYEE_HIRE_DATE)OVER (PARTITION BY CLUSTER_ID) AS DERIVED_EMPLOYEE_HIRE_DATE,
    ID
    FROM MAPPING_DATA WHERE SOURCE_SYSTEM = ''PAYROLL'' AND  CLUSTER_ID IS NOT NULL
  )
    , PAYROLL_RECORDS AS ( --- FIND THE LATEST RECORDS IF WE HAVE TWO AMS RECORDS 
      SELECT * FROM (
        SELECT 
          ROW_NUMBER() OVER(PARTITION BY CLUSTER_ID ORDER BY 
                            coalesce(
                              DERIVED_PAYROLL_LAST_CHECK_DATE,
                              coalesce(EMPLOYEE_LAST_WORKED_DATE,DERIVED_EMPLOYEE_LAST_WORKED_DATE),
                              coalesce(EMPLOYEE_FIRST_CHECK_DATE,DERIVED_EMPLOYEE_FIRST_CHECK_DATE)  ,
                              coalesce(EMPLOYEE_HIRE_DATE,DERIVED_EMPLOYEE_HIRE_DATE),
                              coalesce(EMPLOYEE_FIRST_CHECK_DATE,DERIVED_EMPLOYEE_FIRST_CHECK_DATE)  
                                      ) desc,
                              EMPLOYEE_ID DESC 
                           ) RN,
          M.ID AS EMPLOYEE_KEY,EMPLOYEE_ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,NAME,EMPLOYEE_FIRST_NAME,EMPLOYEE_LAST_NAME,EMPLOYEE_PID,EMPLOYEE_DOB,EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE,EMPLOYEE_WORK_PHONE,EMPLOYEE_PERSONAL_EMAIL,EMPLOYEE_WORK_EMAIL,EMPLOYEE_ADDRESS1,EMPLOYEE_ADDRESS2,EMPLOYEE_CITY,EMPLOYEE_STATE_CODE,EMPLOYEE_ZIP,EMPLOYEE_NUMBER,EMPLOYEE_HIRE_DATE,EMPLOYEE_FIRST_CHECK_DATE,EMPLOYEE_LAST_CHECK_DATE,EMPLOYEE_LAST_WORKED_DATE,EMPLOYEE_TERMINATE_DATE,PAYROLL_ID,STATE_CODE,SOURCE_SYSTEM,CLUSTER_ID,RULE_ID
        FROM MAPPING_DATA M
        LEFT JOIN DIM_EMPLOYEE E ON E.EMPLOYEE_KEY = M.ID
        LEFT JOIN PAYROLL_DERIVED_FILEDS A ON A.ID  =M.ID
        WHERE SOURCE_SYSTEM = ''PAYROLL'' AND CLUSTER_ID IS NOT NULL
      ) WHERE RN = 1
    )
    SELECT
    A.EMPLOYEE_KEY AS AMS_EMPLOYEE_KEY, 
    P.EMPLOYEE_KEY AS PAYROLL_EMPLOYEE_KEY,
    A.EMPLOYEE_ID AS AMS_EMPLOYEE_ID,
    P.EMPLOYEE_ID AS PAYROLL_EMPLOYEE_ID,
    A.SYSTEM_CODE AS AMS_SYSTEM_CODE,
    P.SYSTEM_CODE AS PAYROLL_SYSTEM_CODE,
    A.SOURCE_SYSTEM_ID::INT AS AMS_SOURCE_SYSTEM_ID,
    P.SOURCE_SYSTEM_ID::INT AS PAYROLL_SOURCE_SYSTEM_ID,
    A.EMPLOYEE_HIRE_DATE AS AMS_HIRE_DATE,
    P.EMPLOYEE_HIRE_DATE AS PAYROLL_HIRE_DATE,
    A.EMPLOYEE_TERMINATE_DATE AS AMS_TERMINATE_DATE,
    P.EMPLOYEE_TERMINATE_DATE AS PAYROLL_TERMINATE_DATE,
    A.STATE_CODE AS AMS_STATE_CODE,
    P.STATE_CODE AS PAYROLL_STATE_CODE,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY
    FROM AMS_RECORDS A INNER JOIN PAYROLL_RECORDS P ON A.CLUSTER_ID = P.CLUSTER_ID
  );
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result; 
END;
';