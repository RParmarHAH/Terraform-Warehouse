resource "snowflake_view" "DISC_DEVERO_VIEW_DEVERO_PATIENT_USER_ASSIGNMENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "VIEW_DEVERO_PATIENT_USER_ASSIGNMENT"
	statement = <<-SQL
	 (
WITH RESULT_DATA AS
(
SELECT DISTINCT
          P.PATIENT_CODE
        , XMLGET(UA.VALUE,'CAREGIVER_CODE'):"$"::STRING AS CAREGIVER_CODE
        , XMLGET(PARSE_XML(P.PATIENT_XML), 'DATE_MODIFIED'):"$"::STRING AS DATE_MODIFIED
         , P.ETL_TASK_KEY
        , P.ETL_INSERTED_TASK_KEY
        , P.ETL_INSERTED_DATE
        , P.ETL_INSERTED_BY
        , P.ETL_LAST_UPDATED_DATE
        , P.ETL_LAST_UPDATED_BY
        , P.ETL_DELETED_FLAG
        , ROW_NUMBER() OVER(PARTITION BY P.PATIENT_CODE,CAREGIVER_CODE ORDER BY DATE_MODIFIED DESC) AS LATEST_MODIFIED
FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_PATIENT P
, LATERAL FLATTEN (XMLGET(PARSE_XML(P.PATIENT_XML) ,'USER_ASSIGNMENTS'):"$" :: ARRAY) UA
--WHERE DATE(P.ETL_LAST_UPDATED_DATE) = COALESCE((
--SELECT MAX(DATE(ETL_LAST_UPDATED_DATE)) FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_PATIENT),DATE(GETDATE()))
)
SELECT PATIENT_CODE
        ,CAREGIVER_CODE
        ,DATE_MODIFIED
        , ETL_TASK_KEY
        , ETL_INSERTED_TASK_KEY
        , ETL_INSERTED_DATE
        , ETL_INSERTED_BY
        , ETL_LAST_UPDATED_DATE
        , ETL_LAST_UPDATED_BY
        , ETL_DELETED_FLAG
FROM RESULT_DATA
WHERE LATEST_MODIFIED = 1
);
SQL
	or_replace = true 
	is_secure = false 
}

