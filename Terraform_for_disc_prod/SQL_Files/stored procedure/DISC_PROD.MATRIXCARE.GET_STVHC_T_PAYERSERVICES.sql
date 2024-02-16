CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PAYERSERVICES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayerServices 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayerServices FROM (SELECT t.$1 AS paysvc_ID, t.$2 AS paysvc_PayerID, t.$3 AS paysvc_ServiceCodeID, t.$4 AS paysvc_HCPCCode, t.$5 AS paysvc_UseDefaultHCPC, t.$6 AS paysvc_DefaultBillRateUnitFlag, t.$7 AS paysvc_DefaultPayRateUnitFlag, t.$8 AS paysvc_RevenueCode, t.$9 AS paysvc_PayCode, t.$10 AS paysvc_EffectiveFrom, t.$11 AS paysvc_EffectiveTo, t.$12 AS paysvc_TaxGroupID, t.$13 AS paysvc_CreatedDate, t.$14 AS paysvc_CreatedUser, t.$15 AS paysvc_ModifiedDate, t.$16 AS paysvc_ModifiedUser, t.$17 AS paysvc_TS, t.$18 AS paysvc_AuthRequired, t.$19 AS paysvc_1500BillingModifierID1, t.$20 AS paysvc_1500BillingModifierID2, t.$21 AS paysvc_1500BillingModifierID3, t.$22 AS paysvc_1500BillingModifierID4, t.$23 AS paysvc_EVVEnabled, t.$24 AS InsertDate, t.$25 AS UpdateDate, t.$26 AS DeletedFlag, t.$27 AS SYS_CHANGE_VERSION, CASE WHEN t.$26 = True THEN ''D'' WHEN t.$24 = t.$25 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$26, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayerServices.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayerServices AS WITH curr_v AS (SELECT paysvc_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayerServices GROUP BY paysvc_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayerServices t INNER JOIN curr_v v ON t.paysvc_ID = v.paysvc_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';