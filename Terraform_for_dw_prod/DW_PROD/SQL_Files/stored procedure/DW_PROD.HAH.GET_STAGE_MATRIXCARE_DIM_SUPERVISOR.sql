CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_MATRIXCARE_DIM_SUPERVISOR("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
                BEGIN
    --******************************************************************************************************************************************
-- NAME:  MATRIXCARE_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per employee_id/database according to MatrixCare
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -------------------------------------------------------------------------------------------------------        
-- 04/28/21    Alex Marianyi		 Initial development
-- 05/24/21    Shraddha Sejpal		 Added supervisor from Admissions
-- 12/01/21    Paras Bhavnani		 Changed the INSERT OVERWRITE logic. Now, the supervisor name is inserted into STAGE.MATRIXCARE_DIM_SUPERVISOR so no need of merge query
-- 12/25/23    Deepen Gajjar         Added CAR_STATEORPROVINCE source field for Supervisor state code 
--******************************************************************************************************************************************
--
-- Build DIM_SUPERVISOR for MatrixCare

INSERT OVERWRITE INTO STAGE.MATRIXCARE_DIM_SUPERVISOR
(WITH SUPERVISORS AS
(
	SELECT DISTINCT COALESCE(ADM.ADM_SUPERVISORID, ADM.ADM_COORDINATORID, ADM.ADM_INTERNALCASEMGRID) AS SUPERVISOR_CODE,
	MAX(ADM.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_ADMISSIONS ADM
	WHERE COALESCE(ADM.ADM_SUPERVISORID, ADM.ADM_COORDINATORID, ADM.ADM_INTERNALCASEMGRID) IS NOT NULL
	GROUP BY 1
  UNION
   SELECT DISTINCT NVL( mccg.CAR_SUPERVISOR, mccg.CAR_MANAGER) AS SUPERVISOR_CODE,
    MAX( mccg.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVER mccg
	WHERE NVL( mccg.CAR_SUPERVISOR, mccg.CAR_MANAGER) IS NOT NULL
  GROUP BY 1
  ),
TITLE AS (
  SELECT C.CAR_ID, CFLI.CARDD_TEXT TITLE FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERVALUES CV
JOIN DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERFIELDS CF ON CV.CARV_FIELDID = CF.CARF_ID
JOIN DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVER C ON C.CAR_ID = CV.CARV_RECORDID 
JOIN DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERFIELDLISTITEMS CFLI ON CFLI.CARDD_FIELDID  = CF.CARF_ID AND TRIM(UPPER(CFLI.CARDD_VALUE::VARCHAR)) = TRIM(UPPER(CV.CARV_VALUE::VARCHAR))
WHERE CF.CARF_ID = 32
  )
SELECT DISTINCT
	md5( ''MATRIXCARE'' || ''-''  || s.SUPERVISOR_CODE || ''-''  || ''MATRIXCARE'') AS SUPERVISOR_KEY,
	s.SUPERVISOR_CODE,
	''MATRIXCARE'' AS SYSTEM_CODE,
	7 AS SOURCE_SYSTEM_ID,
	UPPER( TRIM(CAR.CAR_LASTNAME)) || '', '' || UPPER( TRIM(CAR.CAR_FIRSTNAME)) AS SUPERVISOR_NAME,
	NVL(CAR.CAR_STATEORPROVINCE,''IN'') AS SUPERVISOR_STATE_CODE,
	NULL SUPERVISOR_JOB_CODE,
	TITLE SUPERVISOR_JOB_TITLE,
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
     
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
     FROM SUPERVISORS AS s
 LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_ADMISSIONS ADM 
 ON S.SUPERVISOR_CODE= COALESCE(ADM.ADM_SUPERVISORID, ADM.ADM_COORDINATORID, ADM.ADM_INTERNALCASEMGRID)
 LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVER CAR ON S.SUPERVISOR_CODE=CAR.CAR_ID
 LEFT JOIN TITLE T ON T.CAR_ID = CAR.CAR_ID 
 WHERE s.ETL_LAST_UPDATED_DATE >=  
:STR_CDC_START::timestamp_ntz
 OR ADM.ETL_LAST_UPDATED_DATE>=''1900-01-01''
 OR CAR.ETL_LAST_UPDATED_DATE>=''1900-01-01'');
    RETURN ''SUCCESS'';
    END;
    ';