CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_BILLING_ITEM("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_billing_item 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.billing_item  (SELECT t.$1 AS id, t.$2 AS agency_id, t.$3 AS item_type, t.$4 AS the_date, t.$5 AS carelog_id, t.$6 AS bill, t.$7 AS bill_rate, t.$8 AS bill_profile_id, t.$9 AS bill_amount, t.$10 AS bill_finalized, t.$11 AS bill_queued, t.$12 AS bill_exported, t.$13 AS pay, t.$14 AS pay_rate, t.$15 AS pay_profile_id, t.$16 AS pay_amount, t.$17 AS pay_finalized, t.$18 AS pay_queued, t.$19 AS pay_exported, t.$20 AS raw_description, t.$21 AS miles, t.$22 AS start_time, t.$23 AS end_time, t.$24 AS total_time, t.$25 AS visit_note, t.$26 AS bill_rate_method, t.$27 AS bill_rate_instance_id, t.$28 AS pay_rate_method, t.$29 AS pay_rate_instance_id, t.$30 AS location, t.$31 AS service, t.$32 AS bill_rate_name, t.$33 AS pay_rate_name, t.$34 AS bill_invoiced, t.$35 AS from_carelog_id, t.$36 AS to_carelog_id, t.$37 AS bill_pro_rate, t.$38 AS bill_reg_for_live_ins, t.$39 AS bill_live_in_hours_to_count, t.$40 AS bill_ot, t.$41 AS bill_dot, t.$42 AS bill_auto_ot, t.$43 AS bill_auto_dot, t.$44 AS bill_holiday_multiplier, t.$45 AS pay_pro_rate, t.$46 AS pay_average_rate, t.$47 AS pay_reg_for_live_ins, t.$48 AS pay_live_in_hours_to_count, t.$49 AS pay_ot, t.$50 AS pay_dot, t.$51 AS pay_auto_ot, t.$52 AS pay_auto_ot_is_week, t.$53 AS pay_auto_dot, t.$54 AS pay_auto_dot_is_week, t.$55 AS pay_holiday_multiplier, t.$56 AS cci_start, t.$57 AS cci_end, t.$58 AS pay_excel_exported, t.$59 AS payments_total, t.$60 AS authorization_id, t.$61 AS created, t.$62 AS updated, t.$63 AS deleted, t.$64 AS originator_id, t.$65 AS last_updated_by_id, t.$66 AS deleted_by_id, t.$67 AS travel_time_edited, t.$68 AS shift_id, t.$69 AS original_estimate_id, t.$70 AS shift_start_date, t.$71 AS ab_adjustment_carelog_id, t.$72 AS overtime_rate_type, t.$73 AS is_bulk_added_item, t.$74 AS scheduled_item_id, t.$75 AS meta, t.$76 AS cci_start_local, t.$77 AS cci_end_local, t.$78 AS date_deleted, t.$79 AS franchisor_id, t.$80 AS SYS_CHANGE_VERSION, t.$81 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$81,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_billing_item.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';