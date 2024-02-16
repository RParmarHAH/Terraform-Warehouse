CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_INSERVICE_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_InService_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.InService_REPL (SELECT t.$1 AS AgencyID, t.$2 AS InServiceID, t.$3 AS Date, t.$4 AS Location, t.$5 AS Description, t.$6 AS LanguageID, t.$7 AS DisciplineID, t.$8 AS PayRateID, t.$9 AS Topics, t.$10 AS IsConfirmed, t.$11 AS DisciplineID2, t.$12 AS PayRateID2, t.$13 AS inserviceStartDate, t.$14 AS inserviceEndDate, t.$15 AS OfficeID, t.$16 AS InstructorText, t.$17 AS MaxAttendees, t.$18 AS TotalAttendees, t.$19 AS Createdby, t.$20 AS CreatedDate, t.$21 AS UpdatedBy, t.$22 AS UpdatedDate, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_InService_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;
';