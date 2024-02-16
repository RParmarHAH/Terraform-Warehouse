CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_MDPRVCDE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_MDPRVCDE 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_MDPRVCDE FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Provider_Code, t.$8 AS Last_Name, t.$9 AS Employer_Id_Number, t.$10 AS First_Name, t.$11 AS Middle_Initial, t.$12 AS Specialty_Code, t.$13 AS Provider_Category, t.$14 AS Practice_Name, t.$15 AS Address, t.$16 AS City, t.$17 AS STATE_CODE, t.$18 AS Zipcode, t.$19 AS Phone_Number, t.$20 AS Contact_Person, t.$21 AS Emergency_Phone, t.$22 AS Phone_Commentt, t.$23 AS Degree, t.$24 AS Social_Security_Number, t.$25 AS Tax_ID, t.$26 AS Form_Code, t.$27 AS Statrt_Date, t.$28 AS End__Date, t.$29 AS Payee_Code, t.$30 AS Provider_Unit_Rate, t.$31 AS Medicare_Number, t.$32 AS Medicaid_Number, t.$33 AS Blue_Cross_ID, t.$34 AS Other_Provider_ID, t.$35 AS Note_40, t.$36 AS Taxid_Type, t.$37 AS EMC_Site_Code, t.$38 AS Taxonomy_Code, t.$39 AS Email, t.$40 AS NPI, t.$41 AS DEA, t.$42 AS Fax_Number, t.$43 AS Work_Phone, t.$44 AS Cell_Phone, t.$45 AS Beeper_Number, t.$46 AS Home_Phone, t.$47 AS CB_SQL_Upgrade_01, t.$48 AS CB_NPI, t.$49 AS CB_PECOS, t.$50 AS NPI_Date, t.$51 AS PECOS_Date, t.$52 AS Last_Checked_Date, t.$53 AS DEX_ROW_ID, t.$54 AS SYS_CHANGE_VERSION, t.$55 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$55,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_MDPRVCDE.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_MDPRVCDE AS WITH curr_v AS (SELECT Db, Provider_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_MDPRVCDE GROUP BY Db, Provider_Code) SELECT t.* FROM CostalSyncData.HIST_CV_MDPRVCDE t INNER JOIN curr_v v ON t.Db = v.Db AND t.Provider_Code = v.Provider_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';