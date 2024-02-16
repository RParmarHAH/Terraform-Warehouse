resource "snowflake_procedure" "DISC_DATAFLEXSYNCDATA_GET_DFEMPLOYEES" {
	name ="GET_DFEMPLOYEES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.GET_DfEmployees 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-12-08		Komal Dhokai			Updated TargetSQL
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.HIST_DfEmployees FROM (SELECT t.$1 AS DbName, t.$2 AS Number, t.$3 AS LastName, t.$4 AS FirstName, t.$5 AS MiddleName, t.$6 AS SSN, t.$7 AS PayrollId, t.$8 AS OfficeNumber, t.$9 AS IsActive, t.$10 AS DOB, t.$11 AS Address1, t.$12 AS Address2, t.$13 AS City, t.$14 AS State, t.$15 AS Zip, t.$16 AS PhoneNumber, t.$17 AS HireDate, t.$18 AS TerminateDate, t.$19 AS AbleToRehire, t.$20 AS Department, t.$21 AS Gender, t.$22 AS Ethics, t.$23 AS PayrollIdIndexNo, t.$24 AS LastCheckDate, t.$25 AS CreatedDate, t.$26 AS UpdateBatch, t.$27 AS UpdatedTime, t.$28 AS DateAdded, t.$29 AS DateChanged,t.$30 AS FamilyCaregiver, t.$31 AS Email, t.$32 AS CellPhoneNumber, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/ (PATTERN => ''.*DataFlexSyncData_dbo_DfEmployees.*[.]csv.gz'', FILE_FORMAT =>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) T);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfEmployees AS WITH curr_v AS (SELECT DbName, Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfEmployees GROUP BY DbName, Number) SELECT t.* FROM DataFlexSyncData.HIST_DfEmployees t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.Number = v.Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

