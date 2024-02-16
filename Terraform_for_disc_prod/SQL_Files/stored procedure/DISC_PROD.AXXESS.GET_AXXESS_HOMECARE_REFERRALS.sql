CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_HOMECARE_REFERRALS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_HOMECARE_REFERRALS 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_HOMECARE_REFERRALS (SELECT A.$1 AS Referral_Id, A.$2 AS Agency_Id, A.$3 AS Branch_Id, A.$4 AS Agency_Name, A.$5 AS Branch_Name, A.$6 AS Referral_Date, A.$7 AS Referral_First_Name, A.$8 AS Referral_Last_Name, A.$9 AS Admission_Source, A.$10 AS Referral_Dob, A.$11 AS Referral_Gender, A.$12 AS Referral_Status, A.$13 AS Referral_Is_NonMedical, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/HomeCare_Referrals(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;
';