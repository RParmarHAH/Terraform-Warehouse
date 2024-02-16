resource "snowflake_procedure" "DW_HAH_GET_STAGE_AXXESS_DIM_INVOICE_VISIT_LINKAGE" {
	name ="GET_STAGE_AXXESS_DIM_INVOICE_VISIT_LINKAGE"
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
-- NAME:  AXXESS_DIM_INVOICE_VISIT_LINKAGE
--
-- DEVELOPMENT LOG:A
-- DATE         AUTHOR                  NOTES:
-- --------     -------------------     -----------------------------------------------------------------------------------------------
-- 06/12/23     Pinkal Panchal          Initial Development
-- 06/12/23     POONIT MSITRY (OLLION)  Added VISIT_ID TO REVENUE_KEY
-- 15/01/24     POONIT MISTRY (OLLION)  For homehealth changed to pull from only visit_financials
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.AXXESS_DIM_INVOICE_VISIT_LINKAGE
--HH
SELECT
DISTINCT MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(ARS.ID)), ''UNKNOWN'') || ''-'' ||
             IFNULL(UPPER(TRIM(PV.VISIT_ID)), ''UNKNOWN'') || ''-'' || ''AXXESS'') AS REVENUE_KEY
        ,MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(PV.VISIT_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS VISIT_KEY
,CAST(NVL(PV.VISIT_ID,''UNKNOWN'' ) AS VARCHAR) AS VISIT_ID
,TRY_TO_DATE(COALESCE(PV.VISIT_DATE,''1999-12-31''), ''YYYY-MM-DD'') AS SERVICE_DATE
,''AXXESS'' AS SYSTEM_CODE
,14 AS SOURCE_SYSTEM_ID
---- ETL FIELDS ----
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
,Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
,CURRENT_USER AS ETL_INSERTED_BY
,Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
,CURRENT_USER AS ETL_LAST_UPDATED_BY
,0 AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_ARS ARS
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HH_VISITS_UPPER PV
ON ARS.ID = PV.FACT_AR_ID
WHERE
ARS.ID IS NOT NULL
--  HC
UNION
        SELECT DISTINCT MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(VF.CLAIM_ID)), ''UNKNOWN'') || ''-'' ||
                            IFNULL(UPPER(TRIM(VF.SCHEDULED_TASK_ID)), ''UNKNOWN'') || ''-'' ||
                            ''AXXESS'')                                             AS REVENUE_KEY
                      , MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(VF.SCHEDULED_TASK_ID)), ''UNKNOWN'') || ''-'' ||
                            ''AXXESS'')                                             AS VISIT_KEY
                      , CAST(NVL(VF.SCHEDULED_TASK_ID, ''UNKNOWN'') AS VARCHAR)     AS VISIT_ID
                      , CAST(COALESCE(VF.VISIT_START, ''1999-12-31'') AS DATE)      AS SERVICE_DATE
                      , ''AXXESS''                                                  AS SYSTEM_CODE
                      , 14                                                          AS SOURCE_SYSTEM_ID
                      , :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY
                      , :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY
                      , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
                      , CURRENT_USER                                                as ETL_INSERTED_BY
                      , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
                      , CURRENT_USER                                                as ETL_LAST_UPDATED_BY
                      , 0                                                           as ETL_DELETED_FLAG
        FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_VISITFINANCIALS VF;

        RETURN ''SUCCESS'';
    END ;

 EOT
}

