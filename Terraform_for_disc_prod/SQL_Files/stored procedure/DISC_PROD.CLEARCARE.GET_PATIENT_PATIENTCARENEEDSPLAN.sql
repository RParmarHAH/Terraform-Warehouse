CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_PATIENT_PATIENTCARENEEDSPLAN("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_patient_patientcareneedsplan 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.patient_patientcareneedsplan  (SELECT t.$1 AS id, t.$2 AS patient_id, t.$3 AS companionship, t.$4 AS cooking_meal_preparation, t.$5 AS light_housekeeping, t.$6 AS out_of_home_activities, t.$7 AS dr_appt_errands_shopping, t.$8 AS light_exercise, t.$9 AS monitor_wondering, t.$10 AS med_reminders, t.$11 AS feed, t.$12 AS bath_shower_sponge, t.$13 AS dress_groom, t.$14 AS ambulation, t.$15 AS cane_walker_whchair_scooter, t.$16 AS toileting, t.$17 AS gait, t.$18 AS fall_risk, t.$19 AS transfer, t.$20 AS wears_briefs, t.$21 AS for_accidents, t.$22 AS dementia, t.$23 AS hospice, t.$24 AS care_goals, t.$25 AS proposed_schedule, t.$26 AS car_transportation, t.$27 AS bedbound, t.$28 AS caregiver_gender_preference, t.$29 AS cn_feeding_tube, t.$30 AS cn_hoyer, t.$31 AS colostomy, t.$32 AS wound_care, t.$33 AS live_in, t.$34 AS cna, t.$35 AS rn, t.$36 AS hha, t.$37 AS lvn, t.$38 AS initial_contact, t.$39 AS start_date, t.$40 AS created, t.$41 AS updated, t.$42 AS deleted, t.$43 AS originator_id, t.$44 AS last_updated_by_id, t.$45 AS deleted_by_id, t.$46 AS date_deleted, t.$47 AS agency_id, t.$48 AS care_plan_prognosis, t.$49 AS care_coordination_notes, t.$50 AS franchisor_id, t.$51 AS SYS_CHANGE_VERSION, t.$52 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$52,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_patient_patientcareneedsplan.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';