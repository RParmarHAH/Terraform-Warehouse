CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_TBL_IMAGES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_tbl_images 
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
    COPY INTO GENERATIONSALLIANCE.tbl_images FROM (SELECT t.$1 AS int_imageid, t.$2 AS bin_image, t.$3 AS SYS_CHANGE_VERSION, t.$4 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$4,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tbl_images.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tbl_images AS WITH curr_v AS (SELECT int_imageid, bin_image, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tbl_images GROUP BY int_imageid, bin_image) SELECT t.* FROM GENERATIONSALLIANCE.tbl_images t INNER JOIN curr_v v ON t.int_imageid = v.int_imageid AND t.bin_image = v.bin_image AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';