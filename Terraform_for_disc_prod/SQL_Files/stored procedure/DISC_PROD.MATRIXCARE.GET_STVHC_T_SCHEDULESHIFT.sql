CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_SCHEDULESHIFT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_ScheduleShift 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ScheduleShift FROM (SELECT t.$1 AS schsh_ID, t.$2 AS schsh_ScheduleID, t.$3 AS schsh_ExpenseID, t.$4 AS schsh_StartTime, t.$5 AS schsh_EndTime, t.$6 AS schsh_No, t.$7 AS schsh_HollidayID, t.$8 AS schsh_HollidayAdd, t.$9 AS schsh_HollidayMult, t.$10 AS schsh_Rate, t.$11 AS schsh_RateID, t.$12 AS schsh_Unit, t.$13 AS schsh_UnitFlag, t.$14 AS schsh_RateSource, t.$15 AS schsh_OTUnit, t.$16 AS schsh_OTMulti, t.$17 AS schsh_Balance, t.$18 AS schsh_DraftID, t.$19 AS schsh_ContractRate, t.$20 AS schsh_ContractRateSource, t.$21 AS schsh_ContractRateID, t.$22 AS schsh_COBInvoiceID, t.$23 AS schsh_SchedulePayersChecksum, t.$24 AS schsh_ManageCOB, t.$25 AS schsh_OTRate, t.$26 AS schsh_OTCalcType, t.$27 AS schsh_OTRateSource, t.$28 AS schsh_OTUnitsSubtract, t.$29 AS schsh_TotalCharge, t.$30 AS schsh_ServiceCodeId, t.$31 AS schsh_ScheduleServiceId, t.$32 AS schsh_BatchId, t.$33 AS schsh_CreatedDate, t.$34 AS schsh_Sequence, t.$35 AS schsh_ShiftCount, t.$36 AS InsertDate, t.$37 AS UpdateDate, t.$38 AS DeletedFlag, t.$39 AS SYS_CHANGE_VERSION, CASE WHEN t.$38 = True THEN ''D'' WHEN t.$36 = t.$37 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$38, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ScheduleShift[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ScheduleShift AS WITH curr_v AS (SELECT schsh_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ScheduleShift GROUP BY schsh_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ScheduleShift t INNER JOIN curr_v v ON t.schsh_ID = v.schsh_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';