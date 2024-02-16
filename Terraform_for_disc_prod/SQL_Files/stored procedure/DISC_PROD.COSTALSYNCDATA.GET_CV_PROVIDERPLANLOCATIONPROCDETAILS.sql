CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_PROVIDERPLANLOCATIONPROCDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_ProviderPlanLocationProcDetails 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_ProviderPlanLocationProcDetails FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Provider_Code, t.$4 AS Plan_Code, t.$5 AS Location_Code, t.$6 AS ProcCode, t.$7 AS Plan_Procedure_Code, t.$8 AS Plan_Proc_Description, t.$9 AS Charge_Amount82, t.$10 AS Approved_Amount82, t.$11 AS Use_Approved, t.$12 AS Charge_Adjustment, t.$13 AS Payment_Amount82, t.$14 AS Ppr_Payment_Method, t.$15 AS Print_App_Amt, t.$16 AS CB_Cert_Required, t.$17 AS Filler_69, t.$18 AS Entry_User, t.$19 AS Entry_Date, t.$20 AS Update_User, t.$21 AS Update_Date, t.$22 AS CRLF, t.$23 AS DDL_Charge_Amount_Source, t.$24 AS DDL_Approved_Amt_Source, t.$25 AS Approved_Amount_Discount, t.$26 AS DEX_ROW_ID, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_ProviderPlanLocationProcDetails.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_ProviderPlanLocationProcDetails AS WITH curr_v AS (SELECT Db, Provider_Code, Plan_Code, Location_Code, ProcCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_ProviderPlanLocationProcDetails GROUP BY Db, Provider_Code, Plan_Code, Location_Code, ProcCode) SELECT t.* FROM CostalSyncData.HIST_CV_ProviderPlanLocationProcDetails t INNER JOIN curr_v v ON t.Db = v.Db AND t.Provider_Code = v.Provider_Code AND t.Plan_Code = v.Plan_Code AND t.Location_Code = v.Location_Code AND t.ProcCode = v.ProcCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';