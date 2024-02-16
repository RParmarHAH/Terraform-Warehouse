CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_HC_AUTHORIZATION("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_HC_AUTHORIZATION 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                		NOTES:
-- ----------  		-------------------   		-----------------------------------------------------------------------------------------------
-- 2023-12-05 		Komal Dhokai            	Initial Development
-- 2023-12-15 		EDumpala/RSuthar     		Added logic for incremental load   
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    MERGE INTO DISC_PROD.AXXESS.HIST_AXXESS_HC_AUTHORIZATION TARGET USING(SELECT A.$1 AS Authorization_Detail_Id, A.$2 AS Create_Timestamp, A.$3 AS Update_Timestamp, A.$4 AS Authorization_Number, A.$5 AS Authorization_Status, A.$6 AS Authorization_Type, A.$7 AS Authorization_Start_Date, A.$8 AS Authorization_End_Date, A.$9 AS Authorization_Payer_Payment_Source_System_Id, A.$10 AS Authorization_Payer_Payment_Source_Name, A.$11 AS Authorized_Service_Category_Name, A.$12 AS Authorized_Service_Category_BillCode_List, A.$13 AS Authorized_Service_Unit_Type_Count, A.$14 AS Authorized_Service_Unit_Type, A.$15 AS Authorized_Service_Unit_Type_Frequency, A.$16 AS Authorized_Service_Day_List, A.$17 AS Authorized_Service_Visits_Per_Frequency, A.$18 AS Authorized_Service_Unit_Count, A.$19 AS Authorized_Client_System_Id, A.$20 AS Authorized_Client_MRN, A.$21 AS Authorized_Client_Branch_System_Id, A.$22 AS Authorized_Client_Branch_Name, A.$23 AS Account_Id, A.$24 AS Authorization_Comments, A.$25 AS Authorization_Utilization_Used_Unit_Count, A.$26 AS Authorization_Utilization_Unused_Unit_Count, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HC_Authorization (file_format => DISC_PROD.STAGE.PSV_FORMAT) A)SOURCE
ON EQUAL_NULL(TARGET.Authorization_Detail_Id , SOURCE.Authorization_Detail_Id) OR EQUAL_NULL(TARGET.Create_Timestamp , SOURCE.Create_Timestamp) OR EQUAL_NULL(TARGET.Update_Timestamp , SOURCE.Update_Timestamp) OR EQUAL_NULL(TARGET.Authorization_Number , SOURCE.Authorization_Number) OR EQUAL_NULL(TARGET.Authorization_Status , SOURCE.Authorization_Status) OR EQUAL_NULL(TARGET.Authorization_Type , SOURCE.Authorization_Type) OR EQUAL_NULL(TARGET.Authorization_Start_Date , SOURCE.Authorization_Start_Date) OR EQUAL_NULL(TARGET.Authorization_End_Date , SOURCE.Authorization_End_Date) OR EQUAL_NULL(TARGET.Authorization_Payer_Payment_Source_System_Id , SOURCE.Authorization_Payer_Payment_Source_System_Id) OR EQUAL_NULL(TARGET.Authorization_Payer_Payment_Source_Name , SOURCE.Authorization_Payer_Payment_Source_Name) OR EQUAL_NULL(TARGET.Authorized_Service_Category_Name , SOURCE.Authorized_Service_Category_Name) OR EQUAL_NULL(TARGET.Authorized_Service_Category_BillCode_List , SOURCE.Authorized_Service_Category_BillCode_List) OR EQUAL_NULL(TARGET.Authorized_Service_Unit_Type_Count , SOURCE.Authorized_Service_Unit_Type_Count) OR EQUAL_NULL(TARGET.Authorized_Service_Unit_Type , SOURCE.Authorized_Service_Unit_Type) OR EQUAL_NULL(TARGET.Authorized_Service_Unit_Type_Frequency , SOURCE.Authorized_Service_Unit_Type_Frequency) OR EQUAL_NULL(TARGET.Authorized_Service_Day_List , SOURCE.Authorized_Service_Day_List) OR EQUAL_NULL(TARGET.Authorized_Service_Visits_Per_Frequency , SOURCE.Authorized_Service_Visits_Per_Frequency) OR EQUAL_NULL(TARGET.Authorized_Service_Unit_Count , SOURCE.Authorized_Service_Unit_Count) OR EQUAL_NULL(TARGET.Authorized_Client_System_Id , SOURCE.Authorized_Client_System_Id) OR EQUAL_NULL(TARGET.Authorized_Client_MRN , SOURCE.Authorized_Client_MRN) OR EQUAL_NULL(TARGET.Authorized_Client_Branch_System_Id , SOURCE.Authorized_Client_Branch_System_Id) OR EQUAL_NULL(TARGET.Authorized_Client_Branch_Name , SOURCE.Authorized_Client_Branch_Name)OR EQUAL_NULL(TARGET.Account_Id , SOURCE.Account_Id) OR EQUAL_NULL(TARGET.Authorization_Comments , SOURCE.Authorization_Comments)OR EQUAL_NULL(TARGET.Authorization_Utilization_Used_Unit_Count , SOURCE.Authorization_Utilization_Used_Unit_Count)OR EQUAL_NULL(TARGET.Authorization_Utilization_Unused_Unit_Count , SOURCE.Authorization_Utilization_Unused_Unit_Count) OR EQUAL_NULL(TARGET.ETL_TASK_KEY , SOURCE.ETL_TASK_KEY) OR EQUAL_NULL(TARGET.ETL_INSERTED_TASK_KEY , SOURCE.ETL_INSERTED_TASK_KEY)OR EQUAL_NULL(TARGET.ETL_INSERTED_DATE , SOURCE.ETL_INSERTED_DATE)OR EQUAL_NULL(TARGET.ETL_INSERTED_BY , SOURCE.ETL_INSERTED_BY)OR EQUAL_NULL(TARGET.ETL_LAST_UPDATED_DATE , SOURCE.ETL_LAST_UPDATED_DATE) OR EQUAL_NULL(TARGET.ETL_LAST_UPDATED_BY , SOURCE.ETL_LAST_UPDATED_BY) OR EQUAL_NULL(TARGET.ETL_DELETED_FLAG , SOURCE.ETL_DELETED_FLAG) 
WHEN NOT MATCHED THEN
        INSERT (
            Authorization_Detail_Id, 
            Create_Timestamp, 
            Update_Timestamp, 
            Authorization_Number, 
            Authorization_Status, 
            Authorization_Type, 
            Authorization_Start_Date, 
            Authorization_End_Date, 
            Authorization_Payer_Payment_Source_System_Id, 
            Authorization_Payer_Payment_Source_Name, 
            Authorized_Service_Category_Name, 
            Authorized_Service_Category_BillCode_List, 
            Authorized_Service_Unit_Type_Count, 
            Authorized_Service_Unit_Type, 
            Authorized_Service_Unit_Type_Frequency, 
            Authorized_Service_Day_List, 
            Authorized_Service_Visits_Per_Frequency, 
            Authorized_Service_Unit_Count, 
            Authorized_Client_System_Id, 
            Authorized_Client_MRN, 
            Authorized_Client_Branch_System_Id, 
            Authorized_Client_Branch_Name, 
            Account_Id, 
            Authorization_Comments, 
            Authorization_Utilization_Used_Unit_Count, 
            Authorization_Utilization_Unused_Unit_Count,
			ETL_TASK_KEY, 
            ETL_INSERTED_TASK_KEY, 
            ETL_INSERTED_DATE, 
            ETL_INSERTED_BY, 
            ETL_LAST_UPDATED_DATE, 
            ETL_LAST_UPDATED_BY, 
            ETL_DELETED_FLAG
        ) VALUES (
            SOURCE.Authorization_Detail_Id, 
            SOURCE.Create_Timestamp, 
            SOURCE.Update_Timestamp, 
            SOURCE.Authorization_Number, 
            SOURCE.Authorization_Status, 
            SOURCE.Authorization_Type, 
            SOURCE.Authorization_Start_Date, 
            SOURCE.Authorization_End_Date, 
            SOURCE.Authorization_Payer_Payment_Source_System_Id, 
            SOURCE.Authorization_Payer_Payment_Source_Name, 
            SOURCE.Authorized_Service_Category_Name, 
            SOURCE.Authorized_Service_Category_BillCode_List, 
            SOURCE.Authorized_Service_Unit_Type_Count, 
            SOURCE.Authorized_Service_Unit_Type, 
            SOURCE.Authorized_Service_Unit_Type_Frequency, 
            SOURCE.Authorized_Service_Day_List, 
            SOURCE.Authorized_Service_Visits_Per_Frequency, 
            SOURCE.Authorized_Service_Unit_Count, 
            SOURCE.Authorized_Client_System_Id, 
            SOURCE.Authorized_Client_MRN, 
            SOURCE.Authorized_Client_Branch_System_Id, 
            SOURCE.Authorized_Client_Branch_Name, 
            SOURCE.Account_Id, 
            SOURCE.Authorization_Comments, 
            SOURCE.Authorization_Utilization_Used_Unit_Count, 
            SOURCE.Authorization_Utilization_Unused_Unit_Count,
			SOURCE.ETL_TASK_KEY, 
            SOURCE.ETL_INSERTED_TASK_KEY, 
            SOURCE.ETL_INSERTED_DATE, 
            SOURCE.ETL_INSERTED_BY, 
            SOURCE.ETL_LAST_UPDATED_DATE, 
            SOURCE.ETL_LAST_UPDATED_BY, 
            SOURCE.ETL_DELETED_FLAG
        );
		
		UPDATE DISC_PROD.AXXESS.HIST_AXXESS_HC_AUTHORIZATION SET
	ETL_DELETED_FLAG=TRUE, ETL_LAST_UPDATED_DATE=CURRENT_TIMESTAMP(),ETL_LAST_UPDATED_BY=CURRENT_USER()
	WHERE Authorization_Detail_Id NOT IN (SELECT A.$1 FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HC_Authorization (file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

   CREATE OR REPLACE TABLE DISC_PROD.AXXESS.AXXESS_HC_AUTHORIZATION AS SELECT * FROM DISC_PROD.AXXESS.HIST_AXXESS_HC_AUTHORIZATION WHERE 
   ETL_DELETED_FLAG=FALSE AND (Authorization_Detail_Id,ETL_INSERTED_DATE) IN (SELECT Authorization_Detail_Id,MAX(ETL_INSERTED_DATE)FROM 
   DISC_PROD.AXXESS.HIST_AXXESS_HC_AUTHORIZATION GROUP BY Authorization_Detail_Id);
END;
';