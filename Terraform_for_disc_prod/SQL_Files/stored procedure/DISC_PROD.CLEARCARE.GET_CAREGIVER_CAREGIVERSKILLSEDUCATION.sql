CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_CAREGIVER_CAREGIVERSKILLSEDUCATION("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_caregiver_caregiverskillseducation 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.caregiver_caregiverskillseducation  (SELECT t.$1 AS id, t.$2 AS caregiver_id, t.$3 AS companionship, t.$4 AS cooking_meal_preparation, t.$5 AS light_housekeeping, t.$6 AS out_of_home_activities, t.$7 AS car_transportation, t.$8 AS dr_appt_errands_shopping, t.$9 AS light_exercise, t.$10 AS monitor_wondering, t.$11 AS med_reminders, t.$12 AS feed, t.$13 AS bath_shower_sponge, t.$14 AS dress_groom, t.$15 AS ambulation, t.$16 AS cane_walker_whchair_scooter, t.$17 AS toileting, t.$18 AS gait, t.$19 AS fall_risk, t.$20 AS transfer, t.$21 AS wears_briefs, t.$22 AS for_accidents, t.$23 AS dementia, t.$24 AS hospice, t.$25 AS bedbound, t.$26 AS has_access_to_a_car, t.$27 AS ok_with_clients_that_smoke, t.$28 AS highschool, t.$29 AS college, t.$30 AS gender, t.$31 AS college_name, t.$32 AS degree, t.$33 AS max_client_weight, t.$34 AS date_of_birth, t.$35 AS height, t.$36 AS weight, t.$37 AS languages, t.$38 AS cn_feeding_tube, t.$39 AS cn_hoyer, t.$40 AS colostomy, t.$41 AS wound_care, t.$42 AS live_in, t.$43 AS hire_date, t.$44 AS termination_date, t.$45 AS hr_notes, t.$46 AS race, t.$47 AS ok_with_dogs, t.$48 AS ok_with_cats, t.$49 AS created, t.$50 AS updated, t.$51 AS deleted, t.$52 AS originator_id, t.$53 AS last_updated_by_id, t.$54 AS deleted_by_id, t.$55 AS date_deleted, t.$56 AS agency_id, t.$57 AS franchisor_id, t.$58 AS SYS_CHANGE_VERSION, t.$59 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$59,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_caregiver_caregiverskillseducation.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';