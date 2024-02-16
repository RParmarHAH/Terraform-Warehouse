resource "snowflake_procedure" "DISC_CLEARCARE_GET_PATIENT_PATIENTPLAN" {
	name ="GET_PATIENT_PATIENTPLAN"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

 
--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_patient_patientplan 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.patient_patientplan  (SELECT t.$1 AS id, t.$2 AS patient_id, t.$3 AS date_of_birth, t.$4 AS height, t.$5 AS weight, t.$6 AS marital_status, t.$7 AS spouse_name, t.$8 AS lives_with, t.$9 AS languages, t.$10 AS dnr, t.$11 AS religion, t.$12 AS attends_church, t.$13 AS past_profession, t.$14 AS medical_conditions, t.$15 AS hearing, t.$16 AS hearing_aid, t.$17 AS speach, t.$18 AS vision, t.$19 AS glasses, t.$20 AS swallowing, t.$21 AS smoker, t.$22 AS sensitive_to_smell, t.$23 AS on_oxygen, t.$24 AS colostomy_bag, t.$25 AS feeding_tube, t.$26 AS mental_bahavior, t.$27 AS depression, t.$28 AS lethargy, t.$29 AS past_current_substance_abuse, t.$30 AS can_client_be_left_alone, t.$31 AS wanderer, t.$32 AS frequent_mood_changes, t.$33 AS hallucinations, t.$34 AS problem_solving, t.$35 AS short_term_memory_loss, t.$36 AS completing_task, t.$37 AS sundowning, t.$38 AS spatial_visual_relationships, t.$39 AS misplacing_items, t.$40 AS poor_eating, t.$41 AS speaking_conversing, t.$42 AS poor_judgment, t.$43 AS sleeping_problems, t.$44 AS anxiety, t.$45 AS agitation, t.$46 AS fear, t.$47 AS paranoia, t.$48 AS suspicion, t.$49 AS aggression, t.$50 AS confusion_of_time_place, t.$51 AS withdrawal, t.$52 AS symptoms_depression, t.$53 AS repetition, t.$54 AS wandering, t.$55 AS triggers, t.$56 AS toilets_self, t.$57 AS needs_reminders, t.$58 AS stand_by_assist, t.$59 AS bowels, t.$60 AS constipation, t.$61 AS diarrhea, t.$62 AS urination, t.$63 AS elimination_notes, t.$64 AS need_medication_reminders, t.$65 AS how_many_times_per_day, t.$66 AS who_manages_medication, t.$67 AS number_of_medications, t.$68 AS separate_medication_schedule_sheet, t.$69 AS medications_setup_in_pill_boxes, t.$70 AS how_many_weeks, t.$71 AS cane, t.$72 AS walker, t.$73 AS wheel_chair, t.$74 AS geri_chair, t.$75 AS scooter, t.$76 AS cci_left, t.$77 AS cci_right, t.$78 AS ambulation_notes, t.$79 AS transfer_observed, t.$80 AS transfer_types, t.$81 AS gait_belt, t.$82 AS hoyer, t.$83 AS aides_other, t.$84 AS aides_other_connected, t.$85 AS transfer_risks, t.$86 AS transfer_notes, t.$87 AS resists_bathing, t.$88 AS uses_shower_bench, t.$89 AS shower, t.$90 AS bath, t.$91 AS sponge_bath, t.$92 AS bgd_frequency, t.$93 AS dental_dentures_care, t.$94 AS skin_care, t.$95 AS hygiene_other, t.$96 AS hygiene_other_connected, t.$97 AS dressing, t.$98 AS bgd_notes, t.$99 AS cooking, t.$100 AS preparation, t.$101 AS appetite, t.$102 AS diet, t.$103 AS special_diet, t.$104 AS shopping_by, t.$105 AS breakfast, t.$106 AS breakfast_connected, t.$107 AS lunch, t.$108 AS lunch_connected, t.$109 AS dinner, t.$110 AS dinner_connected, t.$111 AS snacks, t.$112 AS snacks_connected, t.$113 AS swallowing_issues, t.$114 AS encourage_liquids, t.$115 AS favorite_breakfast, t.$116 AS favorite_lunch, t.$117 AS favorite_snack, t.$118 AS favorite_dinner, t.$119 AS meals_notes, t.$120 AS vehicle_need_caregiver_to_drive_connected, t.$121 AS errands, t.$122 AS errands_connected, t.$123 AS drs_appt, t.$124 AS drs_appt_connected, t.$125 AS driving_notes, t.$126 AS excercise_importance, t.$127 AS does_client_have_specific_excercise, t.$128 AS encourage_excercises, t.$129 AS excercise_notes, t.$130 AS housekeeping_importance, t.$131 AS laundry, t.$132 AS change_bed_bath_linens, t.$133 AS clean_kitchen, t.$134 AS clean_bathroom, t.$135 AS make_beds, t.$136 AS sweep, t.$137 AS vacuum, t.$138 AS mop, t.$139 AS dust, t.$140 AS take_out_trash, t.$141 AS water_plants, t.$142 AS feed_animals, t.$143 AS housekeeping_other, t.$144 AS tasks_other_connected, t.$145 AS housekeeping_notes, t.$146 AS goes_to_bed, t.$147 AS wakes_up, t.$148 AS sleep_patterns, t.$149 AS naps_during_day, t.$150 AS nap_time, t.$151 AS nap_duration, t.$152 AS sleep_patterns_notes, t.$153 AS has_safety_assessment_been_done, t.$154 AS interested_in_lifeline, t.$155 AS bedrails, t.$156 AS hospital_bed, t.$157 AS bed_commode, t.$158 AS grab_bars, t.$159 AS lift_chair, t.$160 AS raised_toilet_seat, t.$161 AS shower_bench, t.$162 AS handheld_showerhead, t.$163 AS equipment_environment_other, t.$164 AS equipment_environment_other_connected, t.$165 AS equipment_environment_notes, t.$166 AS cat, t.$167 AS clean_litter_box, t.$168 AS dog, t.$169 AS feeding, t.$170 AS walk_dog, t.$171 AS pets_other, t.$172 AS pets_other_connected, t.$173 AS morning, t.$174 AS afternoon, t.$175 AS evening, t.$176 AS activities_at_home, t.$177 AS activities_away_from_home, t.$178 AS favorite_restaurants_shops, t.$179 AS difficulty_returning_to_sleep, t.$180 AS family_friends_neighbors, t.$181 AS transfer_assistance, t.$182 AS bgd_assistance, t.$183 AS needs_assistance_at_night_from_caregiver, t.$184 AS mental_dementia, t.$185 AS elimination_wears_briefs, t.$186 AS ambulation_ambulation, t.$187 AS ambulation_fall_risk, t.$188 AS meal_feeding, t.$189 AS client_drives, t.$190 AS need_caregiver_to_drive, t.$191 AS medication_notes, t.$192 AS date_of_death, t.$193 AS created, t.$194 AS updated, t.$195 AS full_assessment_first_save, t.$196 AS gender, t.$197 AS sections_in_use, t.$198 AS allergy_notes, t.$199 AS pet_care_notes, t.$200 AS patient_control_number, t.$201 AS medical_record_number, t.$202 AS deleted, t.$203 AS originator_id, t.$204 AS last_updated_by_id, t.$205 AS deleted_by_id, t.$206 AS date_deleted, t.$207 AS agency_id, t.$208 AS franchisor_id, t.$209 AS SYS_CHANGE_VERSION, t.$210 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$210,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_patient_patientplan.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

