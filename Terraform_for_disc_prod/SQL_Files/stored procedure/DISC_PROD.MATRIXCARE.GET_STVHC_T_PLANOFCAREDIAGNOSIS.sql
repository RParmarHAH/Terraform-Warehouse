CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PLANOFCAREDIAGNOSIS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PlanofCareDiagnosis 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PlanofCareDiagnosis FROM (SELECT t.$1 AS pocdiag_ID, t.$2 AS pocdiag_POCID, t.$3 AS pocdiag_Sequence, t.$4 AS pocdiag_DiagnosisID, t.$5 AS pocdiag_DiagnosisDate, t.$6 AS pocdiag_OnsetExacerbation, t.$7 AS pocdiag_CreatedDate, t.$8 AS pocdiag_CreatedUser, t.$9 AS pocdiag_ModifiedDate, t.$10 AS pocdiag_ModifiedUser, t.$11 AS pocdiag_TS, t.$12 AS pocdiag_DiagnosisDateStr, t.$13 AS pocdiag_Version, t.$14 AS pocdiag_OriginalCodeID, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PlanofCareDiagnosis.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PlanofCareDiagnosis AS WITH curr_v AS (SELECT pocdiag_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PlanofCareDiagnosis GROUP BY pocdiag_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PlanofCareDiagnosis t INNER JOIN curr_v v ON t.pocdiag_ID = v.pocdiag_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';