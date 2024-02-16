resource "snowflake_procedure" "DISC_SANDATAIMPORT_GET_SANDATA_AUTHORIZATIONS" {
	name ="GET_SANDATA_AUTHORIZATIONS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SandataImport.GET_Sandata_Authorizations 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_Authorizations FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS AuthID, t.$4 AS AdmissionID, t.$5 AS PeriodID, t.$6 AS PayorID, t.$7 AS ServiceID, t.$8 AS EventID, t.$9 AS Modifier1, t.$10 AS Modifer2, t.$11 AS Modifer3, t.$12 AS Modifer4, t.$13 AS AuthRefNo, t.$14 AS Format, t.$15 AS DateBegin, t.$16 AS DateEnd, t.$17 AS Maximum, t.$18 AS Comments, t.$19 AS LimitType, t.$20 AS PeriodLimit, t.$21 AS LimitDay1, t.$22 AS TBDay1, t.$23 AS TEDay1, t.$24 AS LimitDay2, t.$25 AS TBDay2, t.$26 AS TEDay2, t.$27 AS LimitDay3, t.$28 AS TBDay3, t.$29 AS TEDay3, t.$30 AS LimitDay4, t.$31 AS TBDay4, t.$32 AS TEDay4, t.$33 AS LimitDay5, t.$34 AS TBDay5, t.$35 AS TEDay5, t.$36 AS LimitDay6, t.$37 AS TBDay6, t.$38 AS TEDay6, t.$39 AS LimitDay7, t.$40 AS TBDay7, t.$41 AS TEDay7, t.$42 AS CreatedAt, t.$43 AS UpdatedAt, t.$44 AS HashedRowValues, t.$45 AS BatchId, t.$46 AS AuthVoided, t.$47 AS SYS_CHANGE_VERSION, t.$48 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$48,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_Authorizations.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_Authorizations AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_Authorizations GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_Authorizations t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

