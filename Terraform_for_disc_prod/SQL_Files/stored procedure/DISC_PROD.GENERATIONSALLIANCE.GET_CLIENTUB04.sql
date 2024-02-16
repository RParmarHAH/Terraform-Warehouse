CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_CLIENTUB04("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_ClientUB04 
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
    COPY INTO GENERATIONSALLIANCE.ClientUB04 FROM (SELECT t.$1 AS ClientID, t.$2 AS hcfaID, t.$3 AS BillType, t.$4 AS PatientID, t.$5 AS AdmissionType, t.$6 AS AdmissionSrc, t.$7 AS DischargeStatus, t.$8 AS ReleaseOfInformation, t.$9 AS AssignmentBenefits, t.$10 AS OverridePatient_NUMBER, t.$11 AS DiagnosisCode, t.$12 AS OverrideDiagnosisCode, t.$13 AS createdBy, t.$14 AS created, t.$15 AS updatedBy, t.$16 AS lastUpdated, t.$17 AS OccurenceCode, t.$18 AS OccurenceDate, t.$19 AS OccurencespanCode, t.$20 AS OccurencespanFrom, t.$21 AS OccurencespanThrough, t.$22 AS AdmitDX, t.$23 AS PatientControlID, t.$24 AS InsuredName, t.$25 AS RelationShipToInsured, t.$26 AS InsuredUniqueID, t.$27 AS InsuredGroupName, t.$28 AS InsuredGroupID, t.$29 AS OtherProvider, t.$30 AS ConditionCode, t.$31 AS OtherInsuredName, t.$32 AS OtherInsuredRelationShip, t.$33 AS OtherInsuredUniqueID, t.$34 AS OtherInsuredGroupName, t.$35 AS OtherInsuredGroupID, t.$36 AS Remarks1, t.$37 AS Code39A, t.$38 AS Amount39A, t.$39 AS Code39B, t.$40 AS Amount39B, t.$41 AS Code39C, t.$42 AS Amount39C, t.$43 AS Code39D, t.$44 AS Amount39D, t.$45 AS DocumentControlNumber, t.$46 AS OtherPayorName, t.$47 AS OtherPayorID, t.$48 AS OtherPayorReleaseInfo, t.$49 AS OtherPayorAssignmentBenefits, t.$50 AS AdmissionHour, t.$51 AS SYS_CHANGE_VERSION, t.$52 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$52,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ClientUB04.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ClientUB04 AS WITH curr_v AS (SELECT ClientID, hcfaID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ClientUB04 GROUP BY ClientID, hcfaID) SELECT t.* FROM GENERATIONSALLIANCE.ClientUB04 t INNER JOIN curr_v v ON t.ClientID = v.ClientID AND t.hcfaID = v.hcfaID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';