resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_FACT_REVENUE" {
	name ="GET_STAGE_COSTALSYNCDATA_FACT_REVENUE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
    --*****************************************************************************************************************************
-- NAME:  CostalSyncData_FACT_REVENUE
--
-- PURPOSE: Creates one row per REVENUE according to CoastalSnyc (combination of SHC_ALTRUS and SHC_SAVANNAH)
--
-- Note: PayRate is returning duplicate for now -- Still need working
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/06/20     Greg Marsh           Initial development
-- 03/02/20     Mohd Kamaludin       Completed using a new CV_BillingData
-- 03/06/20     Greg Marsh           Total refactor
-- 03/18/20     Frank Noordover      Updated for Production rollout
-- 05/20/20		Mir Ali				 Updated to use raw tables for billed data
-- 05/21/20		Mir Ali				 Added "hour_unit_mapping" from Chen''s logic (adjust for units vs hours)
-- 08/06/20		Mir Ali				 Fixed rounding error for Invoice Hours and Invoice Rate
--									 Fixed branch location to come from billing (instead of employee)
-- 08/10/20		Mir Ali				 Added employee info and ratio to calculate hours/amount per employee (currently only one employee selected)
-- 08/11/20		Mir Ali				 Changed some existing logic (changed join from Billed_Data to Paid_Data to Left Join instead of Full Join)
-- 02/18/22		Prateek Bhatt		 Replace the dim_client & emp with dedupe client table
-- 25/11/23     Pradeep Thippani     Added bill_unit_type column for RCM(Requested By Natalie)
-- 31/01/24     POONIT MISTRY (OLLION) refactor and consolidate code for simplicity
--*****************************************************************************************************************************
--
        INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_FACT_REVENUE
        WITH HOUR_UNIT_MAPPING AS (SELECT DB,
                                          PLAN_CODE,
                                          MIN(TIME_TRANSLATION_CODE) AS TIME_TRANSLATION_CODE,
                                          CASE LEFT(MIN(TIME_TRANSLATION_CODE), 2)
                                              WHEN ''15'' THEN 4
                                              WHEN ''30'' THEN 2
                                              ELSE 1 END                MATH_FACTOR
                                   FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_PLANTIMETRANSLATION
                                   WHERE TRIM(TIME_TRANSLATION_CODE) LIKE ''%MIN''
                                   GROUP BY DB, PLAN_CODE)
                ,
             EMPLOYEES AS
                 (SELECT *,
                         TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
                         TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
                  FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST)
                ,
             CLIENT_DATA AS
                 (SELECT *
                  FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CLIENT_MASTER_LIST)
        SELECT --TOP 100
               MD5(TRIM(TRANSACTIONS.DB) || ''-'' || TRIM(TRANSACTIONS.BILL_NUMBER) || ''-'' ||
                   TRIM(CHARGES.SEQUENCE_NUMBER) ||
                   ''-'' ||
                   TRIM(TRANSACTIONS.PROCCODE) || ''-'' || TRIM(TRANSACTIONS.PLAN_CODE) || ''-'' ||
                   ''COSTALSYNCDATA'')                                                      AS REVENUE_KEY,
               CHARGES.SERVICE_DATE                                                         AS REPORT_DATE,
               COALESCE(BRANCH.BRANCH_KEY,
                        MD5( TRIM(TRANSACTIONS.DB) || ''-'' || TRIM(TRANSACTIONS.LOCATION_CODE) || ''-'' ||
                            ''COSTALSYNCDATA''))                                            AS BRANCH_KEY,
               NVL(MD5(TRIM(EMPLOYEE.DB) || ''-'' || UPPER((TRIM(regexp_replace(EMPLOYEE.MASTER_ID, EMPLOYEE.DB)))) ||
                       ''-'' || ''COSTALSYNCDATA''),
                   md5(NVL(TRANSACTIONS.DB, '''') || ''-'' || upper(coalesce(SCHEDULES.NURSE_ID, ''-1'')) ||
                       ''-'' ||
                       ''COSTALSYNCDATA''))                                                 AS EMPLOYEE_KEY,
               coalesce(md5(TRIM(CLIENT.DB) || ''-'' || UPPER(TRIM(regexp_replace(CLIENT.MASTER_ID, CLIENT.DB))) ||
                            ''-'' ||
                            ''COSTALSYNCDATA''),
                        md5(TRANSACTIONS.DB || ''-'' ||
                            NVL(TRY_CAST(TRANSACTIONS.PATIENT_NUMBER AS INTEGER), -1)::STRING ||
                            ''-'' ||
                            ''COSTALSYNCDATA''))                                            AS CLIENT_KEY,
               MD5(TRANSACTIONS.DB || ''-'' || TRANSACTIONS.PLAN_CODE || ''-'' ||
                   ''COSTALSYNCDATA'')                                                      AS CONTRACT_KEY,
               MD5(TRANSACTIONS.DB || ''-'' || TRANSACTIONS.BILL_NUMBER || ''-'' ||
                   ''COSTALSYNCDATA'')                                                      AS INVOICE_KEY,
               CASE TRANSACTIONS.DB
                   WHEN ''SHC_ALTRUS'' THEN 1
                   WHEN ''SHC_SAVANNAH'' THEN 2
                   ELSE -1 END                                                              AS SOURCE_SYSTEM_ID,
               MD5(TRANSACTIONS.DB || ''-'' || TO_VARCHAR(TRANSACTIONS.DEPARTMENT__CODE) || ''-'' ||
                   ''COSTALSYNCDATA'')                                                      AS SUPERVISOR_KEY,
               DATE(TRANSACTIONS.BILL_DATE)                                                 AS REVENUE_DATE,
               DATE(CHARGES.LAST_PAYMENT_DATE)                                              AS PAYMENT_DATE,
               COALESCE(BRANCH.OFFICE_NAME, ''Unknown'')                                    AS BRANCH_NAME,
               TRIM(COALESCE(UPPER((TRIM(regexp_replace(EMPLOYEE.MASTER_ID, EMPLOYEE.DB)))),
                             SCHEDULES.NURSE_ID))                                           AS EMPLOYEE_ID,
               COALESCE(UPPER(TRIM(regexp_replace(CLIENT.MASTER_ID, CLIENT.DB))),
                        TRANSACTIONS.PATIENT_NUMBER)                                        AS CLIENT_NUMBER,
               TRANSACTIONS.PLAN_CODE                                                       AS CONTRACT_CODE,
               TRANSACTIONS.BILL_NUMBER                                                     AS INVOICE_NUMBER,
               ''Regular''                                                                  AS INVOICE_TYPE,
               ''HOURLY''                                                                   AS BILL_UNIT_TYPE,
               1                                                                            AS NUMBER_OF_CLIENTS,
               TRANSACTIONS.DB                                                              AS SYSTEM_CODE,
               TRANSACTIONS.PROCCODE                                                        AS BILL_CODE,
               cast(EMPLOYEE.NURSE_ID as varchar)                                           AS SUPERVISOR_CODE,
               CAST(CHARGES.NUMBER_OF_UNIT / NVL(MAPPING.MATH_FACTOR, 1) AS DECIMAL(38, 3)) AS INVOICE_HOURS,
               CAST(CHARGES.UNIT_AMOUNT * NVL(MAPPING.MATH_FACTOR, 1) AS DECIMAL(38, 3))    AS INVOICE_RATE,
               CHARGES.EXTENDED_AMOUNT                                                      AS AMOUNT_BILLED,
               CHARGES.EXTENDED_AMOUNT - CHARGES.BALANCE10_2                                AS AMOUNT_COLLECTED,
               CHARGES.BALANCE10_2                                                          AS AMOUNT_OUTSTANDING,
               :STR_ETL_TASK_KEY                                                            AS ETL_TASK_KEY
                ,
               :STR_ETL_TASK_KEY                                                            AS ETL_INSERTED_TASK_KEY
                ,
               convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                  as ETL_INSERTED_DATE
                ,
               CURRENT_USER                                                                 as ETL_INSERTED_BY
                ,
               convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                  as ETL_UPDATED_DATE
                ,
               CURRENT_USER                                                                 as ETL_LAST_UPDATED_BY
                ,
               0                                                                            as ETL_DELETED_FLAG

        FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_BILLINGTRANSACTIONS AS TRANSACTIONS
                 JOIN DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_CHARGES AS CHARGES
                      ON CHARGES.DB = TRANSACTIONS.DB AND CHARGES.PATIENT_NUMBER = TRANSACTIONS.PATIENT_NUMBER AND
                         CHARGES.BILL_NUMBER = TRANSACTIONS.BILL_NUMBER
                 LEFT JOIN DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_SCHEDULES AS SCHEDULES
                           ON SCHEDULES.DB = TRANSACTIONS.DB AND
                              SCHEDULES.SCHEDULE_NUMBER = TRANSACTIONS.SCHEDULE_NUMBER
                               AND TRIM(SCHEDULES.CONFIRMED_DURATION) NOT IN ('''', ''0000'')
                 LEFT JOIN HAH.DIM_BRANCH AS BRANCH
                           ON BRANCH.SYSTEM_CODE = TRANSACTIONS.DB AND BRANCH.OFFICE_CODE = TRANSACTIONS.LOCATION_CODE
                 LEFT JOIN CLIENT_DATA AS CLIENT
                           ON TRIM(CLIENT.DB) = TRIM(TRANSACTIONS.DB) AND
                              TRIM(CLIENT.PATIENT_NUMBER) = TRIM(TRANSACTIONS.PATIENT_NUMBER)
                 LEFT JOIN EMPLOYEES AS EMPLOYEE
                           ON TRIM(EMPLOYEE.DB) = TRIM(TRANSACTIONS.DB)
                               AND TRIM(UPPER((TRIM(regexp_replace(EMPLOYEE.MASTER_ID, EMPLOYEE.DB))))) =
                                   TRIM(UPPER(SCHEDULES.NURSE_id))
                 LEFT JOIN HOUR_UNIT_MAPPING AS MAPPING
                           ON MAPPING.DB = TRANSACTIONS.DB AND MAPPING.PLAN_CODE = TRANSACTIONS.PLAN_CODE;
        RETURN ''SUCCESS'';
    END ;

 EOT
}

