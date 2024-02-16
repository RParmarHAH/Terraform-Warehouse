CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_FACILITYTYPES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_FacilityTypes 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_FacilityTypes FROM (SELECT t.$1 AS Db, t.$2 AS Facility_Type_Code, t.$3 AS Facility_Type_Desc, t.$4 AS Filler_31, t.$5 AS Entry_User, t.$6 AS Entry_Date, t.$7 AS Update_User, t.$8 AS Update_Date, t.$9 AS CRLF, t.$10 AS DEX_ROW_ID, t.$11 AS SYS_CHANGE_VERSION, t.$12 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$12,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_FacilityTypes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_FacilityTypes AS WITH curr_v AS (SELECT Db, Facility_Type_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_FacilityTypes GROUP BY Db, Facility_Type_Code) SELECT t.* FROM CostalSyncData.HIST_CV_FacilityTypes t INNER JOIN curr_v v ON t.Db = v.Db AND t.Facility_Type_Code = v.Facility_Type_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';