resource "snowflake_procedure" "DISC_DATAFLEXSYNCDATA_GET_DFCONTRACTS" {
	name ="GET_DFCONTRACTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.GET_DfContracts 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.HIST_DfContracts FROM (SELECT t.$1 AS DbName, t.$2 AS ContractCode, t.$3 AS ContractName, t.$4 AS PaymentMethod, t.$5 AS BillPersonCode, t.$6 AS Rate1, t.$7 AS Rate2, t.$8 AS RateEffectiveDate1, t.$9 AS RateEffectiveDate2, t.$10 AS Billable, t.$11 AS IsMedwaiver, t.$12 AS OverheadRate1, t.$13 AS OverheadRate2, t.$14 AS IsSkilled, t.$15 AS BilledByQuarterHours, t.$16 AS UseBillCode, t.$17 AS PayrollCode, t.$18 AS BillByHalfHours, t.$19 AS ListRate1, t.$20 AS ListRate2, t.$21 AS DefaultBillCode, t.$22 AS IsMileage, t.$23 AS AllowQuarterHours, t.$24 AS PayTravels, t.$25 AS PayorCode, t.$26 AS Payable, t.$27 AS CreatedDate, t.$28 AS UpdateBatch, t.$29 AS UpdatedTime, t.$30 AS PayInUnits, t.$31 AS PayInDollars, t.$32 AS PayInDollarPayCode, t.$33 AS PayInDollarRate, t.$34 AS IsEvv, t.$35 AS RevenueCategory, t.$36 AS Rate3, t.$37 AS Rate4, t.$38 AS RateEffectiveDate3, t.$39 AS RateEffectiveDate4, t.$40 AS ListRate3, t.$41 AS ListRate4, t.$42 AS PayTravelsCode, t.$43 AS RevenueSubCategory, t.$45 AS SYS_CHANGE_VERSION, t.$46 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$46,''D'', True, False) AS ETL_DELETED_FLAG,t.$44 as CptHpcsCode FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfContracts.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfContracts AS WITH curr_v AS (SELECT DbName, ContractCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfContracts GROUP BY DbName, ContractCode) SELECT t.* FROM DataFlexSyncData.HIST_DfContracts t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ContractCode = v.ContractCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

