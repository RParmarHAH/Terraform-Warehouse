CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_REFERRALFACILITIES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_ReferralFacilities 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ReferralFacilities FROM (SELECT t.$1 AS reffac_ID, t.$2 AS reffac_StatusID, t.$3 AS reffac_Receptionist, t.$4 AS reffac_Zone, t.$5 AS reffac_Rank, t.$6 AS reffac_ReferralRatingID, t.$7 AS reffac_ParentID, t.$8 AS reffac_ReferralTerritoryID, t.$9 AS reffac_ReferralTypeID, t.$10 AS refc_OldID, t.$11 AS reffac_InitialContact, t.$12 AS InsertDate, t.$13 AS UpdateDate, t.$14 AS DeletedFlag, t.$15 AS SYS_CHANGE_VERSION, CASE WHEN t.$14 = True THEN ''D'' WHEN t.$12 = t.$13 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$14, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ReferralFacilities[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ReferralFacilities AS WITH curr_v AS (SELECT reffac_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ReferralFacilities GROUP BY reffac_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ReferralFacilities t INNER JOIN curr_v v ON t.reffac_ID = v.reffac_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';