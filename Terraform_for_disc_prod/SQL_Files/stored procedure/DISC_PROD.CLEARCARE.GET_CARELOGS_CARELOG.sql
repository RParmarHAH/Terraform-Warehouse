CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_CARELOGS_CARELOG("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_carelogs_carelog 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.carelogs_carelog  (SELECT t.$1 AS id, t.$2 AS patient_id, t.$3 AS caregiver_id, t.$4 AS shift_id, t.$5 AS pay_rate_type, t.$6 AS pay_rate_amount, t.$7 AS bill_rate_type, t.$8 AS bill_rate_amount, t.$9 AS clock_in, t.$10 AS clock_out, t.$11 AS pay_ot, t.$12 AS pay_dot, t.$13 AS pay_auto_ot, t.$14 AS pay_auto_dot, t.$15 AS bill_ot, t.$16 AS bill_dot, t.$17 AS bill_auto_ot, t.$18 AS bill_auto_dot, t.$19 AS pay_finalized, t.$20 AS bill_finalized, t.$21 AS pay_exported, t.$22 AS bill_exported, t.$23 AS agency_id, t.$24 AS parent_id, t.$25 AS split, t.$26 AS child_letter, t.$27 AS pay_pro_rate, t.$28 AS bill_pro_rate, t.$29 AS status, t.$30 AS complete, t.$31 AS shift_date, t.$32 AS cci_scheduled_clock_in, t.$33 AS cci_scheduled_clock_out, t.$34 AS cci_actual_clock_in, t.$35 AS cci_actual_clock_out, t.$36 AS prevent_clock_out, t.$37 AS pay_export_queue, t.$38 AS bill_export_queue, t.$39 AS old_clock_in_method, t.$40 AS old_clock_out_method, t.$41 AS pay_average_rate, t.$42 AS pay_auto_ot_is_week, t.$43 AS pay_auto_dot_is_week, t.$44 AS client_esig_required, t.$45 AS caregiver_esig_required, t.$46 AS caremanager_esig_required, t.$47 AS pay_rate_name, t.$48 AS bill_rate_name, t.$49 AS pay_reg_for_live_ins, t.$50 AS bill_reg_for_live_ins, t.$51 AS pay_holiday_multiplier, t.$52 AS bill_holiday_multiplier, t.$53 AS pay_live_in_hours_to_count, t.$54 AS bill_live_in_hours_to_count, t.$55 AS bill_invoiced, t.$56 AS pay_excel_exported, t.$57 AS bill_amount, t.$58 AS pay_amount, t.$59 AS clock_in_method, t.$60 AS clock_out_method, t.$61 AS clock_in_point_accuracy, t.$62 AS clock_out_point_accuracy, t.$63 AS is_last_child, t.$64 AS authorization_id, t.$65 AS total_hours, t.$66 AS payments_total, t.$67 AS authorization_split_amount, t.$68 AS authorization_split_item_id, t.$69 AS in_facility, t.$70 AS in_facility_pay_rates, t.$71 AS pay_rate_obj_id, t.$72 AS bill_rate_obj_id, t.$73 AS rate_category_id, t.$74 AS deleted, t.$75 AS originator_id, t.$76 AS last_updated_by_id, t.$77 AS deleted_by_id, t.$78 AS created, t.$79 AS updated, t.$80 AS overtime_rate_type, t.$81 AS clocked_out, t.$82 AS meta, t.$83 AS clock_in_point, t.$84 AS clock_out_point, t.$85 AS bill_and_pay_type, t.$86 AS place_id, t.$87 AS hash, t.$88 AS original_bill_rate_amount, t.$89 AS original_pay_rate_amount, t.$90 AS bill_tiered, t.$91 AS pay_tiered, t.$92 AS pay_rate_category_id, t.$93 AS is_community_care, t.$94 AS clock_in_local, t.$95 AS clock_out_local, t.$96 AS date_deleted, t.$97 AS new_total_bill_hours, t.$98 AS new_total_pay_hours, t.$99 AS franchisor_id, t.$100 AS SYS_CHANGE_VERSION, t.$101 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$101,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_carelogs_carelog.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';