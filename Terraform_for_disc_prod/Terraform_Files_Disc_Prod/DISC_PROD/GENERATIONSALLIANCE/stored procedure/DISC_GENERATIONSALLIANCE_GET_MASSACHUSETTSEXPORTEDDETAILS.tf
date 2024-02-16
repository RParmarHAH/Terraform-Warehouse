resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_MASSACHUSETTSEXPORTEDDETAILS" {
	name ="GET_MASSACHUSETTSEXPORTEDDETAILS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_MassachusettsExportedDetails 
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
    COPY INTO GENERATIONSALLIANCE.MassachusettsExportedDetails FROM (SELECT t.$1 AS ExportedDetailsID, t.$2 AS ExportedID, t.$3 AS MassHealthID, t.$4 AS SIMSConsumerID, t.$5 AS ProviderFEINNumber, t.$6 AS WorkerID, t.$7 AS WorkerFirstName, t.$8 AS WorkerMiddleInitial, t.$9 AS WorkerLastName, t.$10 AS AssociatedASAP, t.$11 AS ConsumerFirstName, t.$12 AS ConsumerMiddleInitial, t.$13 AS ConsumerLastName, t.$14 AS VisitIdentifier, t.$15 AS VisitRecordingMethod, t.$16 AS ElectronicVerificationMethodType, t.$17 AS VisitRecordUploadStatus, t.$18 AS Non_ElectronicVerificationVisitReason, t.$19 AS ServiceBeginDate, t.$20 AS ServiceBeginTime, t.$21 AS ServiceEndDate, t.$22 AS ServiceEndTime, t.$23 AS ServiceBeginGPSLatitude, t.$24 AS ServiceBeginGPSLongitude, t.$25 AS ServiceEndGPSLatitude, t.$26 AS ServiceEndGPSLongitude, t.$27 AS CareProgram, t.$28 AS HCPCSCode, t.$29 AS BillableMinutes, t.$30 AS ServiceAddressLine1, t.$31 AS ServiceAddressLine2, t.$32 AS ServiceAddressCity, t.$33 AS ServiceAddressState, t.$34 AS ServiceAddressZip, t.$35 AS ServiceBeginPhoneNumber, t.$36 AS ServiceEndPhoneNumber, t.$37 AS ResourceID, t.$38 AS AssociatedOrganization, t.$39 AS DateOfBirth, t.$40 AS HCPCSModifier, t.$41 AS TypeofServiceProvided, t.$42 AS MeditechID, t.$43 AS BillableUnits, t.$44 AS SYS_CHANGE_VERSION, t.$45 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$45,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_MassachusettsExportedDetails.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.MassachusettsExportedDetails AS WITH curr_v AS (SELECT ExportedDetailsID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.MassachusettsExportedDetails GROUP BY ExportedDetailsID) SELECT t.* FROM GENERATIONSALLIANCE.MassachusettsExportedDetails t INNER JOIN curr_v v ON t.ExportedDetailsID = v.ExportedDetailsID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

