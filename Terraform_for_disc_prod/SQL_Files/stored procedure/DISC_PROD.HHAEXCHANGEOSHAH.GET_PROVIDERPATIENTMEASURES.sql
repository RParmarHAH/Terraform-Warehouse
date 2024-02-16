CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_PROVIDERPATIENTMEASURES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_ProviderPatientMeasures 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.ProviderPatientMeasures (SELECT t.$1 AS PatientMeasuresId, t.$2 AS AgencyID, t.$3 AS MeasureId, t.$4 AS PayerId, t.$5 AS ProviderTIN, t.$6 AS PatientId, t.$7 AS OfficeId, t.$8 AS Status, t.$9 AS Note, t.$10 AS CreatedBy, t.$11 AS CreatedDate, t.$12 AS UpdatedBy, t.$13 AS UpdatedDate, t.$14 AS CompletedBy, t.$15 AS CompletedDate, t.$16 AS IsDeleted, t.$17 AS GUID, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/  (PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ProviderPatientMeasures.*[.]csv.gz'' ,FILE_FORMAT => DISC_PROD.STAGE.MY_CSV_FORMAT)t);

    return ''Success'';
END;
';