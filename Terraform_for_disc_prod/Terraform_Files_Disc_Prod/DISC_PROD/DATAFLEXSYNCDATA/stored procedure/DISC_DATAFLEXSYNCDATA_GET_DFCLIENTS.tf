resource "snowflake_procedure" "DISC_DATAFLEXSYNCDATA_GET_DFCLIENTS" {
	name ="GET_DFCLIENTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.GET_DfClients 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.HIST_DfClients FROM (SELECT t.$1 AS DbName, t.$2 AS Number, t.$3 AS LastName, t.$4 AS FirstName, t.$5 AS MiddleName, t.$6 AS SSN, t.$7 AS OfficeNumber, t.$8 AS IsActive, t.$9 AS DOB, t.$10 AS Address1, t.$11 AS Address2, t.$12 AS City, t.$13 AS State, t.$14 AS Zip, t.$15 AS PhoneNumber, t.$16 AS BeginServiceDate, t.$17 AS EndServiceDate, t.$18 AS SupervisorCode, t.$19 AS Agency, t.$20 AS BillOffice, t.$21 AS BillHoliday, t.$22 AS ServiceArea, t.$23 AS Ethics, t.$24 AS Gender, t.$25 AS PhysicanNo, t.$26 AS PhysicanName, t.$27 AS IdoaId, t.$28 AS MedicaidNo, t.$29 AS ICD9Codes, t.$30 AS ICD10Codes, t.$31 AS DcnNumber, t.$32 AS Notes, t.$33 AS OnHoldStartDate, t.$34 AS OnHoldEndDate, t.$35 AS CreatedDate, t.$36 AS UpdateBatch, t.$37 AS UpdatedTime, t.$38 AS DateAdded, t.$39 AS DateChanged, t.$40 AS SYS_CHANGE_VERSION, t.$41 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$41,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfClients.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfClients AS WITH curr_v AS (SELECT DbName, Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfClients GROUP BY DbName, Number) SELECT t.* FROM DataFlexSyncData.HIST_DfClients t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.Number = v.Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

