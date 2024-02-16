resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_VISITCONTRACTS_REPL" {
	name ="GET_VISITCONTRACTS_REPL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_VisitContracts_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VisitContracts_REPL (SELECT t.$1 AS AgencyID, t.$2 AS VisitContractID, t.$3 AS VisitID, t.$4 AS ContractID, t.$5 AS BillType, t.$6 AS Minutes, t.$7 AS Billed, t.$8 AS VisitRateID, t.$9 AS OTRateID, t.$10 AS TTRateID, t.$11 AS AdjMinutes, t.$12 AS AdmissionID, t.$13 AS PayerReferenceNumber, t.$14 AS OfficeID, t.$15 AS ClaimSubmissionType, t.$16 AS SubmissionUTCDate, t.$17 AS Authorizations, t.$18 AS BankedHours, t.$19 AS CreatedBy, t.$20 AS CreatedDate, t.$21 AS UpdatedBy, t.$22 AS UpdatedDate, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_VisitContracts_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

