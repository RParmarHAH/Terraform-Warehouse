resource "snowflake_view" "DISC_DEVERO_VIEW_DEVERO_FORM_SIGNATURES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "VIEW_DEVERO_FORM_SIGNATURES"
	statement = <<-SQL
	 (
WITH RESULT_DATA AS
(
SELECT DISTINCT
		  F.FORM_ID
		, XMLGET(FORM_SIGNATURES.VALUE, 'SIGNATURE_DATE'):"$"::STRING AS SIGNATURE_DATE
	    , XMLGET(FORM_SIGNATURES.VALUE, 'CAREGIVER_CODE'):"$"::STRING AS CAREGIVER_CODE
	 	, F.ETL_TASK_KEY
		, F.ETL_INSERTED_TASK_KEY
		, F.ETL_INSERTED_DATE
		, F.ETL_INSERTED_BY
		, F.ETL_LAST_UPDATED_DATE
		, F.ETL_LAST_UPDATED_BY
		, F.ETL_DELETED_FLAG
		, ROW_NUMBER() OVER(PARTITION BY F.FORM_ID ORDER BY DATE_MODIFIED DESC) AS LATEST_MODIFIED
FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_FORM F(NODE)
,LATERAL FLATTEN (XMLGET(PARSE_XML(F.FORM_XML) ,'FORM_SIGNATURES'):"$") FORM_SIGNATURES
--WHERE DATE(F.ETL_LAST_UPDATED_DATE) = COALESCE((
--SELECT MAX(DATE(ETL_LAST_UPDATED_DATE)) FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_FORM),DATE(GETDATE()))
)
SELECT 
FORM_ID
		, SIGNATURE_DATE
	    , CAREGIVER_CODE
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

