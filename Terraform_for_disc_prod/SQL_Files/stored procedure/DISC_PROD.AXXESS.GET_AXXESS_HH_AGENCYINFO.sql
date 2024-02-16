CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_HH_AGENCYINFO("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_HH_AGENCYINFO 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-12-15 		Deepesh/Ravi           	Added logic for incremental load
--*****************************************************************************************************************************

	MERGE INTO DISC_PROD.AXXESS.HIST_AXXESS_HH_AGENCYINFO TARGET
USING (
		SELECT 
			A.$1 AS Agency_Id, 
			A.$2 AS Create_Timestamp, 
			A.$3 AS Update_Timestamp, 
			A.$4 AS Name, 
			A.$5 AS Tax_Id, 
			A.$6 AS National_Provider_Number, 
			A.$7 AS Medicare_Provider_Number, 
			A.$8 AS Medicaid_Provider_Number, 
			A.$9 AS Unique_Agency_Oasis_Id, 
			:TaskKey AS ETL_TASK_KEY,
			:TaskKey AS ETL_INSERTED_TASK_KEY, 
			CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, 
			CURRENT_USER() AS ETL_INSERTED_BY, 
			CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, 
			CURRENT_USER() AS ETL_LAST_UPDATED_BY, 
			FALSE AS ETL_DELETED_FLAG 
		FROM @DISC_PROD.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HH_AGENCYINFO(file_format => DISC_PROD.STAGE.PSV_FORMAT) A
	) SOURCE
ON EQUAL_NULL(TARGET.Agency_Id , SOURCE.Agency_Id) OR EQUAL_NULL(TARGET.Create_Timestamp , SOURCE.Create_Timestamp) OR EQUAL_NULL (TARGET.Create_Timestamp , SOURCE.Create_Timestamp) OR EQUAL_NULL (TARGET.Update_Timestamp , SOURCE.Update_Timestamp) OR  EQUAL_NULL(TARGET.Name , SOURCE.Name) OR EQUAL_NULL(TARGET.Tax_Id , SOURCE.Tax_Id) OR EQUAL_NULL(TARGET.National_Provider_Number , SOURCE.National_Provider_Number) OR EQUAL_NULL(TARGET.Medicare_Provider_Number , SOURCE.Medicare_Provider_Number) OR EQUAL_NULL(TARGET.Unique_Agency_Oasis_Id , SOURCE.Unique_Agency_Oasis_Id)
WHEN NOT MATCHED THEN
	INSERT (
        Agency_Id, 
        Create_Timestamp, 
        Update_Timestamp, 
        Name, 
        Tax_Id, 
        National_Provider_Number, 
        Medicare_Provider_Number, 
        Medicaid_Provider_Number, 
        Unique_Agency_Oasis_Id, 
        ETL_TASK_KEY,
        ETL_INSERTED_TASK_KEY, 
        ETL_INSERTED_DATE, 
        ETL_INSERTED_BY, 
        ETL_LAST_UPDATED_DATE, 
        ETL_LAST_UPDATED_BY,
        ETL_DELETED_FLAG
    ) VALUES (
        SOURCE.Agency_Id, 
        SOURCE.Create_Timestamp, 
        SOURCE.Update_Timestamp, 
        SOURCE.Name, 
        SOURCE.Tax_Id, 
        SOURCE.National_Provider_Number, 
        SOURCE.Medicare_Provider_Number, 
        SOURCE.Medicaid_Provider_Number, 
        SOURCE.Unique_Agency_Oasis_Id, 
        SOURCE.ETL_TASK_KEY,
        SOURCE.ETL_INSERTED_TASK_KEY,
        SOURCE.ETL_INSERTED_DATE, 
        SOURCE.ETL_INSERTED_BY,
        SOURCE.ETL_LAST_UPDATED_DATE, 
        SOURCE.ETL_LAST_UPDATED_BY,
        SOURCE.ETL_DELETED_FLAG 
    );

 UPDATE DISC_PROD.AXXESS.HIST_AXXESS_HH_AGENCYINFO
 SET ETL_DELETED_FLAG = TRUE, ETL_LAST_UPDATED_DATE = CURRENT_TIMESTAMP(),ETL_LAST_UPDATED_BY = CURRENT_USER()
 WHERE Agency_Id NOT IN ( SELECT A.$1 FROM @DISC_PROD.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HH_AGENCYINFO(file_format => DISC_PROD.STAGE.PSV_ZIPCODES) A);
 
 CREATE OR REPLACE TABLE DISC_PROD.AXXESS.AXXESS_HH_AGENCYINFO AS 
 SELECT * FROM DISC_PROD.AXXESS.HIST_AXXESS_HH_AGENCYINFO
 WHERE ETL_DELETED_FLAG=FALSE AND (Agency_Id, ETL_INSERTED_DATE) IN (SELECT Agency_Id, MAX(ETL_INSERTED_DATE) FROM DISC_PROD.AXXESS.HIST_AXXESS_HH_AGENCYINFO GROUP BY Agency_Id);

END;
';