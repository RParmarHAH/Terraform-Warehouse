resource "snowflake_procedure" "DISC_CCSI_GET_EMPLOYEE1" {
	name ="GET_EMPLOYEE1"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CCSI.GET_EMPLOYEE1 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.CCSI.EMPLOYEE1 select w.$1 as record_number,w.$6 as employee_number ,w.$7 as employee_name,w.$8 as hourly_rate_service_type_25,w.$9 as overtime_rate_training,w.$10 as special_rate_service_type_21,w.$11 as address,w.$12 as city ,w.$13 as state ,w.$14 as zipcode,w.$15 as ss,w.$16 as phonenumber,w.$17 as level_of_training,w.$18 as physical_date,w.$19 as tb_test_date,w.$20 as disciplinary_level,w.$21 as federal_deductions ,w.$22 as state_deductions,w.$23 as date_of_birth,w.$24 as first_day_of_work_date,w.$25 as hire_date,w.$26 as mail_check_to_employee,w.$27 as rehire ,w.$28 as i_9 ,w.$29 as desires_more_hours ,w.$30 as requires_homemaker_docs ,w.$31 as termination_date ,w.$32 as probationary_evaluation ,w.$33 as personalcell_opt_in ,w.$34 as marital_status ,w.$35 as fed_extra,w.$36 as state_extra,w.$37 as position,w.$38 as new_record,w.$39 as working_as_homemaker,w.$40 as supervisory_desk ,w.$41 as currency_exchange_preference ,w.$42 as client_am_phone ,w.$43 as client_pm_phone ,w.$44 as inactive_field ,w.$45 as inactive_date_and_info,w.$46 as phone_release,w.$47 as ins_code,w.$48 as ins_amt,w.$49 as public_aid ,w.$50 as public_aid_office ,w.$51 as notified_termed,w.$52 as dln,w.$53 as expires,w.$54 as auto_ins_expires,w.$55 as background_status,w.$56 as upload_date,w.$57 as last_name ,w.$58 as first_name,w.$59 as middle_initial ,w.$60 as sex ,w.$61 as race ,w.$62 as cellphone ,w.$63 as fingerprinted ,w.$64 as fp_response_date ,w.$65 as fp_verified_date ,w.$66 as relook_flag ,w.$67 as notpaid_counter ,w.$68 as family_care_giver ,w.$69 as area ,w.$70 as last_paid ,w.$71 as region ,w.$72 as call ,w.$73 as influenza_shot ,w.$74 as oty ,w.$75 as pre_empid ,w.$76 as has_smartphone ,w.$2 as created_date,w.$3 as created_by ,w.$4 as updated_date,w.$5 as updated_by,''-1'' AS ETL_TASK_KEY,''-1''    AS ETL_INSERTED_TASK_KEY,current_timestamp ::TIMESTAMP_NTZ(9)    AS ETL_INSERTED_DATE,CURRENT_USER()    AS ETL_INSERTED_BY,current_timestamp ::TIMESTAMP_NTZ(9)    AS ETL_LAST_UPDATED_DATE,CURRENT_USER()    AS ETL_LAST_UPDATED_BY,''FALSE'' AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/fjn/Employee1(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.tab_format, pattern =>''.*csv'')w;


    return ''Success'';
END;

 EOT
}

