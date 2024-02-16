CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_TELEPHONYCALLS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_TelephonyCalls 
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
    COPY INTO MatrixCare.HIST_STVHC_T_TelephonyCalls FROM (SELECT t.$1 AS tcl_ID, t.$2 AS tcl_TelephonyAccountID, t.$3 AS tcl_Purpose, t.$4 AS tcl_CaregiverTelephonyID, t.$5 AS tcl_CaregiverID, t.$6 AS tcl_CaregiverMatchStatus, t.$7 AS tcl_ClientID, t.$8 AS tcl_BranchID, t.$9 AS tcl_ClientMatchStatus, t.$10 AS tcl_PhoneNumber, t.$11 AS tcl_ServerCallID, t.$12 AS tcl_CallTime, t.$13 AS tcl_Status, t.$14 AS tcl_ScheduleID, t.$15 AS tcl_Completed, t.$16 AS tcl_CreatedDate, t.$17 AS tcl_Hidden, t.$18 AS tcl_ClientTelephonyID, t.$19 AS tcl_Flags, t.$20 AS tcl_Overflow, t.$21 AS tcl_ClientNameList, t.$22 AS tcl_Location, t.$23 AS tcl_Accuracy, t.$24 AS tcl_EventType, t.$25 AS tcl_Overridden, t.$26 AS tcl_ClientLocation, t.$27 AS tcl_CertifyCorrect, t.$28 AS tcl_CertifyNotes, t.$29 AS tcl_OverrideTime, t.$30 AS tcl_OverrideTimeUtcOffset, t.$31 AS tcl_OverrideTimeZoneID, t.$32 AS tcl_MachineIPAddress, t.$33 AS InsertDate, t.$34 AS UpdateDate, t.$35 AS DeletedFlag, t.$36 AS SYS_CHANGE_VERSION, CASE WHEN t.$35 = True THEN ''D'' WHEN t.$33 = t.$34 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$35, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_TelephonyCalls.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_TelephonyCalls AS WITH curr_v AS (SELECT tcl_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_TelephonyCalls GROUP BY tcl_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_TelephonyCalls t INNER JOIN curr_v v ON t.tcl_ID = v.tcl_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';