CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_HC_EMPLOYEEINFO("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_HC_EMPLOYEEINFO 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-12-15 		EDumpala/RSuthar     	Added logic for incremental load   
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    INSERT INTO DISC_PROD.AXXESS.HIST_AXXESS_HC_EMPLOYEEINFO (SELECT A.$1 AS System_Employee_Id, A.$2 AS Create_Timestamp, A.$3 AS Update_Timestamp, A.$4 AS User_Email, A.$5 AS User_Status, A.$6 AS Hire_Date, A.$7 AS Termination_Date, A.$8 AS Worker_FirstName, A.$9 AS Worker_MiddleName, A.$10 AS Worker_LastName, A.$11 AS SSN, A.$12 AS Date_Of_Birth, A.$13 AS Employee_Id, A.$14 AS Address_Line1, A.$15 AS Address_Line2, A.$16 AS Address_City, A.$17 AS Address_Zip_Code, A.$18 AS Address_State_Code, A.$19 AS Primary_Phone_Type, A.$20 AS Primary_Phone_Number, A.$21 AS Gender, A.$22 AS Employement_Type, A.$23 AS Credentials, A.$24 AS TitleType, A.$25 AS Is_Case_Manager, A.$26 AS Comments, A.$27 AS Account_Id, A.$28 AS Account_Name,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HC_EMPLOYEEINFO(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);
	
CREATE OR REPLACE TABLE DISC_PROD.AXXESS.AXXESS_HC_EMPLOYEEINFO
 AS WITH curr_v AS 
 (SELECT SYSTEM_EMPLOYEE_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE 
 FROM DISC_PROD.AXXESS.HIST_AXXESS_HC_EMPLOYEEINFO GROUP BY SYSTEM_EMPLOYEE_ID )   
 SELECT P.* exclude ETL_DELETED_FLAG,
 CASE WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE ELSE P.ETL_DELETED_FLAG END AS ETL_DELETED_FLAG 
 FROM DISC_PROD.AXXESS.HIST_AXXESS_HC_EMPLOYEEINFO P 
 INNER JOIN curr_v v ON P.SYSTEM_EMPLOYEE_ID = v.SYSTEM_EMPLOYEE_ID
 AND P.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;


----REPLACE HIST TABLE WITH CURRENT TABLE 
create OR REPLACE table DISC_PROD.AXXESS.HIST_AXXESS_HC_EMPLOYEEINFO CLONE DISC_PROD.AXXESS.AXXESS_HC_EMPLOYEEINFO;	

END;
';