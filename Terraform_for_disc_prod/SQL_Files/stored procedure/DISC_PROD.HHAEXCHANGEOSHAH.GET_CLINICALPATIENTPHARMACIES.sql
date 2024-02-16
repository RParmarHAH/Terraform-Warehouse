CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CLINICALPATIENTPHARMACIES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_ClinicalPatientPharmacies 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.ClinicalPatientPharmacies (SELECT t.$1 AS AgencyID, t.$2 AS PatientPharmacyId, t.$3 AS Name, t.$4 AS PatientId, t.$5 AS PhoneNumber, t.$6 AS FaxNumber, t.$7 AS Address1, t.$8 AS Address2, t.$9 AS City, t.$10 AS State, t.$11 AS Zip, t.$12 AS CreatedDate, t.$13 AS CreatedBy, t.$14 AS UpdatedDate, t.$15 AS UpdatedBy, t.$16 AS CreatedDateUTC, t.$17 AS UpdatedDateUTC, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ClinicalPatientPharmacies.*[.]csv.gz'') T);

    return ''Success'';
END;
';