CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CCSI_DIM_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
        var sql = `
    --******************************************************************************************************************************************
-- NAME:  CCSI_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per employee_id/database according to CCSI
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -------------------------------------------------------------------------------------------------------        
-- 09/01/21    Shraddha Sejpal       Initial development
-- 11/10/23    Shikhar Saxena		 Updated employee ethnicity logic and added HISPANIC_OR_LATINO column
--******************************************************************************************************************************************
--
-- Build DIM_Employee for CCSI based on EMPLOYEE1
--
INSERT OVERWRITE INTO STAGE.CCSI_DIM_EMPLOYEE 
SELECT DISTINCT
     MD5(RECORD_NUMBER::STRING || ''-'' || NVL(AREA,''C'')::STRING || ''-'' || ''CCSI'') AS Employee_key
     ,TRY_CAST(DIM_EMPLOYEE_NUMBER AS NUMBER) AS Employee_ID 
     ,''CCSI'' AS System_Code
     ,8 AS Source_System_ID  
     ,CASE WHEN TRIM(REGEXP_REPLACE(SS,''\\\\-|\\\\(|\\\\)|\\\\ '','''')) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM(REGEXP_REPLACE(SS,''\\\\-|\\\\(|\\\\)|\\\\ '','''')) NOT LIKE ''00000%'' AND LENGTH(TRIM(REGEXP_REPLACE(SS,''\\\\-|\\\\(|\\\\)|\\\\ '','''')))=9 THEN HEX_ENCODE(TRIM(REGEXP_REPLACE(SS,''\\\\-|\\\\(|\\\\)|\\\\ '',''''))) 
      ELSE NULL END AS EMPLOYEE_PID
     ,TRY_CAST(DIM_EMPLOYEE_NUMBER AS NUMBER) AS Employee_Number
     ,TRY_TO_DATE(DATE_OF_BIRTH,''YYYYMMDD'') AS EMPLOYEE_DOB
     ,NULL AS EMPLOYEE_Date_Of_Death
     ,TRY_TO_DATE(HIRE_DATE,''YYYYMMDD'') AS EMPLOYEE_HIRE_DATE
     ,NULL AS EMPLOYEE_REHIRE_DATE
     ,TRY_CAST(EMP.FIRST_DAY_OF_WORK_DATE AS DATE) AS Employee_Benefit_Start_Date 
     ,NULL AS Employee_First_Check_Date
     ,NULL AS Employee_Last_Check_Date
     ,TRY_TO_DATE(TERMINATION_DATE,''YYYYMMDD'') AS Employee_Last_Worked_DATE
     ,TRY_TO_DATE(TERMINATION_DATE,''YYYYMMDD'') AS EMPLOYEE_TERMINATE_DATE
     ,NULL AS Reason_To_Terminate
     ,CASE WHEN EMPLOYEE_NUMBER > 9999 THEN FALSE ELSE TRUE END AS Active_Employee_Flag
     ,NULL AS Able_to_Rehire_Flag
     ,NULL AS Employee_Prefix 
     , CASE WHEN FIRST_NAME <> '''' AND FIRST_NAME IS NOT NULL THEN UPPER( TRIM(FIRST_NAME))
       WHEN DIM_EMPLOYEE_NAME <>'''' AND DIM_EMPLOYEE_NAME IS NOT NULL AND DIM_EMPLOYEE_NAME <>''9'' THEN UPPER(SPLIT_PART((split_part(TRIM(DIM_EMPLOYEE_NAME,''9''),'','', 2)),'' '',2)) ELSE NULL END AS Employee_First_Name
     , CASE WHEN UPPER( TRIM(MIDDLE_INITIAL)) <> '''' AND UPPER( TRIM(MIDDLE_INITIAL)) IS NOT NULL THEN TRIM( UPPER( regexp_replace(MIDDLE_INITIAL,''\\\\d|\\\\.|\\\\,|\\\\-'','''')))
       ELSE NULL END AS Employee_Middle_Name
     , CASE WHEN LAST_NAME <> '''' AND LAST_NAME IS NOT NULL THEN UPPER( TRIM(LAST_NAME))
       WHEN DIM_EMPLOYEE_NAME <>'''' AND DIM_EMPLOYEE_NAME IS NOT NULL AND DIM_EMPLOYEE_NAME <>''9'' THEN UPPER(split_part(TRIM(DIM_EMPLOYEE_NAME,''9''),'','', 1)) ELSE NULL END AS Employee_Last_Name
     , NULL AS Employee_Suffix
     , CASE WHEN EMP.ADDRESS <> '''' AND EMP.ADDRESS IS NOT NULL THEN UPPER( TRIM(EMP.ADDRESS))
       ELSE NULL END AS Employee_Address1
     ,NULL AS Employee_Address2
     ,CASE WHEN EMP.CITY <> '''' AND EMP.CITY IS NOT NULL THEN UPPER(TRIM(EMP.CITY)) ELSE NULL END AS Employee_City
     ,ST.STATE_ISO_CODE AS EMPLOYEE_STATE_CODE
     ,ZIP.ZIP_CODE AS Employee_Zip
     ,CASE WHEN LENGTH(TRIM(REGEXP_REPLACE(PHONENUMBER,''\\\\\\\\-|\\\\\\\\(|\\\\\\\\)|\\\\\\\\ '','''')))=10 THEN TRIM(REGEXP_REPLACE(PHONENUMBER,''\\\\\\\\-|\\\\\\\\(|\\\\\\\\)|\\\\\\\\ '',''''))
	 ELSE NULL END AS Employee_Home_Phone
     ,CASE WHEN LENGTH(TRIM(REGEXP_REPLACE(CELLPHONE,''\\\\\\\\-|\\\\\\\\(|\\\\\\\\)|\\\\\\\\ '','''')))=10 THEN TRIM(REGEXP_REPLACE(CELLPHONE,''\\\\\\\\-|\\\\\\\\(|\\\\\\\\)|\\\\\\\\ '',''''))
	 ELSE NULL END AS Employee_Cell_Phone
     ,NULL AS Employee_Work_Phone
     ,NULL AS Employee_Personal_Email
     ,NULL AS Employee_Work_Email
     ,NULL AS Linked_In_Profile_URL
     ,CASE WHEN UPPER( TRIM(SEX)) = ''M'' THEN ''MALE''
           WHEN UPPER( TRIM(SEX)) = ''F'' THEN ''FEMALE'' ELSE NULL END AS Employee_Gender
     ,CASE WHEN RACE=''B'' THEN ''BLACK OR AFRICAN AMERICAN'' 
           WHEN RACE= ''W'' THEN ''WHITE'' 
           WHEN RACE= ''U'' THEN ''UNKNOWN'' 
           ELSE NULL END  AS Employee_Ethnicity
	 ,IFF(UPPER(TRIM(RACE)) = ''H'', TRUE, FALSE) AS HISPANIC_OR_LATINO
     ,NULL AS EMPLOYEE_LANGUAGE
     ,CASE WHEN TRIM(UPPER(MARITAL_STATUS))=''S'' THEN ''Single''
     	   WHEN TRIM(UPPER(MARITAL_STATUS))=''M'' THEN ''Married'' ELSE NULL END AS Employee_Marital_Status
     ,NULL AS Employee_Type
     ,''FIELD'' AS Employee_Category
     ,NULL AS Exempt_Flag
     ,NULL AS Job_Title
     ,NULL AS Job_Description
     ,NULL AS Class_ID
     ,NULL AS Workers_Comp
     ,NULL AS Payroll_ID
     ,NULL AS Percent_401k_Deduction
     ,NULL AS Amount_401k_Deduction
     ,NULL AS JazzHR_Applicant_ID
     ,NULL AS JazzHR_User_ID
     ,NULL AS JazzHR_Contact_ID
     ,B.STATE AS Work_State 
     ,NULL AS SUTA_State
     ,NULL AS Employee_Department
     ,CASE WHEN AREA=''CEN'' THEN 236
     	   WHEN AREA=''CHI'' THEN 244
     	   WHEN AREA=''ESL'' THEN 375
     	   WHEN AREA=''FAI'' THEN 324
     	   WHEN AREA=''GRV'' THEN 478
     	   WHEN AREA=''HAR'' THEN 427
     	   WHEN AREA=''JLT'' THEN 558
     	   WHEN AREA=''OAK'' THEN 625
     	   WHEN AREA=''PIT'' THEN 748
     	   WHEN AREA=''QUY'' THEN 789
     	   WHEN AREA=''ROC'' THEN 762
     	   WHEN AREA=''SPI'' THEN 774
     	   WHEN AREA=''VLG'' THEN 854 ELSE NULL END AS EMPLOYEE_OFFICE_CODE
	 ,MD5(''CCSI'' || ''-'' || B.BRANCH_CODE || ''-'' || ''CCSI'') AS PRIMARY_BRANCH_KEY
	 ,''IL'' AS PRIMARY_BRANCH_STATE
	 ,UPPER(TRIM(B.BRANCH_NAME)) AS PRIMARY_BRANCH_NAME
     ,NULL AS PRIMARY_BRANCH_SYSTEM_CODE
	 ,NULL AS CASE_MANAGER_FLAG
	 ,NULL AS SUPERVISOR_FLAG
	 ,NULL AS COORDINATOR_FLAG,
     TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
     TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
 	 NULL AS MDM_DIM_EMPLOYEE_KEY,
    
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
        
    
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
              
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_DEDUPE_PROD.CCSI.EMP_MASTER_LIST_CCSI EMP
LEFT JOIN DISC_PROD.CCSI.BRANCH_MAPPING B ON B.BRANCH_CODE = EMP.AREA
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = UPPER( SUBSTRING(EMP.State, 1, 2))
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = UPPER( SUBSTRING(ZipCODE, 1, 5))
WHERE TRY_CAST(EMP.DIM_EMPLOYEE_NUMBER AS NUMBER) IS NOT NULL`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          ';