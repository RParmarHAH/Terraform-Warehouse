CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_HH_EMPLOYEE_BRANCH("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_HH_EMPLOYEE_BRANCH 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-12-15 		Deepesh/Ravi Suthar     Added logic for incremental load
--*****************************************************************************************************************************

MERGE INTO DISC_PROD.AXXESS.HIST_AXXESS_HH_EMPLOYEE_BRANCH TARGET 
USING (
    SELECT 
        A.$1 AS Account_Id, 
        A.$2 AS Account_Name, 
        A.$3 AS System_Employee_Id, 
        A.$4 AS User_Email, 
        A.$5 AS Branch_Id, 
        A.$6 AS Branch_Name, 
        :TaskKey AS ETL_TASK_KEY,
        :TaskKey AS ETL_INSERTED_TASK_KEY, 
        current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, 
        CURRENT_USER() AS ETL_INSERTED_BY, 
        current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, 
        CURRENT_USER() AS ETL_LAST_UPDATED_BY, 
        FALSE AS ETL_DELETED_FLAG 
    FROM @DISC_PROD.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HH_EMPLOYEE_BRANCH(file_format => DISC_PROD.STAGE.PSV_FORMAT) A
) SOURCE
ON EQUAL_NULL(TARGET.Account_Id, SOURCE.Account_Id)
OR EQUAL_NULL(TARGET.Account_Name, SOURCE.Account_Name)
OR EQUAL_NULL(TARGET.System_Employee_Id, SOURCE.System_Employee_Id)
OR EQUAL_NULL(TARGET.User_Email, SOURCE.User_Email)
OR EQUAL_NULL(TARGET.Branch_Id, SOURCE.Branch_Id)
OR EQUAL_NULL(TARGET.Branch_Name, SOURCE.Branch_Name)
WHEN NOT MATCHED THEN
    INSERT (
        Account_Id, 
        Account_Name, 
        System_Employee_Id, 
        User_Email, 
        Branch_Id, 
        Branch_Name, 
        ETL_TASK_KEY,
        ETL_INSERTED_TASK_KEY, 
        ETL_INSERTED_DATE, 
        ETL_INSERTED_BY, 
        ETL_LAST_UPDATED_DATE, 
        ETL_LAST_UPDATED_BY, 
        ETL_DELETED_FLAG
    ) VALUES (
        SOURCE.Account_Id, 
        SOURCE.Account_Name, 
        SOURCE.System_Employee_Id, 
        SOURCE.User_Email, 
        SOURCE.Branch_Id, 
        SOURCE.Branch_Name, 
        SOURCE.ETL_TASK_KEY,
        SOURCE.ETL_INSERTED_TASK_KEY, 
        SOURCE.ETL_INSERTED_DATE, 
        SOURCE.ETL_INSERTED_BY, 
        SOURCE.ETL_LAST_UPDATED_DATE, 
        SOURCE.ETL_LAST_UPDATED_BY, 
        SOURCE.ETL_DELETED_FLAG
    );
    
 UPDATE DISC_PROD.AXXESS.HIST_AXXESS_HH_EMPLOYEE_BRANCH
 SET ETL_DELETED_FLAG = TRUE, ETL_LAST_UPDATED_DATE = CURRENT_TIMESTAMP(),ETL_LAST_UPDATED_BY = CURRENT_USER()
 WHERE Account_Id NOT IN ( SELECT A.$1 FROM @DISC_PROD.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HH_EMPLOYEE_BRANCH(file_format => DISC_PROD.STAGE.PSV_ZIPCODES) A);


 CREATE OR REPLACE TABLE DISC_PROD.AXXESS.AXXESS_HH_EMPLOYEE_BRANCH AS SELECT * FROM DISC_PROD.AXXESS.HIST_AXXESS_HH_EMPLOYEE_BRANCH WHERE 
 ETL_DELETED_FLAG=FALSE AND (Account_Id, ETL_INSERTED_DATE) IN (SELECT Account_Id, MAX(ETL_INSERTED_DATE)FROM 
 DISC_PROD.AXXESS.HIST_AXXESS_HH_EMPLOYEE_BRANCH GROUP BY Account_Id);

END;
';