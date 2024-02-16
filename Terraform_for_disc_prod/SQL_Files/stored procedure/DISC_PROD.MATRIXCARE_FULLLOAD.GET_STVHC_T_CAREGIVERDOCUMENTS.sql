CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_CAREGIVERDOCUMENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_CaregiverDocuments 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverDocuments FROM (SELECT t.$1 AS cardoc_ID, t.$2 AS cardoc_CaregiverID, t.$3 AS cardoc_TypeID, t.$4 AS cardoc_Format, t.$5 AS cardoc_FileName, t.$6 AS cardoc_FileSize, t.$7 AS cardoc_Notes, t.$8 AS cardoc_Sharelevel, t.$9 AS cardoc_CreatedDate, t.$10 AS cardoc_CreatedUser, t.$11 AS cardoc_ModifiedDate, t.$12 AS cardoc_ModifiedUser, t.$13 AS cardoc_TS, t.$14 AS cardoc_isCompressed, t.$15 AS cardoc_SubTypeID, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverDocuments.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverDocuments AS WITH curr_v AS (SELECT cardoc_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverDocuments GROUP BY cardoc_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverDocuments t INNER JOIN curr_v v ON t.cardoc_ID = v.cardoc_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';