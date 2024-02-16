resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_REFERRALADDRESS" {
	name ="GET_REFERRALADDRESS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_ReferralAddress 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.ReferralAddress (SELECT t.$1 AS AgencyID, t.$2 AS ReferralAddressID, t.$3 AS ReferralID, t.$4 AS AddressLine1, t.$5 AS AddressLine2, t.$6 AS City, t.$7 AS State, t.$8 AS County, t.$9 AS Zip, t.$10 AS CrossStreet, t.$11 AS PrimaryAddress, t.$12 AS AddressTypes, t.$13 AS Note, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/HHAEXCHANGEPREFERRED_dbo_ReferralAddress.csv.gz(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT)T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

