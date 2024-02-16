resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_SERVICECODES" {
	name ="GET_SERVICECODES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_ServiceCodes 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.ServiceCodes (SELECT t.$1 AS AgencyID, t.$2 AS ServiceCodeID, t.$3 AS ServiceCode, t.$4 AS RateTypeText, t.$5 AS Status, t.$6 AS Discipline, t.$7 AS ContractID, t.$8 AS ContractName, t.$9 AS VisitType, t.$10 AS Mutual, t.$11 AS AllowPatientShiftOverlap, t.$12 AS ByPassPrebillingValidation, t.$13 AS ByPassBillingReviewValidation, t.$14 AS LocationCode, t.$15 AS DelayReasonCode, t.$16 AS WeekendHolidayRates, t.$17 AS HolidayCodeToWeekday, t.$18 AS WeekdayExportCode, t.$19 AS WeekendHolidayExportCode, t.$20 AS WeekdayRevenueCode, t.$21 AS WeekendHolidayRevenueCode, t.$22 AS WeekdayTaxonomyCode, t.$23 AS WeekendHolidayTaxonomyCode, t.$24 AS WeekdayHCPCSCode, t.$25 AS WeekendHolidayHCPCSCode, t.$26 AS WeekdayGLCode, t.$27 AS WeekendHolidayGLCode, t.$28 AS ModifiedDate, t.$29 AS ID, t.$30 AS AreaType, t.$31 AS ServiceCategoryID, t.$32 AS RevenueCode, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ServiceCodes.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

