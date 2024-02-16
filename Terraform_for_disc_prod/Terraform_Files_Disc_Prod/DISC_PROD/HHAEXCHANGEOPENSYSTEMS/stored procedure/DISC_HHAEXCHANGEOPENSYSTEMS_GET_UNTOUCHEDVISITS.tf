resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_UNTOUCHEDVISITS" {
	name ="GET_UNTOUCHEDVISITS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_UntouchedVisits 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.UntouchedVisits (SELECT t.$1 AS AgencyID, t.$2 AS AdmissionID, t.$3 AS OfficePatientCode, t.$4 AS PatientName, t.$5 AS MedicaidNumber, t.$6 AS AltPatientID, t.$7 AS VisitDate, t.$8 AS ScheduleTime, t.$9 AS AideName, t.$10 AS AideCode, t.$11 AS Discipline, t.$12 AS VisitStatus, t.$13 AS VisitStatusText, t.$14 AS Billed, t.$15 AS ServiceCode, t.$16 AS CHHAName, t.$17 AS VisitTime, t.$18 AS PayRate, t.$19 AS ScheduledMins, t.$20 AS VisitMins, t.$21 AS VisitHrs, t.$22 AS CoordinatorName, t.$23 AS TimesheetRequire, t.$24 AS PayrateCode, t.$25 AS CreatedDate, t.$26 AS VendorInvoiceNumber, t.$27 AS VisitCreatedDate, t.$28 AS VisitModifiedDate, t.$29 AS VisitID, t.$30 AS OnHoldVisit, t.$31 AS MissedVisit, t.$32 AS CountyName, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_UntouchedVisits.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

