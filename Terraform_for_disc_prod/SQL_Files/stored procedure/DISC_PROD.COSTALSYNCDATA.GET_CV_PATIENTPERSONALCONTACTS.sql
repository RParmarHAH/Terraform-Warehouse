CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_PATIENTPERSONALCONTACTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_PatientPersonalContacts 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_PatientPersonalContacts FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Patient_Number, t.$8 AS Sequence_Number, t.$9 AS First_Name, t.$10 AS Middle_Initial, t.$11 AS Last_Name, t.$12 AS RLNSHIP__CODE, t.$13 AS Next_of_Kin, t.$14 AS Primary_Caregiver, t.$15 AS Emergency, t.$16 AS CB_Responsible_Party, t.$17 AS CB_Secondary_Responsible, t.$18 AS Power_of_Attorney, t.$19 AS Same_Address, t.$20 AS Address_1, t.$21 AS Address_2, t.$22 AS City, t.$23 AS STATE_CODE, t.$24 AS Zipcode, t.$25 AS Phone_Number, t.$26 AS Work_Phone, t.$27 AS Beeper_Code, t.$28 AS Beeper_Number, t.$29 AS Fax_Number, t.$30 AS E_Mail_Address, t.$31 AS Bereavement, t.$32 AS Risk_Score, t.$33 AS Employer_Code, t.$34 AS Contact_Person, t.$35 AS Contact_Phone, t.$36 AS Extension_Number, t.$37 AS Statrt_Date, t.$38 AS Remark, t.$39 AS Social_Security_Number, t.$40 AS Birth_Date, t.$41 AS Sex, t.$42 AS Salute, t.$43 AS Personal_Contact_Type_Cd, t.$44 AS CB_Willing_To_Prvde_Care, t.$45 AS CB_Ability_To_Prvde_Care, t.$46 AS CB_Avail_To_Provide_Care, t.$47 AS DEX_ROW_ID, t.$48 AS Pat_Sch_Contact_Notes, t.$49 AS SYS_CHANGE_VERSION, t.$50 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$50,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PatientPersonalContacts.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_PatientPersonalContacts AS WITH curr_v AS (SELECT Db, Patient_Number, Sequence_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PatientPersonalContacts GROUP BY Db, Patient_Number, Sequence_Number) SELECT t.* FROM CostalSyncData.HIST_CV_PatientPersonalContacts t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Sequence_Number = v.Sequence_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';