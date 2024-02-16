CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CAREGIVERINSERVICE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_CaregiverInservice 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.CaregiverInservice (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverInServiceID, t.$3 AS InServiceID, t.$4 AS CaregiverID, t.$5 AS InServiceDate, t.$6 AS FromTime, t.$7 AS EndTime, t.$8 AS FromEndTime, t.$9 AS Topic, t.$10 AS Location, t.$11 AS Instructor, t.$12 AS Description, t.$13 AS Type, t.$14 AS Hours, t.$15 AS PayrollBilled, t.$16 AS NoShow, t.$17 AS NoShowText, t.$18 AS IsStatus, t.$19 AS IsStatusText, t.$20 AS Reason, t.$21 AS BatchNumber, t.$22 AS CreatedByUser, t.$23 AS CreatedbyUserID, t.$24 AS CreatedDate, t.$25 AS ModifiedDate, t.$26 AS PayRateID, t.$27 AS PayRateCode, t.$28 AS PayRateID2, t.$29 AS PayRateCode2, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_CaregiverInservice.*[.]csv.gz'') T);

    return ''Success'';
END;
';