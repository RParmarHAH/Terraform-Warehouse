CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_PLANOFCAREMEDICATIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PlanofCareMedications 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PlanofCareMedications FROM (SELECT t.$1 AS pocmed_ID, t.$2 AS pocmed_POCID, t.$3 AS pocmed_OrderDate, t.$4 AS pocmed_DiscontinueDate, t.$5 AS pocmed_NewChange, t.$6 AS pocmed_MedID, t.$7 AS pocmed_Dose, t.$8 AS pocmed_Amount, t.$9 AS pocmed_FrequencyID, t.$10 AS pocmed_RouteID, t.$11 AS pocmed_Hours_1, t.$12 AS pocmed_Hours_2, t.$13 AS pocmed_Hours_3, t.$14 AS pocmed_Hours_4, t.$15 AS pocmed_Hours_5, t.$16 AS pocmed_Hours_6, t.$17 AS pocmed_PhysicianID, t.$18 AS pocmed_Notes, t.$19 AS pocmed_CreatedDate, t.$20 AS pocmed_CreatedUser, t.$21 AS pocmed_ModifiedDate, t.$22 AS pocmed_ModifiedUser, t.$23 AS pocmed_TS, t.$24 AS pocmed_OasisMedName, t.$25 AS pocmed_Sequence, t.$26 AS pocmed_AssessmentID, t.$27 AS pocmed_GUID, t.$28 AS pocmed_Type, t.$29 AS InsertDate, t.$30 AS UpdateDate, t.$31 AS DeletedFlag, t.$32 AS SYS_CHANGE_VERSION, CASE WHEN t.$31 = True THEN ''D'' WHEN t.$29 = t.$30 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$31, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PlanofCareMedications.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PlanofCareMedications AS WITH curr_v AS (SELECT pocmed_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PlanofCareMedications GROUP BY pocmed_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PlanofCareMedications t INNER JOIN curr_v v ON t.pocmed_ID = v.pocmed_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';