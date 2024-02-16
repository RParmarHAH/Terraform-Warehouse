resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_CCSI_DIM_CLIENT" {
	name ="MERGE_STAGE_CCSI_DIM_CLIENT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT


    var sqlCmd = "";
    var sqlStmt = "";
    var result = "";

    try {
      var sqlCmd = `
    MERGE INTO HAH.DIM_CLIENT TGT 
USING STAGE.CCSI_DIM_CLIENT STAGE 
ON TGT.CLIENT_KEY = STAGE.CLIENT_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.CLIENT_NUMBER= STAGE.CLIENT_NUMBER
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.CLIENT_PID= STAGE.CLIENT_PID   
   ,TGT.CLIENT_MEDICARE_ID = STAGE.CLIENT_MEDICARE_ID
   ,TGT.MEDICAID_ID = STAGE.MEDICAID_ID
   ,TGT.CLIENT_DOB= STAGE.CLIENT_DOB
   ,TGT.CLIENT_DATE_OF_DEATH= STAGE.CLIENT_DATE_OF_DEATH
   ,TGT.CLIENT_GENDER= STAGE.CLIENT_GENDER
   ,TGT.CLIENT_ETHNICITY= STAGE.CLIENT_ETHNICITY   
   ,TGT.HISPANIC_OR_LATINO = STAGE.HISPANIC_OR_LATINO												 
    ,TGT.CLIENT_GENDER_IDENTITY = STAGE.CLIENT_GENDER_IDENTITY
   ,TGT.CLIENT_SEXUAL_ORIENTATION = STAGE.CLIENT_SEXUAL_ORIENTATION
   ,TGT.CLIENT_RACE = STAGE.CLIENT_RACE
   ,TGT.CLIENT_MARITAL_STATUS= STAGE.CLIENT_MARITAL_STATUS
   ,TGT.CLIENT_SALUTATION= STAGE.CLIENT_SALUTATION
   ,TGT.CLIENT_FIRST_NAME= STAGE.CLIENT_FIRST_NAME
   ,TGT.CLIENT_MIDDLE_NAME= STAGE.CLIENT_MIDDLE_NAME
   ,TGT.CLIENT_LAST_NAME= STAGE.CLIENT_LAST_NAME
   ,TGT.CLIENT_NAME= STAGE.CLIENT_NAME
   ,TGT.CLIENT_ADDRESS1= STAGE.CLIENT_ADDRESS1
   ,TGT.CLIENT_ADDRESS2= STAGE.CLIENT_ADDRESS2
   ,TGT.CLIENT_CITY= STAGE.CLIENT_CITY
   ,TGT.CLIENT_STATE_CODE= STAGE.CLIENT_STATE_CODE
   ,TGT.CLIENT_ZIP= STAGE.CLIENT_ZIP
   ,TGT.CLIENT_CLN_ADDRESS1= STAGE.CLIENT_CLN_ADDRESS1
   ,TGT.CLIENT_CLN_ADDRESS2= STAGE.CLIENT_CLN_ADDRESS2
   ,TGT.CLIENT_CLN_CITY= STAGE.CLIENT_CLN_CITY
   ,TGT.CLIENT_CLN_STATE_CODE= STAGE.CLIENT_CLN_STATE_CODE
   ,TGT.CLIENT_CLN_ZIP= STAGE.CLIENT_CLN_ZIP
   ,TGT.CLIENT_STD_ADDRESS1= STAGE.CLIENT_STD_ADDRESS1
   ,TGT.CLIENT_STD_ADDRESS2= STAGE.CLIENT_STD_ADDRESS2
   ,TGT.CLIENT_STD_CITY= STAGE.CLIENT_STD_CITY
   ,TGT.CLIENT_STD_STATE_CODE= STAGE.CLIENT_STD_STATE_CODE
   ,TGT.CLIENT_STD_ZIP= STAGE.CLIENT_STD_ZIP
   ,TGT.CLIENT_HOME_PHONE= STAGE.CLIENT_HOME_PHONE
   ,TGT.CLIENT_CELL_PHONE= STAGE.CLIENT_CELL_PHONE
   ,TGT.CLIENT_WORK_PHONE= STAGE.CLIENT_WORK_PHONE
   ,TGT.CLIENT_FAX_NUMBER= STAGE.CLIENT_FAX_NUMBER
   ,TGT.CLIENT_PERSONAL_EMAIL= STAGE.CLIENT_PERSONAL_EMAIL
   ,TGT.REFERRAL_DATE= STAGE.REFERRAL_DATE
   ,TGT.DAYS_TO_SERVICE= STAGE.DAYS_TO_SERVICE
   ,TGT.CONTRACT_BEGIN_DATE= STAGE.CONTRACT_BEGIN_DATE
   ,TGT.CONTRACT_END_DATE= STAGE.CONTRACT_END_DATE
   ,TGT.FIRST_SERVICE_DATE= STAGE.FIRST_SERVICE_DATE
   ,TGT.LAST_SERVICE_DATE= STAGE.LAST_SERVICE_DATE
   ,TGT.BEGIN_DATE= STAGE.BEGIN_DATE
   ,TGT.END_DATE= STAGE.END_DATE
   ,TGT.ACTIVE_CLIENT_FLAG= STAGE.ACTIVE_CLIENT_FLAG
   ,TGT.ON_HOLD_FLAG= STAGE.ON_HOLD_FLAG
   ,TGT.ON_HOLD_START_DATE= STAGE.ON_HOLD_START_DATE
   ,TGT.ON_HOLD_END_DATE= STAGE.ON_HOLD_END_DATE
   ,TGT.ACQUIRED_FROM_COMPANY_KEY= STAGE.ACQUIRED_FROM_COMPANY_KEY
   ,TGT.ACQUIRED_FROM_COMPANY_ID= STAGE.ACQUIRED_FROM_COMPANY_ID
   ,TGT.ACQUIRED_FROM_COMPANY_FULL_NAME= STAGE.ACQUIRED_FROM_COMPANY_FULL_NAME
   ,TGT.ACQUISITION_DATE= STAGE.ACQUISITION_DATE
   ,TGT.ACQUISITION_FLAG= STAGE.ACQUISITION_FLAG
   ,TGT.ADMISSION_DATE= STAGE.ADMISSION_DATE
   ,TGT.ADMISSION_FLAG= STAGE.ADMISSION_FLAG
   ,TGT.CLIENT_CONVERTED_FLAG= STAGE.CLIENT_CONVERTED_FLAG
   ,TGT.PRIMARY_SUPERVISOR_KEY= STAGE.PRIMARY_SUPERVISOR_KEY
   ,TGT.PRIMARY_SUPERVISOR_CODE= STAGE.PRIMARY_SUPERVISOR_CODE
   ,TGT.PRIMARY_SUPERVISOR_NAME= STAGE.PRIMARY_SUPERVISOR_NAME
   ,TGT.SECONDARY_SUPERVISOR_KEY= STAGE.SECONDARY_SUPERVISOR_KEY
   ,TGT.SECONDARY_SUPERVISOR_CODE= STAGE.SECONDARY_SUPERVISOR_CODE
   ,TGT.SECONDARY_SUPERVISOR_NAME= STAGE.SECONDARY_SUPERVISOR_NAME
   ,TGT.PRIMARY_BRANCH_KEY= STAGE.PRIMARY_BRANCH_KEY
   ,TGT.PRIMARY_BRANCH_NAME= STAGE.PRIMARY_BRANCH_NAME
   ,TGT.PRIMARY_BRANCH_STATE= STAGE.PRIMARY_BRANCH_STATE
   ,TGT.GUARANTOR_NAME= STAGE.GUARANTOR_NAME
   ,TGT.NOTES= STAGE.NOTES
   ,TGT.EFFECTIVE_FROM_DATE= STAGE.EFFECTIVE_FROM_DATE
   ,TGT.EFFECTIVE_TO_DATE= STAGE.EFFECTIVE_TO_DATE
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.ETL_INFERRED_MEMBER_FLAG= STAGE.ETL_INFERRED_MEMBER_FLAG
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
   ,ON_HOLD_FLAG
   ,ON_HOLD_START_DATE
   ,ON_HOLD_END_DATE
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
    STAGE.CLIENT_KEY
   ,STAGE.CLIENT_NUMBER
   ,STAGE.SYSTEM_CODE
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.CLIENT_PID
   ,STAGE.CLIENT_MEDICARE_ID 
   ,STAGE.MEDICAID_ID
   ,STAGE.CLIENT_DOB
   ,STAGE.CLIENT_DATE_OF_DEATH
   ,STAGE.CLIENT_GENDER
   ,STAGE.CLIENT_ETHNICITY	 
   ,STAGE.HISPANIC_OR_LATINO						
   ,STAGE.CLIENT_GENDER_IDENTITY 
   ,STAGE.CLIENT_SEXUAL_ORIENTATION 
   ,STAGE.CLIENT_RACE
   ,STAGE.CLIENT_MARITAL_STATUS
   ,STAGE.CLIENT_SALUTATION
   ,STAGE.CLIENT_FIRST_NAME
   ,STAGE.CLIENT_MIDDLE_NAME
   ,STAGE.CLIENT_LAST_NAME
   ,STAGE.CLIENT_NAME
   ,STAGE.CLIENT_ADDRESS1
   ,STAGE.CLIENT_ADDRESS2
   ,STAGE.CLIENT_CITY
   ,STAGE.CLIENT_STATE_CODE
   ,STAGE.CLIENT_ZIP
   ,STAGE.CLIENT_CLN_ADDRESS1
   ,STAGE.CLIENT_CLN_ADDRESS2
   ,STAGE.CLIENT_CLN_CITY
   ,STAGE.CLIENT_CLN_STATE_CODE
   ,STAGE.CLIENT_CLN_ZIP
   ,STAGE.CLIENT_STD_ADDRESS1
   ,STAGE.CLIENT_STD_ADDRESS2
   ,STAGE.CLIENT_STD_CITY
   ,STAGE.CLIENT_STD_STATE_CODE
   ,STAGE.CLIENT_STD_ZIP
   ,STAGE.CLIENT_HOME_PHONE
   ,STAGE.CLIENT_CELL_PHONE
   ,STAGE.CLIENT_WORK_PHONE
   ,STAGE.CLIENT_FAX_NUMBER
   ,STAGE.CLIENT_PERSONAL_EMAIL
   ,STAGE.REFERRAL_DATE
   ,STAGE.DAYS_TO_SERVICE
   ,STAGE.CONTRACT_BEGIN_DATE
   ,STAGE.CONTRACT_END_DATE
   ,STAGE.FIRST_SERVICE_DATE
   ,STAGE.LAST_SERVICE_DATE
   ,STAGE.BEGIN_DATE
   ,STAGE.END_DATE
   ,STAGE.ACTIVE_CLIENT_FLAG
   ,STAGE.ON_HOLD_FLAG
   ,STAGE.ON_HOLD_START_DATE
   ,STAGE.ON_HOLD_END_DATE
   ,STAGE.ACQUIRED_FROM_COMPANY_KEY
   ,STAGE.ACQUIRED_FROM_COMPANY_ID
   ,STAGE.ACQUIRED_FROM_COMPANY_FULL_NAME
   ,STAGE.ACQUISITION_DATE
   ,STAGE.ACQUISITION_FLAG
   ,STAGE.ADMISSION_DATE
   ,STAGE.ADMISSION_FLAG
   ,STAGE.CLIENT_CONVERTED_FLAG
   ,STAGE.PRIMARY_SUPERVISOR_KEY
   ,STAGE.PRIMARY_SUPERVISOR_CODE
   ,STAGE.PRIMARY_SUPERVISOR_NAME
   ,STAGE.SECONDARY_SUPERVISOR_KEY
   ,STAGE.SECONDARY_SUPERVISOR_CODE
   ,STAGE.SECONDARY_SUPERVISOR_NAME
   ,STAGE.PRIMARY_BRANCH_KEY
   ,STAGE.PRIMARY_BRANCH_NAME
   ,STAGE.PRIMARY_BRANCH_STATE
   ,STAGE.GUARANTOR_NAME
   ,STAGE.NOTES
   ,STAGE.EFFECTIVE_FROM_DATE
   ,STAGE.EFFECTIVE_TO_DATE
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
   ,STAGE.ETL_INFERRED_MEMBER_FLAG
)

    `;
      sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
      rs = sqlStmt.execute();
      sqlCmd = 
            `SELECT "number of rows inserted", "number of rows updated"
              FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))`;
      sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
      rs = sqlStmt.execute();
          rs.next();
          result += ''{"Inserted": "'' + rs.getColumnValue(1) + ''", "Updated": "'' + rs.getColumnValue(2) +''", "ErrorCode":"NA", "ErrorState":"NA", "ErrorMessage":"NA", "ErrorStackTrace":"NA"}'';
    }
    catch (err) {
        result = ''{"Inserted": "0", "Updated": "0", "ErrorCode":"''+ err.code +''", "ErrorState":"''+ err.state +''", "ErrorMessage":"''+ err.message +''", "ErrorStackTrace":"''+ err.stackTraceTxt +''"}'';
    }
    return result;
    
 EOT
}

