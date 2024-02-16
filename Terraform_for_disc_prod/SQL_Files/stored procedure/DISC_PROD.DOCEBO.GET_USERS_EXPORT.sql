CREATE OR REPLACE PROCEDURE DISC_PROD.DOCEBO.GET_USERS_EXPORT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DOCEBO.GET_USERS_EXPORT 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2024-01-11 		Ravi Suthar            	Added Workday_ID Column
-- 2024-01-12 		Ravi Suthar            	Added Term_Date Column
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_PROD.DOCEBO.HIST_USERS_EXPORT FROM (SELECT A.$1 Username, A.$2 Are_you_or_are_you_applying_to_be_an_inhome_caregiver, A.$3 Branches, A.$4 Business_Unit, A.$5 Deactivated, A.$6 Direct_Manager, A.$7 Do_you_have_a_Home_Health_Certification, A.$8 Email, A.$9 Email_Address, A.$10 Field_or_Admin, A.$11 First_Name, A.$12 First_Service_Date, A.$13 Full_Name, A.$14 Hire_Date, A.$15 Hourly, A.$16 Job_Level, A.$17 Job_Title, A.$18 Language, A.$19 Last_Name, A.$20 Location, A.$21 Manager_Name, A.$22 Payroll_ID, A.$23 State, A.$24 Term_Date, A.$25 Time_Zone, A.$26 User_Expiration_Date, A.$27 User_Level, A.$28 User_unique_ID, A.$29 Workday_ID, :TaskKey AS ETL_TASK_KEY,  :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,  current_user() AS ETL_LAST_UPDATED_BY,  0 as ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Docebo_SFTP_Files/Upload_file/users_export(file_format => DISC_PROD.STAGE.CSV_Format) A);

    --ViewSQL
    MERGE INTO DISC_PROD.DOCEBO.USERS_EXPORT TGT  USING (SELECT * FROM DISC_PROD.DOCEBO.HIST_USERS_EXPORT WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.DOCEBO.HIST_USERS_EXPORT) ) STAGE  ON TGT.User_unique_ID = STAGE.User_unique_ID WHEN MATCHED THEN  UPDATE SET  TGT.Username = STAGE.Username, TGT.Are_you_or_are_you_applying_to_be_an_inhome_caregiver = STAGE.Are_you_or_are_you_applying_to_be_an_inhome_caregiver, TGT.Branches = STAGE.Branches, TGT.Business_Unit = STAGE.Business_Unit, TGT.Deactivated = STAGE.Deactivated, TGT.Direct_Manager = STAGE.Direct_Manager, TGT.Do_you_have_a_Home_Health_Certification = STAGE.Do_you_have_a_Home_Health_Certification, TGT.Email = STAGE.Email, TGT.Email_Address = STAGE.Email_Address, TGT.Field_or_Admin = STAGE.Field_or_Admin, TGT.First_Name = STAGE.First_Name, TGT.First_Service_Date = STAGE.First_Service_Date, TGT.Full_Name = STAGE.Full_Name, TGT.Hire_Date = STAGE.Hire_Date, TGT.Hourly = STAGE.Hourly, TGT.Job_Level = STAGE.Job_Level, TGT.Job_Title = STAGE.Job_Title, TGT.Language = STAGE.Language, TGT.Last_Name = STAGE.Last_Name, TGT.Location = STAGE.Location, TGT.Manager_Name = STAGE.Manager_Name, TGT.Payroll_ID = STAGE.Payroll_ID, TGT.State = STAGE.State, TGT.Term_Date = STAGE.Term_Date, TGT.Time_Zone = STAGE.Time_Zone, TGT.User_Expiration_Date = STAGE.User_Expiration_Date, TGT.User_Level = STAGE.User_Level, TGT.User_unique_ID = STAGE.User_unique_ID, TGT.Workday_ID = STAGE.Workday_ID, TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG::INT WHEN NOT MATCHED THEN  INSERT (  Username, Are_you_or_are_you_applying_to_be_an_inhome_caregiver, Branches, Business_Unit, Deactivated, Direct_Manager, Do_you_have_a_Home_Health_Certification, Email, Email_Address, Field_or_Admin, First_Name, First_Service_Date, Full_Name, Hire_Date, Hourly, Job_Level, Job_Title, Language, Last_Name, Location, Manager_Name, Payroll_ID, State, Term_Date, Time_Zone, User_Expiration_Date, User_Level, User_unique_ID, Workday_ID, ETL_TASK_KEY,  ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE,  ETL_LAST_UPDATED_BY,  ETL_DELETED_FLAG )  VALUES (STAGE.Username, STAGE.Are_you_or_are_you_applying_to_be_an_inhome_caregiver, STAGE.Branches, STAGE.Business_Unit, STAGE.Deactivated, STAGE.Direct_Manager, STAGE.Do_you_have_a_Home_Health_Certification, STAGE.Email, STAGE.Email_Address, STAGE.Field_or_Admin, STAGE.First_Name, STAGE.First_Service_Date, STAGE.Full_Name, STAGE.Hire_Date, STAGE.Hourly, STAGE.Job_Level, STAGE.Job_Title, STAGE.Language, STAGE.Last_Name, STAGE.Location, STAGE.Manager_Name, STAGE.Payroll_ID, STAGE.State, STAGE.Term_Date, STAGE.Time_Zone, STAGE.User_Expiration_Date, STAGE.User_Level, STAGE.User_unique_ID, STAGE.Workday_ID, STAGE.ETL_TASK_KEY,  STAGE.ETL_INSERTED_TASK_KEY, STAGE.ETL_INSERTED_DATE, STAGE.ETL_INSERTED_BY, STAGE.ETL_LAST_UPDATED_DATE,  STAGE.ETL_LAST_UPDATED_BY,  STAGE.ETL_DELETED_FLAG::INT );

    return ''Success'';
END;
';