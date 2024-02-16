resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_EVVCODES" {
	name ="GET_CV_EVVCODES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_EvvCodes 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_EvvCodes FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Evv_Code, t.$8 AS Evv_Description, t.$9 AS Business_Entity_ID, t.$10 AS Location_Codes, t.$11 AS Facility_Codes, t.$12 AS Plan_Codes, t.$13 AS ProviderQualifier, t.$14 AS ProviderID, t.$15 AS Evv_User_Name, t.$16 AS Evv_Password, t.$17 AS Patient_Message_URL, t.$18 AS Employee_Message_URL, t.$19 AS Visit_Message_URL, t.$20 AS SQLServer_Instance_Name, t.$21 AS Sys_DB_Name, t.$22 AS Company_DB_Name, t.$23 AS Company_Code, t.$24 AS Test_Or_Production, t.$25 AS Evv_Interface_Type, t.$26 AS DDL_Facility_Plan, t.$27 AS FTP_URL, t.$28 AS SshHostKeyFingerprint, t.$29 AS FTP_Download_Folder, t.$30 AS User_Download_Folder, t.$31 AS Port_Number, t.$32 AS Sftp_Infolder, t.$33 AS Sftp_Outfolder, t.$34 AS Local_ExportImport_Folder, t.$35 AS Provider_Name, t.$36 AS Provider_NPI, t.$37 AS Provider_EIN_TaxID, t.$38 AS SendOnlyBillableSVCFlag, t.$39 AS SendOnlyMappedVisitsFlag, t.$40 AS SendVerifiedVisitsFlag, t.$41 AS SYS_CHANGE_VERSION, t.$42 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$42,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_EvvCodes.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_EvvCodes AS WITH curr_v AS (SELECT Db, Evv_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_EvvCodes GROUP BY Db, Evv_Code) SELECT t.* FROM CostalSyncData.HIST_CV_EvvCodes t INNER JOIN curr_v v ON t.Db = v.Db AND t.Evv_Code = v.Evv_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

