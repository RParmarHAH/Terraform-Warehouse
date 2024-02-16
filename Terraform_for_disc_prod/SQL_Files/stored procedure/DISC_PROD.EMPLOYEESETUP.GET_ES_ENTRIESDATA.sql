CREATE OR REPLACE PROCEDURE DISC_PROD.EMPLOYEESETUP.GET_ES_ENTRIESDATA("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmployeeSetup.GET_ES_EntriesData 
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
    COPY INTO EmployeeSetup.HIST_ES_EntriesData FROM (SELECT t.$1 AS EntryID, t.$2 AS SSN, t.$3 AS LastName, t.$4 AS FirstName, t.$5 AS MiddleName, t.$6 AS Address1, t.$7 AS Address2, t.$8 AS City, t.$9 AS State, t.$10 AS Zip, t.$11 AS Phone, t.$12 AS DOB, t.$13 AS Sex, t.$14 AS Race, t.$15 AS Rehire, t.$16 AS HireDate, t.$17 AS MaritalStatus, t.$18 AS FederalExemptions, t.$19 AS StateExemptions, t.$20 AS AdditionalFederalWithholdings, t.$21 AS AdditionalStatelWithholdings, t.$22 AS PositionID, t.$23 AS PayStatus, t.$24 AS EicElig, t.$25 AS WhereToCheck, t.$26 AS StateFillingStatus, t.$27 AS BackgroundCheck, t.$28 AS InUnion, t.$29 AS OriginalEmployeeID, t.$30 AS EmploymentType, t.$31 AS TravelCode, t.$32 AS SequenceID, t.$33 AS EmployeeID, t.$34 AS NurseLicenseNumber, t.$35 AS LicenseExpireDate, t.$36 AS PerferedCaregiver, t.$37 AS LocalTaxCode, t.$38 AS ContractType, t.$39 AS Replacement, t.$40 AS TitleID, t.$41 AS Referral, t.$42 AS OrderNewPayCard, t.$43 AS MedicareId, t.$44 AS Phone2, t.$45 AS EmailTo, t.$46 AS PersonalEmail, t.$47 AS SYS_CHANGE_VERSION, t.$48 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$48,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPLOYEESETUP/ (PATTERN => ''.*EmployeeSetup_dbo_ES_EntriesData.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE EmployeeSetup.ES_EntriesData AS WITH curr_v AS (SELECT EntryID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM EmployeeSetup.HIST_ES_EntriesData GROUP BY EntryID) SELECT t.* FROM EmployeeSetup.HIST_ES_EntriesData t INNER JOIN curr_v v ON t.EntryID = v.EntryID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';