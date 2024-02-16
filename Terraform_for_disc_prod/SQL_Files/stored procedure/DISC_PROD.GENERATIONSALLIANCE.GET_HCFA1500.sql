CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_HCFA1500("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_HCFA1500 
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
    COPY INTO GENERATIONSALLIANCE.HCFA1500 FROM (SELECT t.$1 AS HCFAID, t.$2 AS _1_InsuranceType, t.$3 AS _1a_InsuredIDField, t.$4 AS _6_RelationshipToInsured, t.$5 AS _12_SignatureOnFile, t.$6 AS _17_ReferralSourceField, t.$7 AS _19_ReservedForLocalUse, t.$8 AS _21_UseGlobalDiagnosis, t.$9 AS _21_GlobalDiagnosis, t.$10 AS _24a_DetailedOption, t.$11 AS _24b_PlaceOfService, t.$12 AS _24g_daysOrUnits, t.$13 AS _23_ReferralNumber, t.$14 AS _9a_OtherInsuredPolicyNo, t.$15 AS _11_Policy_FECA_no, t.$16 AS _9a_UseMedRecNo, t.$17 AS GrpNo_33, t.$18 AS acceptAssignment27, t.$19 AS _24K_ReservedLocalUse, t.$20 AS _33pin, t.$21 AS OverrideLine33, t.$22 AS OverrideLine33Value, t.$23 AS OverridePhone33, t.$24 AS leftMargin, t.$25 AS topMargin, t.$26 AS EMG_24c, t.$27 AS NPI33A_RptUIOverride, t.$28 AS PICA_Right, t.$29 AS SYS_CHANGE_VERSION, t.$30 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$30,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_HCFA1500.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.HCFA1500 AS WITH curr_v AS (SELECT HCFAID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.HCFA1500 GROUP BY HCFAID) SELECT t.* FROM GENERATIONSALLIANCE.HCFA1500 t INNER JOIN curr_v v ON t.HCFAID = v.HCFAID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';