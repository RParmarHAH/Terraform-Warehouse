CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_CLEARCARE_DIM_CLIENT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    MERGE INTO HAH.DIM_CLIENT TGT 
	USING STAGE.CLEARCARE_DIM_CLIENT STG 
	ON TGT.CLIENT_KEY = STG.CLIENT_KEY
	WHEN MATCHED THEN 
	UPDATE SET 
	    TGT.CLIENT_KEY=STG.CLIENT_KEY
,TGT.CLIENT_NUMBER=STG.CLIENT_NUMBER
,TGT.SYSTEM_CODE=STG.SYSTEM_CODE
,TGT.SOURCE_SYSTEM_ID=STG.SOURCE_SYSTEM_ID
,TGT.CLIENT_PID=STG.CLIENT_PID 
,TGT.CLIENT_MEDICARE_ID = STG.CLIENT_MEDICARE_ID
,TGT.MEDICAID_ID = STG.MEDICAID_ID
,TGT.CLIENT_DOB=STG.CLIENT_DOB
,TGT.CLIENT_DATE_OF_DEATH=STG.CLIENT_DATE_OF_DEATH
,TGT.CLIENT_GENDER=STG.CLIENT_GENDER
,TGT.CLIENT_ETHNICITY=STG.CLIENT_ETHNICITY
,TGT.HISPANIC_OR_LATINO = STG.HISPANIC_OR_LATINO
,TGT.CLIENT_GENDER_IDENTITY = STG.CLIENT_GENDER_IDENTITY
,TGT.CLIENT_SEXUAL_ORIENTATION = STG.CLIENT_SEXUAL_ORIENTATION
,TGT.CLIENT_RACE = STG.CLIENT_RACE
,TGT.CLIENT_MARITAL_STATUS=STG.CLIENT_MARITAL_STATUS
,TGT.CLIENT_SALUTATION=STG.CLIENT_SALUTATION
,TGT.CLIENT_FIRST_NAME=STG.CLIENT_FIRST_NAME
,TGT.CLIENT_MIDDLE_NAME=STG.CLIENT_MIDDLE_NAME
,TGT.CLIENT_LAST_NAME=STG.CLIENT_LAST_NAME
,TGT.CLIENT_NAME=STG.CLIENT_NAME
,TGT.CLIENT_ADDRESS1=STG.CLIENT_ADDRESS1
,TGT.CLIENT_ADDRESS2=STG.CLIENT_ADDRESS2
,TGT.CLIENT_CITY=STG.CLIENT_CITY
,TGT.CLIENT_STATE_CODE=STG.CLIENT_STATE_CODE
,TGT.CLIENT_ZIP=STG.CLIENT_ZIP
,TGT.CLIENT_CLN_ADDRESS1=STG.CLIENT_CLN_ADDRESS1
,TGT.CLIENT_CLN_ADDRESS2=STG.CLIENT_CLN_ADDRESS2
,TGT.CLIENT_CLN_CITY=STG.CLIENT_CLN_CITY
,TGT.CLIENT_CLN_STATE_CODE=STG.CLIENT_CLN_STATE_CODE
,TGT.CLIENT_CLN_ZIP=STG.CLIENT_CLN_ZIP
,TGT.CLIENT_STD_ADDRESS1=STG.CLIENT_STD_ADDRESS1
,TGT.CLIENT_STD_ADDRESS2=STG.CLIENT_STD_ADDRESS2
,TGT.CLIENT_STD_CITY=STG.CLIENT_STD_CITY
,TGT.CLIENT_STD_STATE_CODE=STG.CLIENT_STD_STATE_CODE
,TGT.CLIENT_STD_ZIP=STG.CLIENT_STD_ZIP
,TGT.CLIENT_HOME_PHONE=STG.CLIENT_HOME_PHONE
,TGT.CLIENT_CELL_PHONE=STG.CLIENT_CELL_PHONE
,TGT.CLIENT_WORK_PHONE=STG.CLIENT_WORK_PHONE
,TGT.CLIENT_FAX_NUMBER=STG.CLIENT_FAX_NUMBER
,TGT.CLIENT_PERSONAL_EMAIL=STG.CLIENT_PERSONAL_EMAIL
,TGT.REFERRAL_DATE=STG.REFERRAL_DATE
,TGT.DAYS_TO_SERVICE=STG.DAYS_TO_SERVICE
,TGT.CONTRACT_BEGIN_DATE=STG.CONTRACT_BEGIN_DATE
,TGT.CONTRACT_END_DATE=STG.CONTRACT_END_DATE
,TGT.FIRST_SERVICE_DATE=STG.FIRST_SERVICE_DATE
,TGT.LAST_SERVICE_DATE=STG.LAST_SERVICE_DATE
,TGT.BEGIN_DATE=STG.BEGIN_DATE
,TGT.END_DATE=STG.END_DATE
,TGT.ACTIVE_CLIENT_FLAG=STG.ACTIVE_CLIENT_FLAG
,TGT.DISCHARGE_REASON= STG.DISCHARGE_REASON										   
,TGT.ON_HOLD_FLAG=STG.ON_HOLD_FLAG
,TGT.ON_HOLD_START_DATE=STG.ON_HOLD_START_DATE
,TGT.ON_HOLD_END_DATE=STG.ON_HOLD_END_DATE
,TGT.LINKED_ID=STG.LINKED_ID
,TGT.ACQUIRED_FROM_COMPANY_KEY=STG.ACQUIRED_FROM_COMPANY_KEY
,TGT.ACQUIRED_FROM_COMPANY_ID=STG.ACQUIRED_FROM_COMPANY_ID
,TGT.ACQUIRED_FROM_COMPANY_FULL_NAME=STG.ACQUIRED_FROM_COMPANY_FULL_NAME
,TGT.ACQUISITION_DATE=STG.ACQUISITION_DATE
,TGT.ACQUISITION_FLAG=STG.ACQUISITION_FLAG
,TGT.ADMISSION_DATE=STG.ADMISSION_DATE
,TGT.ADMISSION_FLAG=STG.ADMISSION_FLAG
,TGT.CLIENT_CONVERTED_FLAG=STG.CLIENT_CONVERTED_FLAG
,TGT.PRIMARY_SUPERVISOR_KEY=STG.PRIMARY_SUPERVISOR_KEY
,TGT.PRIMARY_SUPERVISOR_CODE=STG.PRIMARY_SUPERVISOR_CODE
,TGT.PRIMARY_SUPERVISOR_NAME=STG.PRIMARY_SUPERVISOR_NAME
,TGT.SECONDARY_SUPERVISOR_KEY=STG.SECONDARY_SUPERVISOR_KEY
,TGT.SECONDARY_SUPERVISOR_CODE=STG.SECONDARY_SUPERVISOR_CODE
,TGT.SECONDARY_SUPERVISOR_NAME=STG.SECONDARY_SUPERVISOR_NAME
,TGT.PRIMARY_BRANCH_KEY=STG.PRIMARY_BRANCH_KEY
,TGT.PRIMARY_BRANCH_NAME=STG.PRIMARY_BRANCH_NAME
,TGT.PRIMARY_BRANCH_STATE=STG.PRIMARY_BRANCH_STATE
,TGT.GUARANTOR_NAME=STG.GUARANTOR_NAME
,TGT.NOTES=STG.NOTES
,TGT.AGENCY=STG.AGENCY
,TGT.EFFECTIVE_FROM_DATE=STG.EFFECTIVE_FROM_DATE
,TGT.EFFECTIVE_TO_DATE=STG.EFFECTIVE_TO_DATE
,TGT.ETL_TASK_KEY=STG.ETL_TASK_KEY
,TGT.ETL_INSERTED_TASK_KEY=STG.ETL_INSERTED_TASK_KEY
,TGT.ETL_INSERTED_DATE=STG.ETL_INSERTED_DATE
,TGT.ETL_INSERTED_BY=STG.ETL_INSERTED_BY
,TGT.ETL_LAST_UPDATED_DATE=STG.ETL_LAST_UPDATED_DATE
,TGT.ETL_LAST_UPDATED_BY=STG.ETL_LAST_UPDATED_BY
,TGT.ETL_DELETED_FLAG=STG.ETL_DELETED_FLAG
,TGT.ETL_INFERRED_MEMBER_FLAG=STG.ETL_INFERRED_MEMBER_FLAG      
	WHEN NOT MATCHED THEN 
	INSERT ( 
	   CLIENT_KEY
,CLIENT_NUMBER
,SYSTEM_CODE
,SOURCE_SYSTEM_ID
,CLIENT_PID	  
,CLIENT_MEDICARE_ID 
,MEDICAID_ID
,CLIENT_DOB
,CLIENT_DATE_OF_DEATH
,CLIENT_GENDER
,CLIENT_ETHNICITY  
,HISPANIC_OR_LATINO
,CLIENT_GENDER_IDENTITY 
,CLIENT_SEXUAL_ORIENTATION 
,CLIENT_RACE
,CLIENT_MARITAL_STATUS
,CLIENT_SALUTATION
,CLIENT_FIRST_NAME
,CLIENT_MIDDLE_NAME
,CLIENT_LAST_NAME
,CLIENT_NAME
,CLIENT_ADDRESS1
,CLIENT_ADDRESS2
,CLIENT_CITY
,CLIENT_STATE_CODE
,CLIENT_ZIP
,CLIENT_CLN_ADDRESS1
,CLIENT_CLN_ADDRESS2
,CLIENT_CLN_CITY
,CLIENT_CLN_STATE_CODE
,CLIENT_CLN_ZIP
,CLIENT_STD_ADDRESS1
,CLIENT_STD_ADDRESS2
,CLIENT_STD_CITY
,CLIENT_STD_STATE_CODE
,CLIENT_STD_ZIP
,CLIENT_HOME_PHONE
,CLIENT_CELL_PHONE
,CLIENT_WORK_PHONE
,CLIENT_FAX_NUMBER
,CLIENT_PERSONAL_EMAIL
,REFERRAL_DATE
,DAYS_TO_SERVICE
,CONTRACT_BEGIN_DATE
,CONTRACT_END_DATE
,FIRST_SERVICE_DATE
,LAST_SERVICE_DATE
,BEGIN_DATE
,END_DATE
,ACTIVE_CLIENT_FLAG
,DISCHARGE_REASON				 
,ON_HOLD_FLAG
,ON_HOLD_START_DATE
,ON_HOLD_END_DATE
,LINKED_ID
,ACQUIRED_FROM_COMPANY_KEY
,ACQUIRED_FROM_COMPANY_ID
,ACQUIRED_FROM_COMPANY_FULL_NAME
,ACQUISITION_DATE
,ACQUISITION_FLAG
,ADMISSION_DATE
,ADMISSION_FLAG
,CLIENT_CONVERTED_FLAG
,PRIMARY_SUPERVISOR_KEY
,PRIMARY_SUPERVISOR_CODE
,PRIMARY_SUPERVISOR_NAME
,SECONDARY_SUPERVISOR_KEY
,SECONDARY_SUPERVISOR_CODE
,SECONDARY_SUPERVISOR_NAME
,PRIMARY_BRANCH_KEY
,PRIMARY_BRANCH_NAME
,PRIMARY_BRANCH_STATE
,GUARANTOR_NAME
,NOTES
,AGENCY
,EFFECTIVE_FROM_DATE
,EFFECTIVE_TO_DATE
,ETL_TASK_KEY
,ETL_INSERTED_TASK_KEY
,ETL_INSERTED_DATE
,ETL_INSERTED_BY
,ETL_LAST_UPDATED_DATE
,ETL_LAST_UPDATED_BY
,ETL_DELETED_FLAG
,ETL_INFERRED_MEMBER_FLAG
	) 
	VALUES (
	   STG.CLIENT_KEY
,STG.CLIENT_NUMBER
,STG.SYSTEM_CODE
,STG.SOURCE_SYSTEM_ID
,STG.CLIENT_PID	
,STG.CLIENT_MEDICARE_ID 
,STG.MEDICAID_ID
,STG.CLIENT_DOB
,STG.CLIENT_DATE_OF_DEATH
,STG.CLIENT_GENDER
,STG.CLIENT_ETHNICITY 
,STG.HISPANIC_OR_LATINO
,STG.CLIENT_GENDER_IDENTITY 
,STG.CLIENT_SEXUAL_ORIENTATION 
,STG.CLIENT_RACE
,STG.CLIENT_MARITAL_STATUS
,STG.CLIENT_SALUTATION
,STG.CLIENT_FIRST_NAME
,STG.CLIENT_MIDDLE_NAME
,STG.CLIENT_LAST_NAME
,STG.CLIENT_NAME
,STG.CLIENT_ADDRESS1
,STG.CLIENT_ADDRESS2
,STG.CLIENT_CITY
,STG.CLIENT_STATE_CODE
,STG.CLIENT_ZIP
,STG.CLIENT_CLN_ADDRESS1
,STG.CLIENT_CLN_ADDRESS2
,STG.CLIENT_CLN_CITY
,STG.CLIENT_CLN_STATE_CODE
,STG.CLIENT_CLN_ZIP
,STG.CLIENT_STD_ADDRESS1
,STG.CLIENT_STD_ADDRESS2
,STG.CLIENT_STD_CITY
,STG.CLIENT_STD_STATE_CODE
,STG.CLIENT_STD_ZIP
,STG.CLIENT_HOME_PHONE
,STG.CLIENT_CELL_PHONE
,STG.CLIENT_WORK_PHONE
,STG.CLIENT_FAX_NUMBER
,STG.CLIENT_PERSONAL_EMAIL
,STG.REFERRAL_DATE
,STG.DAYS_TO_SERVICE
,STG.CONTRACT_BEGIN_DATE
,STG.CONTRACT_END_DATE
,STG.FIRST_SERVICE_DATE
,STG.LAST_SERVICE_DATE
,STG.BEGIN_DATE
,STG.END_DATE
,STG.ACTIVE_CLIENT_FLAG
,STG.DISCHARGE_REASON					 
,STG.ON_HOLD_FLAG
,STG.ON_HOLD_START_DATE
,STG.ON_HOLD_END_DATE
,STG.LINKED_ID
,STG.ACQUIRED_FROM_COMPANY_KEY
,STG.ACQUIRED_FROM_COMPANY_ID
,STG.ACQUIRED_FROM_COMPANY_FULL_NAME
,STG.ACQUISITION_DATE
,STG.ACQUISITION_FLAG
,STG.ADMISSION_DATE
,STG.ADMISSION_FLAG
,STG.CLIENT_CONVERTED_FLAG
,STG.PRIMARY_SUPERVISOR_KEY
,STG.PRIMARY_SUPERVISOR_CODE
,STG.PRIMARY_SUPERVISOR_NAME
,STG.SECONDARY_SUPERVISOR_KEY
,STG.SECONDARY_SUPERVISOR_CODE
,STG.SECONDARY_SUPERVISOR_NAME
,STG.PRIMARY_BRANCH_KEY
,STG.PRIMARY_BRANCH_NAME
,STG.PRIMARY_BRANCH_STATE
,STG.GUARANTOR_NAME
,STG.NOTES
,STG.AGENCY
,STG.EFFECTIVE_FROM_DATE
,STG.EFFECTIVE_TO_DATE
,STG.ETL_TASK_KEY
,STG.ETL_INSERTED_TASK_KEY
,STG.ETL_INSERTED_DATE
,STG.ETL_INSERTED_BY
,STG.ETL_LAST_UPDATED_DATE
,STG.ETL_LAST_UPDATED_BY
,STG.ETL_DELETED_FLAG
,STG.ETL_INFERRED_MEMBER_FLAG
	)
;
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
    ';