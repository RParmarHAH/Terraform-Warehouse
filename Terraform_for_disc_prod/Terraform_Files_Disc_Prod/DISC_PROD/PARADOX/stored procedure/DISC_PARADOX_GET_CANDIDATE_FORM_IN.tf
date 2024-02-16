resource "snowflake_procedure" "DISC_PARADOX_GET_CANDIDATE_FORM_IN" {
	name ="GET_CANDIDATE_FORM_IN"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  GET_CANDIDATE_FORM_IN 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR										NOTES:
-- ----------		-------------------							-----------------------------------------------------------------------------------------------
-- 2023-11-20		KOMAL DHOKAI/RAVI SUTHAR					INITIAL DEVELOPMENT
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.PARADOX.HIST_CANDIDATE_FORM_IN (SELECT DISTINCT A.$1 Form_Name,  A.$2 Location_Code,  A.$3 Location_Name,  A.$4 Job_Applied_to,  A.$5 Job_Req_ID,  A.$6 Job_Title,  A.$7 Current_Candidate_Journey_Status,  A.$8 Candidate_ID,  A.$9 Candidate_Name,  A.$10 Form_Date_Sent,  A.$11 Form_In_Progress_Date,  A.$12 Form_Completion_Status,  A.$13 Form_Date_Submitted,  A.$14 Form_Preview_Link,  A.$15 Published_Date,  A.$16 Published_Version,  A.$17 Profile_ID,  A.$18 Multiple_Records,  A.$19 Primary_Identifier,  A.$20 Reapply_in_Capture,  A.$21 Reapply_in_Job_Search,  A.$22 Reapply_in_Campaign,  A.$23 Personal_Information_Your_full_name,  A.$24 Personal_Information_Phone_number,  A.$25 Personal_Information_Email_address, trim(parse_json(A.$26):"address",''"'') PERSONAL_INFORMATION_STREET_ADDRESS_LINE_1, trim(parse_json(A.$26):"address_2",''"'') PERSONAL_INFORMATION_STREET_ADDRESS_LINE_2, trim(parse_json(A.$26):"city",''"'') PERSONAL_INFORMATION_CITY, trim(parse_json(A.$26):"state",''"'') PERSONAL_INFORMATION_STATE, trim(parse_json(A.$26):"zip_code",''"'') PERSONAL_INFORMATION_ZIP_CODE, null PERSONAL_INFORMATION_EMERGENCY_CONTACT_NAME, null PERSONAL_INFORMATION_EMERGENCY_CONTACT_ALTERNATE_PHONE_NUMBER, null Personal_Information_Relation_to_Caregiver,  A.$27 Personal_Information_How_did_you_hear_about_this_job,  A.$28 Personal_Information_If_other_where,  A.$29 Personal_Information_Do_you_have_a_relative_that_works_for_Help_at_Home_If_so_what_is_their_name,  A.$30 Personal_Information_Available_Days,  A.$31 Personal_Information_Have_you_previously_worked_for_Help_at_Home,  A.$32 Personal_Information_Do_you_have_the_legal_right_to_work_in_the_US_without_sponsorships,  A.$33 Education_History_Do_you_have_a_High_School_Diploma_or_GED,  A.$34 Education_History_If_yes_what_is_the_name_of_the_school,  A.$35 Employment_History_1__Employment_Name,  A.$36 Employment_History_2__Employment_Name,  A.$37 Employment_History_3__Employment_Name,  A.$38 Employment_History_1__Employer_City,  A.$39 Employment_History_2__Employer_City,  A.$40 Employment_History_3__Employer_City,  A.$41 Employment_History_1__Employer_State,  A.$42 Employment_History_2__Employer_State,  A.$43 Employment_History_3__Employer_State,  A.$44 Employment_History_1__Employer_Phone_Number,  A.$45 Employment_History_2__Employer_Phone_Number,  A.$46 Employment_History_3__Employer_Phone_Number,  A.$47 Employment_History_1__Supervisor_Name,  A.$48 Employment_History_2__Supervisor_Name,  A.$49 Employment_History_3__Supervisor_Name,  A.$50 Employment_History_1__Position,  A.$51 Employment_History_2__Position,  A.$52 Employment_History_3__Position,  A.$53 Employment_History_1__Date_Started,  A.$54 Employment_History_2__Date_Started,  A.$55 Employment_History_3__Date_Started,  A.$56 Employment_History_1__Date_Ended,  A.$57 Employment_History_2__Date_Ended,  A.$58 Employment_History_3__Date_Ended,  A.$59 Employment_History_1__Reason_For_Leaving,  A.$60 Employment_History_2__Reason_For_Leaving,  A.$61 Employment_History_3__Reason_For_Leaving,  A.$62 Equal_Employment_Opportunity_EEO_Voluntary_SelfIdentification,  A.$63 Equal_Employment_Opportunity_Equal_Employment_Opportunity,  A.$64 Equal_Employment_Opportunity_What_is_your_preferred_language_for_communication,  A.$65 References_NAME_OF_REFERENCE_1,  A.$66 References_Phone_Number_1,  A.$67 References_Relationship_1,  A.$68 References_NAME_OF_REFERENCE_2,  A.$69 References_Phone_Number_2,  A.$70 References_Relationship_2,  A.$71 Proof_of_Residency_Have_you_been_a_resident_of_Indiana_for_2_consecutive_years,  A.$72 Attestation_Please_read_and_sign_this_form_in_the_space_provided_below,  A.$73 Attestation_Please_confirm_you_have_reviewed_the_statement_above_and_agree_to_the_terms,  A.$74 BACKGROUND_CHECK_CONSENT_FORM_BACKGROUND_CHECK_CONSENT_FORM,  A.$75 Final_Submission,  -1 AS ETL_TASK_KEY,  -1 AS ETL_INSERTED_TASK_KEY,  current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,  current_user() AS ETL_INSERTED_BY,  current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,  current_user() AS ETL_LAST_UPDATED_BY,  0 as ETL_DELETED_FLAG  FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/PARADOX/Upload_file/FormsCandidate.Forms.Detail.Report.Wide.Format.In.Application (file_format => DISC_${var.SF_ENVIRONMENT}.PUBLIC.CSV_Format) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.PARADOX.CANDIDATE_FORM_IN AS  SELECT * FROM DISC_${var.SF_ENVIRONMENT}.PARADOX.HIST_CANDIDATE_FORM_IN WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.PARADOX.HIST_CANDIDATE_FORM_IN);

    return ''Success'';
END;

 EOT
}

