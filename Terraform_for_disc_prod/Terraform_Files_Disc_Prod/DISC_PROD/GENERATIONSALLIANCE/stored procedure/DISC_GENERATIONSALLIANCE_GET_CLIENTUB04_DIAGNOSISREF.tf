resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_CLIENTUB04_DIAGNOSISREF" {
	name ="GET_CLIENTUB04_DIAGNOSISREF"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_ClientUB04_DiagnosisRef 
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
    COPY INTO GENERATIONSALLIANCE.ClientUB04_DiagnosisRef FROM (SELECT t.$1 AS ClientID, t.$2 AS hcfaID, t.$3 AS DiagnosisCode1, t.$4 AS DiagnosisCode2, t.$5 AS DiagnosisCode3, t.$6 AS DiagnosisCode4, t.$7 AS DiagnosisCode5, t.$8 AS DiagnosisCode6, t.$9 AS DiagnosisCode7, t.$10 AS DiagnosisCode8, t.$11 AS SYS_CHANGE_VERSION, t.$12 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$12,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ClientUB04_DiagnosisRef.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ClientUB04_DiagnosisRef AS WITH curr_v AS (SELECT ClientID, hcfaID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ClientUB04_DiagnosisRef GROUP BY ClientID, hcfaID) SELECT t.* FROM GENERATIONSALLIANCE.ClientUB04_DiagnosisRef t INNER JOIN curr_v v ON t.ClientID = v.ClientID AND t.hcfaID = v.hcfaID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

