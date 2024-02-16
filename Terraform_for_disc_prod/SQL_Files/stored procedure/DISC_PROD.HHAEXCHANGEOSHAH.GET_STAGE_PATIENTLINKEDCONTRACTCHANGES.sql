CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_STAGE_PATIENTLINKEDCONTRACTCHANGES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_stage_PatientLinkedContractChanges 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.stage_PatientLinkedContractChanges (SELECT t.$1 AS AgencyID, t.$2 AS ContractChangeID, t.$3 AS OfficeID, t.$4 AS PatientID, t.$5 AS PlacementID, t.$6 AS PayerID, t.$7 AS IsPrimaryContract, t.$8 AS AltPatientID, t.$9 AS StartDate, t.$10 AS SourceOfAdmissionID, t.$11 AS ServiceCodeID, t.$12 AS DischargeDate, t.$13 AS DischargeTo, t.$14 AS ActionDateUTC, t.$15 AS CreatedBy, t.$16 AS CreatedDate, t.$17 AS UpdatedBy, t.$18 AS UpdatedDate, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_stage_PatientLinkedContractChanges.*[.]csv.gz'') T);

    return ''Success'';
END;
';