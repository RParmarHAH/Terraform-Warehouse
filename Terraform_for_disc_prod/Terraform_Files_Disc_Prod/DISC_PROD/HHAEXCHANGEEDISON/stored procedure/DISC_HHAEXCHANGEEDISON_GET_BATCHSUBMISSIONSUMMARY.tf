resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_BATCHSUBMISSIONSUMMARY" {
	name ="GET_BATCHSUBMISSIONSUMMARY"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_BatchSubmissionSummary 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.BatchSubmissionSummary (SELECT t.$1 AS AgencyID, t.$2 AS BatchID, t.$3 AS PayerID, t.$4 AS PayerName, t.$5 AS BatchNumber, t.$6 AS BatchDate, t.$7 AS CreatedDate, t.$8 AS LastExportDate, t.$9 AS ClaimTypeText, t.$10 AS OfficeID, t.$11 AS OfficeCode, t.$12 AS TotalNumberOfClaims, t.$13 AS TotalAmountWO3rdParty, t.$14 AS TotalAmountFor3rdParty, t.$15 AS SYS_CHANGE_VERSION, t.$16 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$16,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_BatchSubmissionSummary.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

