resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_TMP_SANTRAXVISIT" {
	name ="GET_TMP_SANTRAXVISIT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_tmp_SantraxVisit 
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
    COPY INTO GENERATIONSALLIANCE.tmp_SantraxVisit FROM (SELECT t.$1 AS SantraxVisitID, t.$2 AS scheduleId, t.$3 AS employeeTelephonyId, t.$4 AS clientTelephonyId, t.$5 AS logIn, t.$6 AS logOut, t.$7 AS clientFirstname, t.$8 AS clientLastname, t.$9 AS oldScheduleId, t.$10 AS clientOtherId, t.$11 AS staffFirstName, t.$12 AS staffLastName, t.$13 AS taskId, t.$14 AS Date, t.$15 AS Comments, t.$16 AS taskNote, t.$17 AS proposedStart, t.$18 AS proposedEnd, t.$19 AS clientChartId, t.$20 AS LocationId, t.$21 AS StaffMI, t.$22 AS StaffAgencyID, t.$23 AS StaffOtherID2, t.$24 AS StaffAPI, t.$25 AS StaffTeamID, t.$26 AS ClientMI, t.$27 AS ClientCustomID, t.$28 AS ClientNumber, t.$29 AS ClientAdmitType, t.$30 AS ActualDuration, t.$31 AS ProposedDuration, t.$32 AS AdjustedTimeIn, t.$33 AS AdjustedTimeOut, t.$34 AS AdjustedDuration, t.$35 AS Timezone, t.$36 AS Override, t.$37 AS PayTypeID, t.$38 AS PayQuantity, t.$39 AS BillTypeID, t.$40 AS InvoiceNumber, t.$41 AS HCPCSCode, t.$42 AS BillQuantity, t.$43 AS SYS_CHANGE_VERSION, t.$44 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$44,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tmp_SantraxVisit.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tmp_SantraxVisit AS WITH curr_v AS (SELECT SantraxVisitID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tmp_SantraxVisit GROUP BY SantraxVisitID) SELECT t.* FROM GENERATIONSALLIANCE.tmp_SantraxVisit t INNER JOIN curr_v v ON t.SantraxVisitID = v.SantraxVisitID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

