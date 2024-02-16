resource "snowflake_procedure" "DISC_RISKONNECT_GET_WORK_STATUS" {
	name ="GET_WORK_STATUS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.RISKONNECT.GET_WORK_STATUS 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Work_Status from (SELECT T.$1 AS Id,  T.$2 AS IsDeleted,  T.$3 AS Name,  REPLACE(T.$4,''T'','' '')::TIMESTAMP_NTZ(9) AS CreatedDate,  T.$5 AS CreatedById,  REPLACE(T.$6,''T'','' '')::TIMESTAMP_NTZ(9) AS LastModifiedDate,  T.$7 AS LastModifiedById,  REPLACE(T.$8,''T'','' '')::TIMESTAMP_NTZ(9) AS SystemModstamp,  T.$9 AS LastActivityDate,  T.$10 AS LastViewedDate,  T.$11 AS LastReferencedDate,  T.$12 AS ConnectionReceivedId,  T.$13 AS ConnectionSentId,  T.$14 AS Claim__c,  T.$15 AS Active_or_Completed__c,  T.$16 AS Activity_Type_Details__c,  T.$17 AS Activity_Type__c,  T.$18 AS Adjustment_Days__c,  T.$19 AS Adjustment_Hours__c,  T.$20 AS Adjustment_Reason__c,  T.$21 AS Claimant_Name__c,  T.$22 AS DateTime_Away__c,  T.$23 AS DateTime_Return__c,  T.$24 AS Date_Begin__c,  T.$25 AS Date_End__c,  T.$26 AS Net_Total_Days__c,  T.$27 AS Return_to_Unrestricted_Work__c,  T.$28 AS Total_Days__c,  T.$29 AS Work_Status_Comment__c,  T.$30 AS Hidden_Checkbox__c,  T.$31 AS Hidden_Total_Days__c,  T.$32 AS Void__c,  T.$33 AS Entry_Date__c,  T.$34 AS TPA_Check__c,  T.$35 AS TPA_Lost_Days_Type__c,  T.$36 AS Work_Status_Tracking__c,  T.$37 AS Did_EE_RTW__c, -1 AS ETL_TASK_KEY, -1 AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Riskonnect/Daily_data (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.CSV_FORMAT_UTF8_FALSE,PATTERN => ''.*Work_Status_.*[.]csv'')T);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.RISKONNECT.Work_status AS SELECT ID,  ISDELETED,  NAME,  CREATEDDATE,  CREATEDBYID,  LASTMODIFIEDDATE,  LASTMODIFIEDBYID,  SYSTEMMODSTAMP,  LASTACTIVITYDATE,  LASTVIEWEDDATE,  LASTREFERENCEDDATE,  CONNECTIONRECEIVEDID,  CONNECTIONSENTID,  CLAIM__C,  ACTIVE_OR_COMPLETED__C,  ACTIVITY_TYPE_DETAILS__C,  ACTIVITY_TYPE__C,  ADJUSTMENT_DAYS__C,  ADJUSTMENT_HOURS__C,  ADJUSTMENT_REASON__C,  CLAIMANT_NAME__C,  DATETIME_AWAY__C,  DATETIME_RETURN__C,  DATE_BEGIN__C,  DATE_END__C,  NET_TOTAL_DAYS__C,  RETURN_TO_UNRESTRICTED_WORK__C,  TOTAL_DAYS__C,  WORK_STATUS_COMMENT__C,  HIDDEN_CHECKBOX__C,  HIDDEN_TOTAL_DAYS__C,  VOID__C,  ENTRY_DATE__C,  TPA_CHECK__C,  TPA_LOST_DAYS_TYPE__C,  WORK_STATUS_TRACKING__C,  DID_EE_RTW__C, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Work_status WHERE (ID,ETL_LAST_UPDATED_DATE) IN (SELECT ID,MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Work_status GROUP BY ID);

    return ''Success'';
END;

 EOT
}

