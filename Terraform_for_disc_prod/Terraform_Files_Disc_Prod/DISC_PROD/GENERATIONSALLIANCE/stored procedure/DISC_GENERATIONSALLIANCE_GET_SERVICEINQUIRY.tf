resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_SERVICEINQUIRY" {
	name ="GET_SERVICEINQUIRY"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_ServiceInquiry 
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
    COPY INTO GENERATIONSALLIANCE.ServiceInquiry FROM (SELECT t.$1 AS InqNo, t.$2 AS FirstName, t.$3 AS LastName, t.$4 AS Address1, t.$5 AS Address2, t.$6 AS City, t.$7 AS State, t.$8 AS Zip, t.$9 AS Email, t.$10 AS Phone, t.$11 AS AlternatePhone, t.$12 AS HeardThrough, t.$13 AS Relationship, t.$14 AS RecepientCity, t.$15 AS RecepientState, t.$16 AS RecepientZip, t.$17 AS RecepientLocation, t.$18 AS AssistanceNeeded, t.$19 AS Receptiveness, t.$20 AS HelpWithin, t.$21 AS SubmittedDate, t.$22 AS Imported, t.$23 AS Hidden, t.$24 AS BestTTC, t.$25 AS ReceipientFirstName, t.$26 AS ReceipientLastName, t.$27 AS Location, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ServiceInquiry.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ServiceInquiry AS WITH curr_v AS (SELECT InqNo, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ServiceInquiry GROUP BY InqNo) SELECT t.* FROM GENERATIONSALLIANCE.ServiceInquiry t INNER JOIN curr_v v ON t.InqNo = v.InqNo AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

