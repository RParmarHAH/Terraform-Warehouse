CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_MASTER_DIM_CLIENT_OH_MERGED_DEDUPE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

INSERT INTO INTEGRATION.DIM_CLIENT_MERGED_DEDUPE
WITH LWD_NEW AS (
    SELECT ID,
    ROW_NUMBER() OVER (PARTITION BY CLUSTER_ID ORDER BY LAST_SERVICE_DATE DESC NULLS LAST, FIRST_SERVICE_DATE DESC NULLS LAST, BEGIN_DATE DESC NULLS LAST) AS SRC_PRI,
    CLUSTER_ID
    FROM DW_PROD.INTEGRATION.DIM_CLIENT_OH_RL_OUTPUT
)
, NEW AS (
    SELECT * FROM (
        SELECT 
            -- CASE WHEN SYSTEM_CODE=''PREFERRED'' THEN 1 ELSE 2 END as SRC_PRI,
            row_number() over(partition by OHO.CLUSTER_ID order by SRC_PRI) min_record_id,
            OHO.ID,
            CLIENT_NUMBER,SYSTEM_CODE,SOURCE_SYSTEM_ID,CLIENT_PID,CLIENT_DOB,CLIENT_DATE_OF_DEATH,CLIENT_GENDER,CLIENT_ETHNICITY,CLIENT_MARITAL_STATUS,CLIENT_SALUTATION,CLIENT_FIRST_NAME,CLIENT_MIDDLE_NAME,CLIENT_LAST_NAME,CLIENT_NAME,CLIENT_ADDRESS1,CLIENT_ADDRESS2,CLIENT_CITY,CLIENT_STATE_CODE,CLIENT_ZIP,CLIENT_CLN_ADDRESS1,CLIENT_CLN_ADDRESS2,CLIENT_CLN_CITY,CLIENT_CLN_STATE_CODE,CLIENT_CLN_ZIP,CLIENT_STD_ADDRESS1,CLIENT_STD_ADDRESS2,CLIENT_STD_CITY,CLIENT_STD_STATE_CODE,CLIENT_STD_ZIP,CLIENT_HOME_PHONE,CLIENT_CELL_PHONE,CLIENT_WORK_PHONE,CLIENT_FAX_NUMBER,CLIENT_PERSONAL_EMAIL,
            MIN(REFERRAL_DATE::date) OVER(PARTITION BY OHO.CLUSTER_ID) AS DERIVED_REFERRAL_DATE,
            FIRST_SERVICE_DATE::DATE - MIN(REFERRAL_DATE::date) OVER(PARTITION BY OHO.CLUSTER_ID) AS DERIVED_DAYS_TO_SERVICE,
            CONTRACT_BEGIN_DATE,
            CONTRACT_END_DATE,
            MIN(FIRST_SERVICE_DATE::date) OVER(PARTITION BY OHO.CLUSTER_ID) AS DERIVED_FIRST_SERVICE_DATE,
            MAX(LAST_SERVICE_DATE::date) OVER(PARTITION BY OHO.CLUSTER_ID) AS DERIVED_LAST_SERVICE_DATE,
            MIN(BEGIN_DATE::date) OVER(PARTITION BY OHO.CLUSTER_ID) AS DERIVED_BEGIN_DATE,DAYS_TO_SERVICE,
            REFERRAL_DATE::date AS REFERRAL_DATE ,FIRST_SERVICE_DATE::date AS FIRST_SERVICE_DATE,LAST_SERVICE_DATE::DATE AS LAST_SERVICE_DATE,BEGIN_DATE::date AS BEGIN_DATE,
            END_DATE,ACTIVE_CLIENT_FLAG,ON_HOLD_FLAG,ON_HOLD_START_DATE,ON_HOLD_END_DATE,LINKED_ID,ACQUIRED_FROM_COMPANY_KEY,ACQUIRED_FROM_COMPANY_ID,ACQUIRED_FROM_COMPANY_FULL_NAME,ACQUISITION_DATE,ACQUISITION_FLAG,ADMISSION_DATE,ADMISSION_FLAG,CLIENT_CONVERTED_FLAG,PRIMARY_SUPERVISOR_KEY,PRIMARY_SUPERVISOR_CODE,PRIMARY_SUPERVISOR_NAME,SECONDARY_SUPERVISOR_KEY,SECONDARY_SUPERVISOR_CODE,SECONDARY_SUPERVISOR_NAME,PRIMARY_BRANCH_KEY,PRIMARY_BRANCH_NAME,PRIMARY_BRANCH_STATE,GUARANTOR_NAME,NOTES,AGENCY,MEDICAID_ID,EFFECTIVE_FROM_DATE,EFFECTIVE_TO_DATE,ETL_TASK_KEY,ETL_INSERTED_TASK_KEY,ETL_INSERTED_DATE,ETL_INSERTED_BY,ETL_LAST_UPDATED_DATE,ETL_LAST_UPDATED_BY,
            ETL_DELETED_FLAG,ETL_INFERRED_MEMBER_FLAG, OHO.CLUSTER_ID
        FROM DW_PROD.INTEGRATION.DIM_CLIENT_OH_RL_OUTPUT OHO
        INNER JOIN LWD_NEW ON LWD_NEW.ID = OHO.ID
        WHERE OHO.CLUSTER_ID IS NOT NULL
    )
    WHERE min_record_id = 1
)
, LWD_OLD AS (
    SELECT ID,
    ROW_NUMBER() OVER (PARTITION BY CLUSTER_ID ORDER BY LAST_SERVICE_DATE ASC NULLS LAST, FIRST_SERVICE_DATE ASC NULLS LAST, BEGIN_DATE ASC NULLS LAST) AS SRC_PRI,
    CLUSTER_ID
    FROM DW_PROD.INTEGRATION.DIM_CLIENT_OH_RL_OUTPUT
) 
, OLD AS (
    SELECT * FROM (
        SELECT 
            row_number() over(partition by OHO.CLUSTER_ID order by SRC_PRI) min_record_id,
            OHO.ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,CLIENT_NUMBER,CLIENT_PID,OHO.CLUSTER_ID,AGENCY
        FROM DW_PROD.INTEGRATION.DIM_CLIENT_OH_RL_OUTPUT OHO
        INNER JOIN LWD_OLD ON LWD_OLD.ID = OHO.ID
        WHERE OHO.CLUSTER_ID IS NOT NULL
        )-- WHERE min_record_id = 1
    ORDER BY CLUSTER_ID::NUMBER
) --SELECT * FROM OLD;
SELECT
    distinct O.ID AS ORIGINAL_CLIENT_KEY,O.SOURCE_SYSTEM_ID ORIGINAL_SOURCE_SYSTEM_ID,O.SYSTEM_CODE ORIGINAL_SYSTEM_CODE,
    O.CLIENT_NUMBER ORIGINAL_CLIENT_NUMBER,O.AGENCY ORIGINAL_AGENCY,
    N.ID as CLIENT_KEY,
    N.CLIENT_NUMBER,N.SYSTEM_CODE,N.SOURCE_SYSTEM_ID,N.CLIENT_PID,N.CLIENT_DOB,N.CLIENT_DATE_OF_DEATH,N.CLIENT_GENDER,N.CLIENT_ETHNICITY,N.CLIENT_MARITAL_STATUS,N.CLIENT_SALUTATION,N.CLIENT_FIRST_NAME,N.CLIENT_MIDDLE_NAME,N.CLIENT_LAST_NAME,N.CLIENT_NAME,N.CLIENT_ADDRESS1,N.CLIENT_ADDRESS2,N.CLIENT_CITY,N.CLIENT_STATE_CODE,N.CLIENT_ZIP,N.CLIENT_CLN_ADDRESS1,N.CLIENT_CLN_ADDRESS2,N.CLIENT_CLN_CITY,N.CLIENT_CLN_STATE_CODE,N.CLIENT_CLN_ZIP,
    N.CLIENT_STD_ADDRESS1,N.CLIENT_STD_ADDRESS2,N.CLIENT_STD_CITY,N.CLIENT_STD_STATE_CODE,N.CLIENT_STD_ZIP,N.CLIENT_HOME_PHONE,N.CLIENT_CELL_PHONE,N.CLIENT_WORK_PHONE,N.CLIENT_FAX_NUMBER,N.CLIENT_PERSONAL_EMAIL,N.REFERRAL_DATE,N.DAYS_TO_SERVICE,N.CONTRACT_BEGIN_DATE,N.CONTRACT_END_DATE,N.FIRST_SERVICE_DATE,N.LAST_SERVICE_DATE,N.BEGIN_DATE,N.END_DATE,N.ACTIVE_CLIENT_FLAG,N.ON_HOLD_FLAG,N.ON_HOLD_START_DATE,
    N.ON_HOLD_END_DATE,N.LINKED_ID,N.ACQUIRED_FROM_COMPANY_KEY,N.ACQUIRED_FROM_COMPANY_ID,
    N.ACQUIRED_FROM_COMPANY_FULL_NAME,N.ACQUISITION_DATE,N.ACQUISITION_FLAG,N.ADMISSION_DATE,N.ADMISSION_FLAG,N.CLIENT_CONVERTED_FLAG,N.PRIMARY_SUPERVISOR_KEY,N.PRIMARY_SUPERVISOR_CODE,N.PRIMARY_SUPERVISOR_NAME,N.SECONDARY_SUPERVISOR_KEY,N.SECONDARY_SUPERVISOR_CODE,N.SECONDARY_SUPERVISOR_NAME,N.PRIMARY_BRANCH_KEY,N.PRIMARY_BRANCH_NAME,N.PRIMARY_BRANCH_STATE,N.GUARANTOR_NAME,N.NOTES,N.AGENCY,
    N.MEDICAID_ID,N.EFFECTIVE_FROM_DATE,N.EFFECTIVE_TO_DATE,N.ETL_TASK_KEY,N.ETL_INSERTED_TASK_KEY,N.ETL_INSERTED_DATE,N.ETL_INSERTED_BY,N.ETL_LAST_UPDATED_DATE,N.ETL_LAST_UPDATED_BY,N.ETL_DELETED_FLAG,N.ETL_INFERRED_MEMBER_FLAG,
    N.DERIVED_REFERRAL_DATE AS DERIVED_REFERRAL_DATE,
    N.CONTRACT_BEGIN_DATE AS DERIVED_CONTRACT_BEGIN_DATE,
    N.CONTRACT_END_DATE AS DERIVED_CONTRACT_END_DATE,
    N.DERIVED_FIRST_SERVICE_DATE AS DERIVED_FIRST_SERVICE_DATE,
    N.DERIVED_LAST_SERVICE_DATE AS DERIVED_LAST_SERVICE_DATE,
    N.DERIVED_BEGIN_DATE AS DERIVED_BEGIN_DATE,
    N.END_DATE AS DERIVED_END_DATE,
    N.DERIVED_DAYS_TO_SERVICE AS DERIVED_DAYS_TO_SERVICE
FROM DW_PROD.INTEGRATION.DIM_CLIENT_OH_RL_OUTPUT R
LEFT JOIN OLD O ON O.CLUSTER_ID = R.CLUSTER_ID
LEFT JOIN NEW N ON N.CLUSTER_ID =R.CLUSTER_ID
WHERE R.CLUSTER_ID IS NOT NULL
UNION
SELECT
    U.ID AS ORIGINAL_CLIENT_KEY,U.SOURCE_SYSTEM_ID ORIGINAL_SOURCE_SYSTEM_ID,U.SYSTEM_CODE ORIGINAL_SYSTEM_CODE,
    U.CLIENT_NUMBER ORIGINAL_CLIENT_NUMBER,U.AGENCY ORIGINAL_AGENCY,
    U.ID as CLIENT_KEY,
    U.CLIENT_NUMBER,U.SYSTEM_CODE,U.SOURCE_SYSTEM_ID,U.CLIENT_PID,U.CLIENT_DOB,U.CLIENT_DATE_OF_DEATH,U.CLIENT_GENDER,U.CLIENT_ETHNICITY,U.CLIENT_MARITAL_STATUS,U.CLIENT_SALUTATION,U.CLIENT_FIRST_NAME,U.CLIENT_MIDDLE_NAME,U.CLIENT_LAST_NAME,U.CLIENT_NAME,U.CLIENT_ADDRESS1,U.CLIENT_ADDRESS2,U.CLIENT_CITY,U.CLIENT_STATE_CODE,U.CLIENT_ZIP,U.CLIENT_CLN_ADDRESS1,U.CLIENT_CLN_ADDRESS2,U.CLIENT_CLN_CITY,U.CLIENT_CLN_STATE_CODE,U.CLIENT_CLN_ZIP,
    U.CLIENT_STD_ADDRESS1,U.CLIENT_STD_ADDRESS2,U.CLIENT_STD_CITY,U.CLIENT_STD_STATE_CODE,U.CLIENT_STD_ZIP,U.CLIENT_HOME_PHONE,U.CLIENT_CELL_PHONE,U.CLIENT_WORK_PHONE,U.CLIENT_FAX_NUMBER,U.CLIENT_PERSONAL_EMAIL,U.REFERRAL_DATE,U.DAYS_TO_SERVICE,U.CONTRACT_BEGIN_DATE,U.CONTRACT_END_DATE,U.FIRST_SERVICE_DATE,U.LAST_SERVICE_DATE,U.BEGIN_DATE,U.END_DATE,U.ACTIVE_CLIENT_FLAG,U.ON_HOLD_FLAG,U.ON_HOLD_START_DATE,U.ON_HOLD_END_DATE,U.LINKED_ID,U.ACQUIRED_FROM_COMPANY_KEY,U.ACQUIRED_FROM_COMPANY_ID,
    U.ACQUIRED_FROM_COMPANY_FULL_NAME,U.ACQUISITION_DATE,U.ACQUISITION_FLAG,U.ADMISSION_DATE,U.ADMISSION_FLAG,U.CLIENT_CONVERTED_FLAG,U.PRIMARY_SUPERVISOR_KEY,U.PRIMARY_SUPERVISOR_CODE,U.PRIMARY_SUPERVISOR_NAME,U.SECONDARY_SUPERVISOR_KEY,U.SECONDARY_SUPERVISOR_CODE,U.SECONDARY_SUPERVISOR_NAME,U.PRIMARY_BRANCH_KEY,U.PRIMARY_BRANCH_NAME,U.PRIMARY_BRANCH_STATE,U.GUARANTOR_NAME,U.NOTES,U.AGENCY,
    U.MEDICAID_ID,U.EFFECTIVE_FROM_DATE,U.EFFECTIVE_TO_DATE,U.ETL_TASK_KEY,U.ETL_INSERTED_TASK_KEY,U.ETL_INSERTED_DATE,U.ETL_INSERTED_BY,U.ETL_LAST_UPDATED_DATE,U.ETL_LAST_UPDATED_BY,U.ETL_DELETED_FLAG,U.ETL_INFERRED_MEMBER_FLAG,
    U.REFERRAL_DATE AS DERIVED_REFERRAL_DATE,
    U.CONTRACT_BEGIN_DATE AS DERIVED_CONTRACT_BEGIN_DATE,
    U.CONTRACT_END_DATE AS DERIVED_CONTRACT_END_DATE,
    U.FIRST_SERVICE_DATE AS DERIVED_FIRST_SERVICE_DATE,
    U.LAST_SERVICE_DATE AS DERIVED_LAST_SERVICE_DATE,
    U.BEGIN_DATE AS DERIVED_BEGIN_DATE,
    U.END_DATE AS DERIVED_END_DATE,
    U.DAYS_TO_SERVICE AS DERIVED_DAYS_TO_SERVICE
FROM DW_PROD.INTEGRATION.DIM_CLIENT_OH_RL_OUTPUT U
WHERE CLUSTER_ID IS NULL;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';