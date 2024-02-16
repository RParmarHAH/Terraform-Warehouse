CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_SERVICECATEGORYCODES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_ServiceCategoryCodes 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_ServiceCategoryCodes FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Service_Category_Code, t.$8 AS Service_Catg_Code_Desc, t.$9 AS DDL_Service_Catg_Type, t.$10 AS ProcCode, t.$11 AS Pay_Rate, t.$12 AS CB_Split_Schedule, t.$13 AS CB_Weekend_Crossover, t.$14 AS CB_Holiday_Crossover, t.$15 AS DDL_Visit_Bill_Type, t.$16 AS DDL_Visit_Pay_Type, t.$17 AS Billable_Conv_Factor, t.$18 AS Payable_Conv_Factor, t.$19 AS Discipline_Code, t.$20 AS DDL_Split_Schedule, t.$21 AS CB_Schedule_By_Date, t.$22 AS CB_PR_Shift_Cross_Over, t.$23 AS CB_PR_Weekend_Cross_Over, t.$24 AS CB_PR_Holiday_Cross_Over, t.$25 AS OT_Service_Category, t.$26 AS CB_Exclude_Overtime, t.$27 AS CB_Flat, t.$28 AS Vist_Productivity_Factor, t.$29 AS CB_Bonus, t.$30 AS CB_Exclude_For_Bonus_Uni, t.$31 AS Weekend_Payrate, t.$32 AS Holiday_Type_Arr3_1, t.$33 AS Holiday_Type_Arr3_2, t.$34 AS Holiday_Type_Arr3_3, t.$35 AS Holiday_Payrate_Arr3_1, t.$36 AS Holiday_Payrate_Arr3_2, t.$37 AS Holiday_Payrate_Arr3_3, t.$38 AS Weekend_Procedure, t.$39 AS Holiday_Procedure_Arr3_1, t.$40 AS Holiday_Procedure_Arr3_2, t.$41 AS Holiday_Procedure_Arr3_3, t.$42 AS CB_Allow_Dup_SVC_Sch, t.$43 AS CB_Check_Cln_Note_Status, t.$44 AS DDL_Service_Catg_Status, t.$45 AS Inactivated_Date, t.$46 AS DEX_ROW_ID, t.$47 AS SYS_CHANGE_VERSION, t.$48 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$48,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_ServiceCategoryCodes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_ServiceCategoryCodes AS WITH curr_v AS (SELECT Db, Service_Category_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_ServiceCategoryCodes GROUP BY Db, Service_Category_Code) SELECT t.* FROM CostalSyncData.HIST_CV_ServiceCategoryCodes t INNER JOIN curr_v v ON t.Db = v.Db AND t.Service_Category_Code = v.Service_Category_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';