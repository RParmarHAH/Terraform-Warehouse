CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_FACILITIES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_Facilities 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_Facilities FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Facility_Code, t.$8 AS Facility_Name, t.$9 AS Address, t.$10 AS Street_Name, t.$11 AS City, t.$12 AS STATE_CODE, t.$13 AS Zipcode, t.$14 AS Contact_Person, t.$15 AS Phone_Number, t.$16 AS Tax_ID, t.$17 AS Place_of_Service, t.$18 AS FACILITYCATG, t.$19 AS Facility_Type_Code, t.$20 AS From_Time, t.$21 AS Thru_Time, t.$22 AS Duration, t.$23 AS subtaxid_Number, t.$24 AS Claim_Option, t.$25 AS CB_Bill_After_Dischg, t.$26 AS Specialty_Code, t.$27 AS Work_Factor, t.$28 AS PE_Factor, t.$29 AS MP_Factor, t.$30 AS Statement_Form_Code, t.$31 AS Medicare_Number, t.$32 AS Medicaid_Number, t.$33 AS Blue_Cross_ID, t.$34 AS Commercial_ID, t.$35 AS Branch_ID_Number, t.$36 AS EMC_Site_Code, t.$37 AS Taxonomy_Code, t.$38 AS NPI, t.$39 AS RESIDENCY_CODES, t.$40 AS Last_Updated_Date, t.$41 AS CB_Swing_Bed, t.$42 AS CB_Include_Details, t.$43 AS CB_Create_Order_Req, t.$44 AS Fax_Number, t.$45 AS DDL_MPPR_Type, t.$46 AS MPPR_Locality_ID, t.$47 AS Time_Zone, t.$48 AS CB_DST_Not_Observed, t.$49 AS DDL_Urban_Rural, t.$50 AS CB_No_Pay_RAP, t.$51 AS CB_Dont_Cal_St_PDPM_OBRA, t.$52 AS CB_eMar_Requirements, t.$53 AS CB_eTar_Requirements, t.$54 AS CB_eIntervention_Require, t.$55 AS DEX_ROW_ID, t.$56 AS Main_Email, t.$57 AS Financial_Email, t.$58 AS Schedule_Email, t.$59 AS Clinical_Email, t.$60 AS SYS_CHANGE_VERSION, t.$61 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$61,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Facilities.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_Facilities AS WITH curr_v AS (SELECT Db, Facility_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Facilities GROUP BY Db, Facility_Code) SELECT t.* FROM CostalSyncData.HIST_CV_Facilities t INNER JOIN curr_v v ON t.Db = v.Db AND t.Facility_Code = v.Facility_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';