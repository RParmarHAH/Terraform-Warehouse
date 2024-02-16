resource "snowflake_procedure" "DISC_SANDATAIMPORT_GET_SANDATA_VISITS" {
	name ="GET_SANDATA_VISITS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SandataImport.GET_Sandata_Visits 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_Visits FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS StaffFirstName, t.$4 AS StaffMI, t.$5 AS StaffLastName, t.$6 AS StaffAgencyID, t.$7 AS StaffOtherID2, t.$8 AS StaffAPI, t.$9 AS StaffTeamID, t.$10 AS ClientFirstName, t.$11 AS ClientMI, t.$12 AS ClientLastName, t.$13 AS ClientChartID, t.$14 AS ClientOtherID, t.$15 AS ClientCustomID, t.$16 AS ClientNumber, t.$17 AS ClientAdmitType, t.$18 AS LocationID, t.$19 AS Date, t.$20 AS ScheduleID, t.$21 AS OldSchedID, t.$22 AS EventID, t.$23 AS ServiceID, t.$24 AS TimeIn, t.$25 AS TimeOut, t.$26 AS ActualDuration, t.$27 AS ProposedStart, t.$28 AS ProposedEnd, t.$29 AS ProposedDuration, t.$30 AS AdjustedTimeIn, t.$31 AS AdjustedTimeOut, t.$32 AS AdjustedDuration, t.$33 AS Timezone, t.$34 AS Override, t.$35 AS TaskID, t.$36 AS TaskReadings, t.$37 AS Comments, LEFT(t.$38,4999) AS TaskNotes, t.$39 AS TaskNotesType, t.$40 AS ReasonCode, t.$41 AS ReasonCodeDescription, t.$42 AS MRN, t.$43 AS PayQuantity, t.$44 AS PayTypeID, t.$45 AS BillQuantity, t.$46 AS BillTypeID, t.$47 AS InvoiceNumber, t.$48 AS HCPCSCode, t.$49 AS Modifiers, t.$50 AS EventStatus, t.$51 AS EVVCall, t.$52 AS ManualConfirmation, t.$53 AS AdmissionID, t.$54 AS CreatedAt, t.$55 AS UpdatedAt, t.$56 AS HashedRowValues, t.$57 AS BatchId, t.$58 AS SYS_CHANGE_VERSION, t.$59 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$59,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_Visits.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_Visits AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_Visits GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_Visits t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

