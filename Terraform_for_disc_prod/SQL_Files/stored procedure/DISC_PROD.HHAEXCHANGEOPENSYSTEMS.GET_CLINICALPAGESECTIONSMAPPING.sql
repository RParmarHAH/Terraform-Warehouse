CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CLINICALPAGESECTIONSMAPPING("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_ClinicalPageSectionsMapping 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.ClinicalPageSectionsMapping (SELECT t.$1 AS AgencyID, t.$2 AS PageSectionsMappingID, t.$3 AS PageTemplateMasterID, t.$4 AS SectionTemplateMasterID, t.$5 AS DisplayOrder, t.$6 AS CreatedBy, t.$7 AS CreatedDate, t.$8 AS UpdatedBy, t.$9 AS UpdatedDate, t.$10 AS SYS_CHANGE_VERSION, t.$11 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$11,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ClinicalPageSectionsMapping.*[.]csv.gz'') T);

    return ''Success'';
END;
';