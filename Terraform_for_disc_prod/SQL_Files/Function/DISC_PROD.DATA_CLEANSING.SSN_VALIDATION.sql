CREATE OR REPLACE FUNCTION DISC_PROD.DATA_CLEANSING.SSN_VALIDATION("SSN" VARCHAR(16777216))
RETURNS VARCHAR(11)
LANGUAGE SQL
AS '
	 SELECT 
	 CASE 
	WHEN TRIM(SSN) = '''' OR SSN IS NULL THEN  NULL
    WHEN LENGTH(REGEXP_REPLACE(TRIM(SSN),''[^[:digit:]$]''))<>9 THEN NULL
  		WHEN NOT (NULLIF(TRIM(REGEXP_REPLACE(SSN ,''\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]'')),'''') LIKE ANY (''666%'',''000%'',''9%'',''%0000'',''___00%''))
		THEN (CASE WHEN
	 CONTAINS(TRIM(SSN), ''-'') = FALSE  THEN CONCAT(SUBSTRING(SSN,1,3)||''-''||SUBSTRING(SSN,4,2)||''-''||SUBSTRING(SSN,6,4))
	 ELSE TRIM(SSN)
	 END)
		ELSE  NULL 
	END
';