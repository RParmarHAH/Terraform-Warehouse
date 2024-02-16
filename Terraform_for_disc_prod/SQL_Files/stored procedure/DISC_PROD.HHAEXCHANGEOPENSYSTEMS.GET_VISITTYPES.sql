CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_VISITTYPES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_VisitTypes 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.VisitTypes (SELECT t.$1 AS AgencyID, t.$2 AS VisitTypeID, t.$3 AS Name, t.$4 AS Abbreviation, t.$5 AS Description, t.$6 AS Status, t.$7 AS AgencyType, t.$8 AS CreatedBy, t.$9 AS CreatedDate, t.$10 AS CreatedUTCDate, t.$11 AS UpdatedBy, t.$12 AS UpdatedDate, t.$13 AS UpdatedUTCDate, t.$14 AS DocTypeID, t.$15 AS DocSubTypeID, t.$16 AS MasterVisitTypeID, t.$17 AS WithMDOrder, t.$18 AS VisitTypeName, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_VisitTypes.*[.]csv.gz'') T);

    return ''Success'';
END;
';