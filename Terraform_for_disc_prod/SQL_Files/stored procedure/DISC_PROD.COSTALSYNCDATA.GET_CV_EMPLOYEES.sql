CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_EMPLOYEES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_Employees 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_Employees FROM (SELECT t.$1 AS Db, t.$2 AS User_Code, t.$3 AS Nurse_ID, t.$4 AS Last_Name, t.$5 AS First_Name, t.$6 AS Last_First_Name, t.$7 AS Discipline_Code, t.$8 AS Service_Category_Code, t.$9 AS Location_Code, t.$10 AS Facility_Code, t.$11 AS Provider_Code, t.$12 AS Address, t.$13 AS City, t.$14 AS Phone, t.$15 AS Work_Phone, t.$16 AS Emergency_Phone, t.$17 AS Beeper_Number, t.$18 AS Zone_Code, t.$19 AS Pay_Rate, t.$20 AS Description30_From, t.$21 AS Description30_Thru, t.$22 AS Social_Security_Number, t.$23 AS DEX_ROW_ID, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Employees.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_Employees AS WITH curr_v AS (SELECT Db, User_Code, Nurse_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Employees where ETL_DELETED_FLAG = FALSE GROUP BY Db, User_Code, Nurse_ID) SELECT t.* FROM CostalSyncData.HIST_CV_Employees t INNER JOIN curr_v v ON t.Db = v.Db AND t.User_Code = v.User_Code AND t.Nurse_ID = v.Nurse_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';