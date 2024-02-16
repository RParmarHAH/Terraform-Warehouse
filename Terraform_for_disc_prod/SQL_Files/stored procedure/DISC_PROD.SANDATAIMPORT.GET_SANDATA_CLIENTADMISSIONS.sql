CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAIMPORT.GET_SANDATA_CLIENTADMISSIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SandataImport.GET_Sandata_ClientAdmissions 
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
    COPY INTO DISC_PROD.SandataImport.HIST_Sandata_ClientAdmissions FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS admissionID, t.$4 AS clientID, t.$5 AS Company, t.$6 AS LocationID, t.$7 AS LocationName, t.$8 AS AdmissionType, t.$9 AS ChartID, t.$10 AS AdmissionStatus, t.$11 AS AdmissionStatus2, t.$12 AS SOC, t.$13 AS ROC, t.$14 AS EOC, t.$15 AS UsesEVV, t.$16 AS ReferralSourceID, t.$17 AS ReferralSourceType, t.$18 AS MRN, t.$19 AS CoordinatorID, t.$20 AS ManagerID, t.$21 AS MarketerID, t.$22 AS TeamName, t.$23 AS PrimaryPhysicianID, t.$24 AS SecondaryPhysicanID, t.$25 AS IsCompliant, t.$26 AS CompliantThruDate, t.$27 AS IsLiveIn, t.$28 AS IsCluster, t.$29 AS ClusterGroup, t.$30 AS CreatedAt, t.$31 AS UpdatedAt, t.$32 AS HashedRowValues, t.$33 AS BatchId, t.$34 AS StatusAsOfDate, t.$35 AS SYS_CHANGE_VERSION, t.$36 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$36,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_ClientAdmissions.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_ClientAdmissions AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_ClientAdmissions GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_ClientAdmissions t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';