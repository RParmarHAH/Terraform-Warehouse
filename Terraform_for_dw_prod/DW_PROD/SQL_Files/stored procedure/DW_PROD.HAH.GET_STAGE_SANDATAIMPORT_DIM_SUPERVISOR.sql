CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_SANDATAIMPORT_DIM_SUPERVISOR("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME:  DataFlexSyncData_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per supervisor according to DataFlexSyncData
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 02/13/20     Greg Marsh           Initial development
-- 03/18/20     Frank Noordover      Updated for Production rollout
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.SANDATAIMPORT_DIM_SUPERVISOR
with coord as (
    SELECT DISTINCT f.AGENCYID, nvl(Coordinators.STAFFID::string, ''Unknown-'' || nvl(f.agencyID,''S'')) AS SUPERVISOR_CODE,
            TO_CHAR(Coordinators.LASTNAME) || '', '' || TO_CHAR(Coordinators.FIRSTNAME) || '' '' || TO_CHAR(Coordinators.MIDDLEINITIAL) AS SUPERVISOR_NAME,
            CASE WHEN F.AGENCYID = 8485 THEN ''PA'' ELSE '''' END AS SUPERVISOR_STATE_CODE
    FROM DISC_PROD.SANDATAIMPORT.SANDATA_VISITS f
    LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS ClientAdmissions
        ON ClientAdmissions.agencyID = f.AgencyId
        AND ClientAdmissions.admissionID = f.AdmissionId
    LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_STAFFS Coordinators
        ON Coordinators.agencyID = ClientAdmissions.agencyID
        AND Coordinators.staffID = ClientAdmissions.CoordinatorID
    WHERE f.agencyID = 8485
	AND (f.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz
	OR ClientAdmissions.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz
	OR Coordinators.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz)
)
SELECT
	md5(nvl(f.agencyID,''S'') || ''-''  || f.SUPERVISOR_CODE || ''-''  || ''SANDATAIMPORT'') AS SUPERVISOR_KEY, --PK
    f.SUPERVISOR_CODE AS SUPERVISOR_CODE, --BK
	nvl(f.agencyID,''S'') AS SYSTEM_CODE, --BK
    4 AS SOURCE_SYSTEM_ID, --BK
	f.SUPERVISOR_NAME AS SUPERVISOR_NAME,
	f.SUPERVISOR_STATE_CODE AS SUPERVISOR_STATE_CODE,
	NULL SUPERVISOR_JOB_CODE,
	NULL SUPERVISOR_JOB_TITLE,
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
    
       :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,

    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM coord f;
          
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';