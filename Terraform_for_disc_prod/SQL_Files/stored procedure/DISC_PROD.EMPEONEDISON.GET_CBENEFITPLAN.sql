CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_CBENEFITPLAN("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_CBenefitPlan 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.CBenefitPlan (SELECT t.$1 AS benefitPlanId, t.$2 AS co, t.$3 AS planCode, t.$4 AS planName, t.$5 AS benefitType, t.$6 AS carrierId, t.$7 AS employeeDisplayName, t.$8 AS startDate, t.$9 AS endDate, t.$10 AS policyGroupNumber, t.$11 AS subGroupNumber, t.$12 AS selfInsured, t.$13 AS mec, t.$14 AS minimumValue, t.$15 AS lastChange, t.$16 AS lastChangeUser, t.$17 AS additionalPlanInfo, t.$18 AS annualMaximumBenefit, t.$19 AS coinsurance, t.$20 AS copay, t.$21 AS deductible, t.$22 AS dentalCoverage, t.$23 AS enrollmentForm, t.$24 AS hospital, t.$25 AS maximumOutOfPocket, t.$26 AS orthodontics, t.$27 AS outOfNetworkCoverageDetails, t.$28 AS pharmacyCopay, t.$29 AS planInfoDocuments, t.$30 AS spouseCoverage, t.$31 AS domesticPartnerCoverage, t.$32 AS childrenCoverage, t.$33 AS childMaxAge, t.$34 AS studentChildMaxAge, t.$35 AS disabledChildMaxAge, t.$36 AS contributionSchedule, t.$37 AS deductionCode, t.$38 AS deductionTaxability, t.$39 AS employerContributionCode, t.$40 AS supportsPayrollDeduction, t.$41 AS terminationCoverageEnd, t.$42 AS monthlyPremiumChildren, t.$43 AS monthlyPremiumEmployee, t.$44 AS monthlyPremiumFamily, t.$45 AS monthlyPremiumSpouse, t.$46 AS planId, t.$47 AS SYS_CHANGE_VERSION, t.$48 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$48,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_CBenefitPlan.*[.]csv.gz'')T);

    return ''Success'';
END;
';