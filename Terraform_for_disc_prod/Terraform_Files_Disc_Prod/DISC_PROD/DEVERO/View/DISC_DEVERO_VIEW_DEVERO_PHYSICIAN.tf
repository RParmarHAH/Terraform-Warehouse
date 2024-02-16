resource "snowflake_view" "DISC_DEVERO_VIEW_DEVERO_PHYSICIAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "VIEW_DEVERO_PHYSICIAN"
	statement = <<-SQL
	 ( 
WITH RESULT_DATA AS
(
SELECT 	DISTINCT
          P.PHYSICIAN_ID
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'FIRST_NAME'):"$" :: STRING AS FIRST_NAME
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'MIDDLE_NAME'):"$" :: STRING AS MIDDLE_NAME
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'LAST_NAME'):"$" :: STRING AS LAST_NAME
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'TITLE'):"$" :: STRING AS TITLE
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'ADDRESS_1'):"$" :: STRING AS ADDRESS_1
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'ADDRESS_2'):"$" :: STRING AS ADDRESS_2
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'CITY'):"$" :: STRING AS CITY
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'STATE'):"$" :: STRING AS STATE
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'ZIP_CODE'):"$" :: STRING AS ZIP_CODE
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'PHONE'):"$" :: STRING AS PHONE
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'FAX'):"$" :: STRING AS FAX
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'EMAIL'):"$" :: STRING AS EMAIL
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'UPIN'):"$" :: STRING AS UPIN
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'NPI'):"$" :: STRING AS NPI
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'PECOS_STATUS'):"$" :: STRING AS PECOS_STATUS
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'LAST_CHECKED'):"$" :: STRING AS LAST_CHECKED
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'PROTOCOL'):"$" :: STRING AS PROTOCOL
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'LICENSE_NUMBER'):"$" :: STRING AS LICENSE_NUMBER
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'LICENSE_STATE'):"$" :: STRING AS LICENSE_STATE
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'LICENSE_EXPIRATION'):"$" :: STRING AS LICENSE_EXPIRATION
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'PHYSICIAN_CODE'):"$" :: STRING AS PHYSICIAN_CODE
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'EXTERNAL_ID'):"$" :: STRING AS EXTERNAL_ID
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'MYUNITY_AGENCY_ID'):"$" :: STRING AS MYUNITY_AGENCY_ID
		, NULL AS AGENCY_ID  --PHYSICIAN.VALUE:"$" :: STRING AGENCY_ID
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'ACTIVE'):"$" :: STRING AS ACTIVE
		, XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'DATE_MODIFIED'):"$" :: STRING AS DATE_MODIFIED
		, P.ETL_TASK_KEY 
		, P.ETL_INSERTED_TASK_KEY
		, P.ETL_INSERTED_DATE
		, P.ETL_INSERTED_BY 
		, P.ETL_LAST_UPDATED_DATE
		, P.ETL_LAST_UPDATED_BY
		, P.ETL_DELETED_FLAG
		, ROW_NUMBER() OVER(PARTITION BY P.PHYSICIAN_ID ORDER BY DATE_MODIFIED DESC) AS LATEST_MODIFIED
  FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_PHYSICIAN  P
--, LATERAL FLATTEN(XMLGET(PARSE_XML(P.PHYSICIAN_XML), 'AGENCY_IDS'):"$":: ARRAY) PHYSICIAN
--WHERE DATE(P.ETL_LAST_UPDATED_DATE) = COALESCE((
--SELECT MAX(DATE(ETL_LAST_UPDATED_DATE)) FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_PHYSICIAN),DATE(GETDATE()))
)
SELECT 
PHYSICIAN_ID
		, FIRST_NAME
		, MIDDLE_NAME
		, LAST_NAME
		, TITLE
		, ADDRESS_1
		, ADDRESS_2
		, CITY
		, STATE
		, ZIP_CODE
		, PHONE
		, FAX
		, EMAIL
		, UPIN
		, NPI
		, PECOS_STATUS
		, LAST_CHECKED
		, PROTOCOL
		, LICENSE_NUMBER
		, LICENSE_STATE
		, LICENSE_EXPIRATION
		, PHYSICIAN_CODE
		, EXTERNAL_ID
		, MYUNITY_AGENCY_ID
		, AGENCY_ID
		, ACTIVE
		, DATE_MODIFIED
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

