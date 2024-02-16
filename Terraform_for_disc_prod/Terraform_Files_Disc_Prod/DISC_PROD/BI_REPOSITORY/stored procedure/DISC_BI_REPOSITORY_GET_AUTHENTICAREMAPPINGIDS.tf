resource "snowflake_procedure" "DISC_BI_REPOSITORY_GET_AUTHENTICAREMAPPINGIDS" {
	name ="GET_AUTHENTICAREMAPPINGIDS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.BI_Repository.GET_AuthenticareMappingIDs 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.BI_Repository.AuthenticareMappingIDs (SELECT t.$1 AS SysID, t.$2 AS LocSys, t.$3 AS Typ, t.$4 AS DBName, t.$5 AS IntID, t.$6 AS IntIDStr, t.$7 AS LstNam, t.$8 AS FstNam, t.$9 AS MdlNam, t.$10 AS ExtSysID, t.$11 AS ExtIDTyp, t.$12 AS ExtID, t.$13 AS EffBegDat, t.$14 AS EffEndDat, t.$15 AS Updated, t.$16 AS Ignore, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/BI_REPOSITORY/ (PATTERN => ''.*BI_Repository_dbo_AuthenticareMappingIDs.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    return ''Success'';
END;

 EOT
}

