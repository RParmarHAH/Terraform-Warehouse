CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_CARELOGS_CARELOGREVISION("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_carelogs_carelogrevision 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.carelogs_carelogrevision  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS deleted, t.$5 AS complete, t.$6 AS status, t.$7 AS meta, t.$8 AS cci_scheduled_clock_in, t.$9 AS cci_scheduled_clock_out, t.$10 AS cci_actual_clock_in, t.$11 AS cci_actual_clock_out, t.$12 AS clock_in, t.$13 AS clock_out, t.$14 AS clocked_out, t.$15 AS bill_official_clock_in, t.$16 AS bill_official_clock_out, t.$17 AS pay_official_clock_in, t.$18 AS pay_official_clock_out, t.$19 AS total_hours, t.$20 AS new_total_pay_hours, t.$21 AS new_total_bill_hours, t.$22 AS shift_date, t.$23 AS client_esig_required, t.$24 AS caregiver_esig_required, t.$25 AS caremanager_esig_required, t.$26 AS authorization_split_amount, t.$27 AS bill_rate_type, t.$28 AS bill_pro_rate, t.$29 AS bill_rate_amount, t.$30 AS original_bill_rate_amount, t.$31 AS bill_amount, t.$32 AS bill_reg_for_live_ins, t.$33 AS bill_live_in_hours_to_count, t.$34 AS bill_ot, t.$35 AS bill_dot, t.$36 AS bill_auto_ot, t.$37 AS bill_auto_dot, t.$38 AS bill_finalized, t.$39 AS bill_export_queue, t.$40 AS bill_invoiced, t.$41 AS bill_exported, t.$42 AS bill_rate_name, t.$43 AS bill_holiday_multiplier, t.$44 AS pay_rate_type, t.$45 AS pay_pro_rate, t.$46 AS pay_rate_amount, t.$47 AS original_pay_rate_amount, t.$48 AS pay_amount, t.$49 AS pay_average_rate, t.$50 AS pay_reg_for_live_ins, t.$51 AS pay_live_in_hours_to_count, t.$52 AS pay_ot, t.$53 AS pay_dot, t.$54 AS pay_auto_ot, t.$55 AS overtime_rate_type, t.$56 AS pay_auto_ot_is_week, t.$57 AS pay_auto_dot, t.$58 AS pay_auto_dot_is_week, t.$59 AS pay_finalized, t.$60 AS pay_export_queue, t.$61 AS pay_exported, t.$62 AS pay_excel_exported, t.$63 AS pay_rate_name, t.$64 AS pay_holiday_multiplier, t.$65 AS in_facility_pay_rates, t.$66 AS in_facility, t.$67 AS bill_tiered, t.$68 AS pay_tiered, t.$69 AS payments_total, t.$70 AS split, t.$71 AS is_last_child, t.$72 AS child_letter, t.$73 AS prevent_clock_out, t.$74 AS old_clock_in_method, t.$75 AS old_clock_out_method, t.$76 AS clock_in_method, t.$77 AS clock_out_method, t.$78 AS clock_in_point, t.$79 AS clock_in_point_accuracy, t.$80 AS clock_out_point, t.$81 AS clock_out_point_accuracy, t.$82 AS bill_and_pay_type, t.$83 AS hash, t.$84 AS is_community_care, t.$85 AS clock_in_ip_address, t.$86 AS clock_out_ip_address, t.$87 AS carelog_edit_ip_address, t.$88 AS bill_rounding_rule, t.$89 AS pay_rounding_rule, t.$90 AS cuid, t.$91 AS revision_num, t.$92 AS agency_id, t.$93 AS authorization_id, t.$94 AS authorization_split_item_id, t.$95 AS bill_rate_obj_id, t.$96 AS caregiver_id, t.$97 AS carelogs_id, t.$98 AS deleted_by_id, t.$99 AS last_updated_by_id, t.$100 AS originator_id, t.$101 AS parent_id, t.$102 AS patient_id, t.$103 AS pay_rate_obj_id, t.$104 AS place_id, t.$105 AS rate_category_id, t.$106 AS shift_id, t.$107 AS franchisor_id, t.$108 AS SYS_CHANGE_VERSION, t.$109 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$109,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_carelogs_carelogrevision.*[.]csv.gz'') t);

   
    return ''Success'';
END;
';