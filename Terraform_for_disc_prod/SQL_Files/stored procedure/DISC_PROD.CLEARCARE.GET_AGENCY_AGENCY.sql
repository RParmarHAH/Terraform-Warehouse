CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_AGENCY_AGENCY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_agency_agency 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.agency_agency  (SELECT t.$1 AS id, t.$2 AS name, t.$3 AS website, t.$4 AS subdomain, t.$5 AS background, t.$6 AS logo, t.$7 AS provides_login_link, t.$8 AS billing_policy_id, t.$9 AS pay_policy_id, t.$10 AS timezone, t.$11 AS bill_day, t.$12 AS tablets_count, t.$13 AS cc_account_owner, t.$14 AS rounding, t.$15 AS always_round_to_scheduled_time, t.$16 AS send_missed_clock_out_alerts, t.$17 AS clock_out_alert_minutes, t.$18 AS active, t.$19 AS telephony_number, t.$20 AS apply_page, t.$21 AS work_week_start, t.$22 AS allow_caregiver_mobile_phone_clockins, t.$23 AS last_activity, t.$24 AS stale, t.$25 AS calendar_interval, t.$26 AS bill_for_mileage, t.$27 AS pay_for_mileage, t.$28 AS billing_accounting_method, t.$29 AS payroll_accounting_method, t.$30 AS qbo_connection_ticket, t.$31 AS qb_token, t.$32 AS caregiver_employment_type, t.$33 AS country_id, t.$34 AS show_client_extra_field, t.$35 AS client_extra_field_label, t.$36 AS show_caregiver_extra_field, t.$37 AS caregiver_extra_field_label, t.$38 AS weekly_reports, t.$39 AS tomorrow_shifts_emails, t.$40 AS status_for_missed_shifts, t.$41 AS missed_clockin_alerts_minutes, t.$42 AS preferred_care_franchise, t.$43 AS allow_ad_hoc_carelogs, t.$44 AS address, t.$45 AS address_line_2, t.$46 AS city, t.$47 AS state, t.$48 AS zip, t.$49 AS care_management, t.$50 AS qb_do_inital_import, t.$51 AS live_in_remainder_hours, t.$52 AS custom_field_label, t.$53 AS custom_field_for_caregiver, t.$54 AS esignature_client_flag, t.$55 AS esignature_caregiver_flag, t.$56 AS esignature_caremanager_flag, t.$57 AS total_time_increments, t.$58 AS set_rates_by, t.$59 AS billing_print_invoices, t.$60 AS activate_scheduler_field, t.$61 AS activate_marketer_field, t.$62 AS activate_primary_manager_field, t.$63 AS activate_secondary_manager_field, t.$64 AS text_messaging_emails, t.$65 AS show_caregiver_race_field, t.$66 AS pay_live_in_hours_to_count, t.$67 AS forbid_mobile_clock_in, t.$68 AS pay_bill_per_visit_day, t.$69 AS group_children_carelogs_on_invoices, t.$70 AS group_children_carelogs_on_bills, t.$71 AS payroll_excel_export, t.$72 AS bill_live_in_hours_to_count, t.$73 AS assign_qb_time_data_to_customers, t.$74 AS qb_match_on_payer, t.$75 AS qb_setup_stage, t.$76 AS qb_owner_id, t.$77 AS track_receivables_in_clearcare, t.$78 AS new_invoices, t.$79 AS invoice_duedate_terms, t.$80 AS invoice_start_number, t.$81 AS travel_time, t.$82 AS travel_time_minutes, t.$83 AS travel_time_pay_rate_id, t.$84 AS invoice_terms, t.$85 AS payroll_filtering_by_client_location, t.$86 AS invoicing_allow_historical_uploads, t.$87 AS invoicing_charge_interest, t.$88 AS invoicing_interest_rate, t.$89 AS invoicing_num_days_interest_begins, t.$90 AS phone_number, t.$91 AS fax_number, t.$92 AS invoicing_hide_carelog_hours, t.$93 AS export_with_external_id, t.$94 AS family_room_care_logs_show_comments, t.$95 AS billing_exceptions_note, t.$96 AS invoicing_allow_email_option, t.$97 AS invoicing_id_prefix, t.$98 AS date_last_tomorrow_shifts_email_sent, t.$99 AS salesforce_sync, t.$100 AS caregiver_auto_logout_time, t.$101 AS invoicing_tax_rate, t.$102 AS invoicing_compound_tax_rate, t.$103 AS invoicing_royalty_percentage, t.$104 AS clock_in_grace_minutes, t.$105 AS clock_out_grace_minutes, t.$106 AS filter_by_locations, t.$107 AS show_caregiver_excel_import_link, t.$108 AS show_medication_management, t.$109 AS salesforce_realtime_sync, t.$110 AS pay_bill_live_in_day, t.$111 AS payroll_id, t.$112 AS payroll_company_export, t.$113 AS payroll_show_rate_code_fields, t.$114 AS payroll_mileage_rate_code, t.$115 AS payroll_travel_time_rate_code, t.$116 AS payroll_expenses_rate_code, t.$117 AS payroll_holiday_rate_code, t.$118 AS payroll_live_in_rate_code, t.$119 AS payroll_hourly_rate_code, t.$120 AS payroll_per_visit_rate_code, t.$121 AS updated, t.$122 AS created, t.$123 AS invoicing_tax_carelogs, t.$124 AS invoicing_tax_mileage, t.$125 AS invoicing_tax_expenses, t.$126 AS show_clock_in_alerts_caregiver_interface, t.$127 AS show_clock_in_alerts_mobile_phone, t.$128 AS show_clock_in_alerts_unknown_number, t.$129 AS exclude_non_hourly_for_ot, t.$130 AS invoicing_hide_overdue_stamp, t.$131 AS allow_mobile_phone_clockins_without_caller_id, t.$132 AS single_source_price, t.$133 AS setup_wizard_status, t.$134 AS rates_and_authorizations, t.$135 AS display_rate_amounts, t.$136 AS geolocation, t.$137 AS stage, t.$138 AS payroll_overtime_rate_code, t.$139 AS payroll_double_overtime_rate_code, t.$140 AS payroll_rate_number_code, t.$141 AS payroll_export_split_live_in_shifts, t.$142 AS billing_include_trailing_day, t.$143 AS allow_voice_messaging_next_caregiver, t.$144 AS us_federal_tax_id, t.$145 AS cms_1500, t.$146 AS single_source_password, t.$147 AS single_source_username, t.$148 AS single_source_credentials_valid, t.$149 AS invoice_type, t.$150 AS single_source_commission_payable, t.$151 AS allow_non_hourly_authorizations, t.$152 AS payroll_dept_code, t.$153 AS agency_name_for_reporting, t.$154 AS prefer_scheduled_time_when_rounding, t.$155 AS billing_export_type_id, t.$156 AS payroll_export_type_id, t.$157 AS client_external_id, t.$158 AS hide_family_room_tooltip, t.$159 AS use_real_sms, t.$160 AS twilio_number_id, t.$161 AS ar_scheduling_limit, t.$162 AS caregiver_edit_shift_window, t.$163 AS double_alpha_numeric_password, t.$164 AS location_name, t.$165 AS family_room_show_caregiver_contact_info, t.$166 AS family_room_available_tabs, t.$167 AS family_room_hidden_tabs, t.$168 AS turn_on_adls_section, t.$169 AS tagging, t.$170 AS allow_payments_per_item, t.$171 AS caregiver_require_shift_confirmations, t.$172 AS travel_type, t.$173 AS use_which_scheduler, t.$174 AS scheduling_horizon, t.$175 AS salesforce_account_id, t.$176 AS zuora_connection_id, t.$177 AS zuora_account_id, t.$178 AS zuora_client_rate_plan_id, t.$179 AS zuora_client_product_rate_plan_charge_id, t.$180 AS high_watermark_type, t.$181 AS invoiced_by_accounting, t.$182 AS split_payer, t.$183 AS caregiver_portal_view_other_caregiver, t.$184 AS facility_pay_policy_id, t.$185 AS facility_pay_threshold, t.$186 AS invoice_show_rate_names, t.$187 AS payroll_overtime_holiday_rate_code, t.$188 AS payroll_double_overtime_holiday_rate_code, t.$189 AS payroll_per_visit_holiday_rate_code, t.$190 AS payroll_per_visit_overtime_rate_code, t.$191 AS payroll_per_visit_overtime_holiday_rate_code, t.$192 AS payroll_per_visit_double_overtime_rate_code, t.$193 AS payroll_per_visit_double_overtime_holiday_rate_code, t.$194 AS payroll_job_code, t.$195 AS payroll_live_in_holiday_rate_code, t.$196 AS payroll_live_in_overtime_rate_code, t.$197 AS payroll_live_in_overtime_holiday_rate_code, t.$198 AS payroll_live_in_double_overtime_rate_code, t.$199 AS payroll_live_in_double_overtime_holiday_rate_code, t.$200 AS payroll_rate_or_total, t.$201 AS payroll_dept_code_per_location, t.$202 AS payroll_visit_note_rate_code, t.$203 AS item_payroll_rate_number_care_logs, t.$204 AS item_payroll_rate_number_mileage, t.$205 AS item_payroll_rate_number_expenses, t.$206 AS item_payroll_rate_number_credits, t.$207 AS rate_names_in_calendars, t.$208 AS neat_calendars, t.$209 AS zuora_ipad_rate_plan_id, t.$210 AS zuora_ipad_product_rate_plan_charge_id, t.$211 AS burden_rate, t.$212 AS tomorrow_shift_reminder_time, t.$213 AS hide_caregiver_from_customer, t.$214 AS hide_caregiver_info_from_customer, t.$215 AS payroll_show_dept_code_fields, t.$216 AS default_hourly_rate_department_code, t.$217 AS default_live_in_rate_department_code, t.$218 AS default_per_visit_rate_department_code, t.$219 AS default_visit_note_rate_department_code, t.$220 AS default_mileage_rate_department_code, t.$221 AS default_expense_rate_department_code, t.$222 AS default_travel_time_rate_department_code, t.$223 AS tax_jurisdiction, t.$224 AS invoicing_hide_quickbooks_carelog_hours, t.$225 AS invoicing_quickbooks_full_visit_note, t.$226 AS invoicing_include_aging_summary, t.$227 AS deleted, t.$228 AS originator_id, t.$229 AS last_updated_by_id, t.$230 AS deleted_by_id, t.$231 AS travel_pay_reasonable, t.$232 AS travel_pay_reasonable_minutes, t.$233 AS qoc_enabled, t.$234 AS qoc_automatic_task_creation, t.$235 AS qoc_enable_cic_tracking, t.$236 AS qoc_enable_hsp_tracking, t.$237 AS e_pay_enable, t.$238 AS e_pay_account_id, t.$239 AS e_pay_account_token, t.$240 AS e_pay_merchant_id, t.$241 AS e_pay_terminal_id, t.$242 AS e_pay_settings_confirmed, t.$243 AS e_pay_activated, t.$244 AS autopay_enabled, t.$245 AS payroll_travel_time_overtime_rate_code, t.$246 AS payroll_travel_time_double_overtime_rate_code, t.$247 AS invoicing_disable_unlocking, t.$248 AS credit_cards_enabled, t.$249 AS ach_enabled, t.$250 AS advance_billing_enabled, t.$251 AS advance_billing_is_default, t.$252 AS payments_disable_unlocking, t.$253 AS payroll_allow_unfinalizing, t.$254 AS advance_billing_calculation, t.$255 AS show_client_info_in_reminders, t.$256 AS patient_phone_number_displays_in_the_portal, t.$257 AS safety_module_enabled, t.$258 AS recruiting_enabled, t.$259 AS advance_billing_skip_interval, t.$260 AS advance_billing_adjustment_mode_enabled, t.$261 AS invoicing_compact_layout, t.$262 AS autopay_day_delay, t.$263 AS es_activation_stage, t.$264 AS allow_alternate_client_billing_type, t.$265 AS send_ach_alerts, t.$266 AS ccois_enabled, t.$267 AS hide_worksafe_tab, t.$268 AS prepopulate_peoplepickers, t.$269 AS enable_admin_alert_subscriptions, t.$270 AS payroll_export_type_2_id, t.$271 AS payroll_export_type_3_id, t.$272 AS payroll_export_type_4_id, t.$273 AS accounting_page_filter_granularity, t.$274 AS disable_automatic_clock_out_in_for_back_to_back_shifts, t.$275 AS client_places_enabled, t.$276 AS allow_ad_hoc_telephony, t.$277 AS allow_ad_hoc_mobile, t.$278 AS require_caregiver_telephony_pin, t.$279 AS prevent_ad_hoc_telephony_shifts_exceeding_auth_limits, t.$280 AS prevent_ad_hoc_mobile_shifts_exceeding_auth_limits, t.$281 AS es_vendor, t.$282 AS enable_agency_address, t.$283 AS rounding_completed_shifts, t.$284 AS concurrent_group_care, t.$285 AS sequential_group_care, t.$286 AS tiered_by_hours, t.$287 AS enable_facility, t.$288 AS allow_mobile_clockin_with_location_disabled, t.$289 AS mobile_location_geofence_radius, t.$290 AS travel_pay_consecutive_shifts, t.$291 AS use_community_care_alternative_revenue, t.$292 AS walkme_version, t.$293 AS eclaim_integrated_partner, t.$294 AS eclaim_integrated_partner_account, t.$295 AS family_room_show_posted_pictures, t.$296 AS invoice_summarize_community_care, t.$297 AS write_locked, t.$298 AS meta, t.$299 AS eclaim_credentials_verified, t.$300 AS eclaim_integrated_partner_host, t.$301 AS eclaim_integrated_partner_password, t.$302 AS eclaim_integrated_partner_username, t.$303 AS qoc_automation_client_default, t.$304 AS bill_rounding_rule, t.$305 AS pay_rounding_rule, t.$306 AS allow_unavailability_requests_via_mobile_app, t.$307 AS franchisor_id, t.$308 AS SYS_CHANGE_VERSION, t.$309 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$309,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_agency_agency.*[.]csv.gz'') t);

   
    return ''Success'';
END;
';