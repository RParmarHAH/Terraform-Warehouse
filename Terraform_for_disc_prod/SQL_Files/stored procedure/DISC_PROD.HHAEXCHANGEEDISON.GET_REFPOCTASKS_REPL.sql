CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_REFPOCTASKS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_RefPocTasks_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.RefPocTasks_REPL (SELECT t.$1 AS AgencyID, t.$2 AS POCTaskID, t.$3 AS POCTaskCode, t.$4 AS POCCategoryID, t.$5 AS TaskName, t.$6 AS Active, t.$7 AS PocMasterID, t.$8 AS DutyListSetupID, t.$9 AS AllowAdditionalPrompts, t.$10 AS NumberOfDigits, t.$11 AS DisplayDecimal, t.$12 AS DecimalLength, t.$13 AS MinAllowableEntry, t.$14 AS MaxAllowableEntry, t.$15 AS AllowMileage, t.$16 AS Createdby, t.$17 AS CreatedDate, t.$18 AS LastModifiedDate, t.$19 AS LastModifiedBy, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_RefPocTasks_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;
';