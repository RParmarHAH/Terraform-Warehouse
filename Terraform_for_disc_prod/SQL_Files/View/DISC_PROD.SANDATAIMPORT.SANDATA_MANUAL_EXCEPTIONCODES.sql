create or replace view DISC_PROD.SANDATAIMPORT.SANDATA_MANUAL_EXCEPTIONCODES(
	AGENCYID,
	EXCEPTION_CODE,
	EXCEPTION_DESC
) as
WITH AGENCIES AS (
	SELECT
		DISTINCT AGENCYID
	FROM
		SANDATAIMPORT.SANDATA_EXCEPTIONCODES 
)
,
ALL_CODES AS (
	SELECT
		TRIM($2) AS EXCEPTION_CODE,
		TRIM($1) AS EXCEPTION_DESC
	FROM
		@DISC_PROD.STAGE.AWSAZSTAGEPROD/Files/sandata-ALL-manual-exception-codes.csv --RSUTHAR/KDHOKAI - CHANGE FILE FORMAT & STAGE
	LIMIT NULL OFFSET 1
)
SELECT
	AGENCIES.*,
	ALL_CODES.*
FROM
	ALL_CODES,
	AGENCIES;