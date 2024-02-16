resource "snowflake_view" "DISC_DEVERO_VIEW_DEVERO_PATIENT_CERTIFICATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "VIEW_DEVERO_PATIENT_CERTIFICATION"
	statement = <<-SQL
	 (
WITH RESULT_DATA AS
(
SELECT DISTINCT
          P.PATIENT_CODE
        , XMLGET(CERT.VALUE,'CERTIFICATION_NUMBER'):"$"::STRING AS CERTIFICATION_NUMBER
        , XMLGET(CERT.VALUE,'CERTIFICATION_PERIOD_ID'):"$"::STRING AS CERTIFICATION_PERIOD_ID
        , XMLGET(CERT.VALUE,'DATE_MODIFIED'):"$"::STRING AS CERTIFICATION_DATE_MODIFIED
        , XMLGET(CERT.VALUE,'START_DATE'):"$"::STRING AS START_DATE
        , XMLGET(CERT.VALUE,'END_DATE'):"$"::STRING AS END_DATE
        , XMLGET(CERT.VALUE,'CHART_NUMBER'):"$"::STRING AS CERTIFICATION_CHART_NUMBER
        , XMLGET(CERT.VALUE,'REMOVED'):"$"::STRING AS CERTIFICATION_REMOVED
         , P.ETL_TASK_KEY
        , P.ETL_INSERTED_TASK_KEY
        , P.ETL_INSERTED_DATE
        , P.ETL_INSERTED_BY
        , P.ETL_LAST_UPDATED_DATE
        , P.ETL_LAST_UPDATED_BY
        , P.ETL_DELETED_FLAG
        , ROW_NUMBER() OVER(PARTITION BY P.PATIENT_CODE,CERTIFICATION_NUMBER,CERTIFICATION_PERIOD_ID ORDER BY CERTIFICATION_DATE_MODIFIED DESC) AS LATEST_MODIFIED
FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_PATIENT P
, LATERAL FLATTEN (XMLGET(PARSE_XML(P.PATIENT_XML) ,'CERTIFICATION_PERIODS'):"$" :: ARRAY) CERT
--WHERE DATE(P.ETL_LAST_UPDATED_DATE) = COALESCE((
--SELECT MAX(DATE(ETL_LAST_UPDATED_DATE)) FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_PATIENT),DATE(GETDATE()))
)
SELECT
 PATIENT_CODE
        , CERTIFICATION_NUMBER
        , CERTIFICATION_PERIOD_ID
        , CERTIFICATION_DATE_MODIFIED
        , START_DATE
        , END_DATE
        , CERTIFICATION_CHART_NUMBER
        , CERTIFICATION_REMOVED
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

