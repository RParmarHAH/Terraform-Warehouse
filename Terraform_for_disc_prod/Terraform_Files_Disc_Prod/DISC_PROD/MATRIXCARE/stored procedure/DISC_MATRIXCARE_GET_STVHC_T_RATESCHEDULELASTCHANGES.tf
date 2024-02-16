resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_RATESCHEDULELASTCHANGES" {
	name ="GET_STVHC_T_RATESCHEDULELASTCHANGES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_RateScheduleLastChanges 
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
    COPY INTO MatrixCare.HIST_STVHC_T_RateScheduleLastChanges FROM (SELECT t.$1 AS schID, t.$2 AS schExpID, t.$3 AS BillArgs, t.$4 AS PayArgs, t.$5 AS BranchID, t.$6 AS ClientID, t.$7 AS AdmissionID, t.$8 AS CaregiverID, t.$9 AS ClientRegionID, t.$10 AS CaregiverRegionID, t.$11 AS ServiceCodeID, t.$12 AS PrimPayerID, t.$13 AS BillUnits, t.$14 AS PayUnits, t.$15 AS BillFlagSource, t.$16 AS PayFlagSource, t.$17 AS BillFlag, t.$18 AS PayFlag, t.$19 AS BillUnitFlag, t.$20 AS PayUnitFlag, t.$21 AS PayerSource, t.$22 AS BillRate, t.$23 AS PayRate, t.$24 AS BillRateID, t.$25 AS BillRateSource, t.$26 AS BillRateOvrdSeq, t.$27 AS PayRateID, t.$28 AS PayRateSource, t.$29 AS PayRateOvrdSeq, t.$30 AS ScheduleStart, t.$31 AS scheduleBillEnd, t.$32 AS schedulePayEnd, t.$33 AS ResolvedBillFlag, t.$34 AS ResolvedPayFlag, t.$35 AS ScheduleStatus, t.$36 AS BillExcludeHolidays, t.$37 AS PayExcludeHolidays, t.$38 AS BillByShift, t.$39 AS AddonRateID, t.$40 AS AddonRateSource, t.$41 AS PayHolidayID, t.$42 AS BillHolidayID, t.$43 AS isBilled, t.$44 AS isPaid, t.$45 AS TotalBillAmount, t.$46 AS TotalPayAmount, t.$47 AS Margin, t.$48 AS IsService, t.$49 AS IsMultiService, t.$50 AS rateDriverProcessLogID, t.$51 AS cs_all, t.$52 AS PayOrBillFlag, t.$53 AS rslc_TotalOTAmount, t.$54 AS OT_CalcRates, t.$55 AS InsertDate, t.$56 AS UpdateDate, t.$57 AS DeletedFlag, t.$58 AS SYS_CHANGE_VERSION, CASE WHEN t.$57 = True THEN ''D'' WHEN t.$55 = t.$56 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$57, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_RateScheduleLastChanges.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_RateScheduleLastChanges AS WITH curr_v AS (SELECT schID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_RateScheduleLastChanges GROUP BY schID) ,EXCLUDE_LIST AS ( SELECT DISTINCT BRANCHID FROM MatrixCare.HIST_STVHC_T_RateScheduleLastChanges  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_RateScheduleLastChanges t INNER JOIN curr_v v ON t.schID = v.schID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.BRANCHID NOT IN (SELECT BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

