resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_PATIENTCONTRACTSTATUSHISTORY" {
	name ="GET_PATIENTCONTRACTSTATUSHISTORY"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_PatientContractStatusHistory 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.PatientContractStatusHistory (SELECT t.$1 AS AgencyID, t.$2 AS PayerID, t.$3 AS UserID, t.$4 AS ContractPlacementLogID, t.$5 AS PatientID, t.$6 AS PlacementID, t.$7 AS Date, t.$8 AS Note, t.$9 AS ContractName, t.$10 AS UserName, t.$11 AS Reason, t.$12 AS PlacementInfo, t.$13 AS PlacementType, t.$14 AS ReasonID, t.$15 AS StatusID, t.$16 AS StatusName, t.$17 AS StatusChangeDate, t.$18 AS CreatedBy, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_PatientContractStatusHistory.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

