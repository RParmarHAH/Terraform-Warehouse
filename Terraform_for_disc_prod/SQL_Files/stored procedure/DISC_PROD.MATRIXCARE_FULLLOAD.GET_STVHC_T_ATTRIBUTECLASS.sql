CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_ATTRIBUTECLASS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_AttributeClass 
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
    COPY INTO MatrixCare.HIST_STVHC_T_AttributeClass FROM (SELECT t.$1 AS atrcl_ID, t.$2 AS atrcl_Name, t.$3 AS atrcl_Seq, t.$4 AS atrcl_Active, t.$5 AS atrcl_CreatedDate, t.$6 AS atrcl_CreatedUser, t.$7 AS atrcl_ModifiedDate, t.$8 AS atrcl_ModifiedUser, t.$9 AS atrcl_TS, t.$10 AS atrcl_ListItemType, t.$11 AS atrcl_RptGroupID, t.$12 AS atrcl_BranchID, t.$13 AS atrcl_OverrideID, t.$14 AS atrcl_Description, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_AttributeClass.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_AttributeClass AS WITH curr_v AS (SELECT atrcl_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_AttributeClass GROUP BY atrcl_ID),EXCLUDE_LIST AS ( SELECT DISTINCT ATRCL_BRANCHID FROM MatrixCare.HIST_STVHC_T_AttributeClass br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.ATRCL_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'')  SELECT t.* FROM MatrixCare.HIST_STVHC_T_AttributeClass t INNER JOIN curr_v v ON t.atrcl_ID = v.atrcl_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.ATRCL_BRANCHID,-1) NOT IN (SELECT ATRCL_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';