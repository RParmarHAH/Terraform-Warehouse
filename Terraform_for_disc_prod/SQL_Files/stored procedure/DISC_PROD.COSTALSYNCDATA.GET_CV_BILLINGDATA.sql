CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_BILLINGDATA("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_Cv_BillingData 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_Cv_BillingData FROM (SELECT t.$1 AS Db, t.$2 AS Bill_Number, t.$3 AS Patient_Number, t.$4 AS Bill_Date, t.$5 AS Bill_Amount, t.$6 AS Payment_Amount, t.$7 AS Adjustment_Amount, t.$8 AS Billto_Status_Code, t.$9 AS Provider_Code, t.$10 AS Location_Code, t.$11 AS Plan_Code, t.$12 AS Bill_RecStat, t.$13 AS Bill_Row_Id, t.$14 AS Sequence_Number, t.$15 AS ProcCode, t.$16 AS Charge_Plan_Code, t.$17 AS Type_of_Service, t.$18 AS Service_Date, t.$19 AS Extended_Amount, t.$20 AS Charge_Adjustment, t.$21 AS unit_amount, t.$22 AS number_of_unit, t.$23 AS Charge_Post_Date, t.$24 AS Charge_RecStat, t.$25 AS Charge_Row_Id, t.$26 AS Pay_RecStat, t.$27 AS Payment_Number, t.$28 AS Payment_Plan_Code, t.$29 AS Paid_Amount, t.$30 AS Payment_Post_Date, t.$31 AS Payment_Code, t.$32 AS Payment_Date, t.$33 AS Approved_WriteOff_Amount, t.$34 AS Payment_Charge_Adjustment, t.$35 AS Pay_Row_Id, t.$36 AS Time_Translation_Code, t.$37 AS Hour_To_Unit_Factor, t.$38 AS Number_of_Hour, t.$39 AS RowId, t.$40 AS Claim_Status, t.$41 AS SYS_CHANGE_VERSION, t.$42 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$42,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_Cv_BillingData.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.Cv_BillingData AS WITH curr_v AS (SELECT RowId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_Cv_BillingData GROUP BY RowId) SELECT t.* FROM CostalSyncData.HIST_Cv_BillingData t INNER JOIN curr_v v ON t.RowId = v.RowId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';