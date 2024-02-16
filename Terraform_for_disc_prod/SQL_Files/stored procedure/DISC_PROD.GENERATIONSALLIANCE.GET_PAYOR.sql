CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_PAYOR("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_payor 
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
    COPY INTO GENERATIONSALLIANCE.payor FROM (SELECT t.$1 AS PayorId, t.$2 AS BAddress1, t.$3 AS BAddress2, t.$4 AS BCity, t.$5 AS BState, t.$6 AS BZip, t.$7 AS notes, t.$8 AS BAddress3, t.$9 AS createdBy, t.$10 AS created, t.$11 AS updatedBy, t.$12 AS lastUpdated, t.$13 AS Phone1, t.$14 AS Phone2, t.$15 AS Email, t.$16 AS Website, t.$17 AS ID, t.$18 AS SenderCode, t.$19 AS ReceiverCode, t.$20 AS EDIVersion, t.$21 AS SubmitterName, t.$22 AS SubmitterETIN, t.$23 AS ReceiverName, t.$24 AS ReceiverETIN, t.$25 AS EDIContactName, t.$26 AS EDIContactNumber, t.$27 AS ClaimFilingIndicator, t.$28 AS InterchangeIDQualifier, t.$29 AS ISA07ReceiverIDQualifier, t.$30 AS HHAXEnabled, t.$31 AS bit_IncludeOtherProviderNumber, t.$32 AS SandataEnabled, t.$33 AS PayorProgram, t.$34 AS ProcedureCode, t.$35 AS EnableDMAS90, t.$36 AS IncludeCGName, t.$37 AS IncludeClientAddress, t.$38 AS ProviderCommercialNumber, t.$39 AS EVVID, t.$40 AS IsSantraxFieldUpdated, t.$41 AS TellusEnabled, t.$42 AS UseModifier76, t.$43 AS RemoveGS06GE02LeadingZero, t.$44 AS IncludeTaxonomyCode, t.$45 AS AuthenticareEnabled, t.$46 AS EnableMassachusetts, t.$47 AS DoNotPrint2420Prv, t.$48 AS IsEnabledNYMedicaid, t.$49 AS CarebridgeEnabled, t.$50 AS OverrideNPI, t.$51 AS SantraxJurisdictionID, t.$52 AS APDiConnectFLEnabled, t.$53 AS SYS_CHANGE_VERSION, t.$54 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$54,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_payor.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.payor AS WITH curr_v AS (SELECT PayorId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.payor GROUP BY PayorId) SELECT t.* FROM GENERATIONSALLIANCE.payor t INNER JOIN curr_v v ON t.PayorId = v.PayorId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';