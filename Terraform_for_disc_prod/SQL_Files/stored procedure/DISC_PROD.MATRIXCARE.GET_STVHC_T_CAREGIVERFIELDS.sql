CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_CAREGIVERFIELDS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_CaregiverFields 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverFields FROM (SELECT t.$1 AS carf_ID, t.$2 AS carf_BranchID, t.$3 AS carf_Name, t.$4 AS carf_TabID, t.$5 AS carf_RowNumber, t.$6 AS carf_ColNumber, t.$7 AS carf_FieldType, t.$8 AS carf_DefaultValue, t.$9 AS carf_CreatedUser, t.$10 AS carf_CreatedDate, t.$11 AS carf_ModifiedUser, t.$12 AS carf_ModifiedDate, t.$13 AS carf_TS, t.$14 AS carf_Active, t.$15 AS carf_NameID, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverFields.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverFields AS WITH curr_v AS (SELECT carf_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverFields GROUP BY carf_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverFields t INNER JOIN curr_v v ON t.carf_ID = v.carf_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';