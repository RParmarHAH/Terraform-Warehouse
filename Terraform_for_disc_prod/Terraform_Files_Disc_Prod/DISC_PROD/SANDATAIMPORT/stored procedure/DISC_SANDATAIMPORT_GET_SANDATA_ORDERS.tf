resource "snowflake_procedure" "DISC_SANDATAIMPORT_GET_SANDATA_ORDERS" {
	name ="GET_SANDATA_ORDERS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SandataImport.GET_Sandata_Orders 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_Orders FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS OrderID, t.$4 AS admissionID, t.$5 AS periodID, t.$6 AS AdmissionServiceID, t.$7 AS EffectiveDate, t.$8 AS Frequency, t.$9 AS OrderInstructions, t.$10 AS OrderDocumentType, t.$11 AS CreatedAt, t.$12 AS UpdatedAt, t.$13 AS HashedRowValues, t.$14 AS BatchId, t.$15 AS SYS_CHANGE_VERSION, t.$16 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$16,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_Orders.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_Orders AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_Orders GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_Orders t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

