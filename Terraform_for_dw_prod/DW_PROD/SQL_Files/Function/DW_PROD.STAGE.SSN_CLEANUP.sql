CREATE OR REPLACE FUNCTION DW_PROD.STAGE.SSN_CLEANUP("SSN" VARCHAR(16777216))
RETURNS VARCHAR(11)
LANGUAGE SQL
AS '	
  	CASE 
  		WHEN LENGTH(NULLIF(REGEXP_REPLACE(TRIM(SSN),''\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]''),'''')) = 9 
		AND NOT (NULLIF(TRIM(REGEXP_REPLACE(SSN,''\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]'')),'''') LIKE ANY (''666%'',''000%''))
		AND LEFT(NULLIF(TRIM(REGEXP_REPLACE(SSN,''\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]'')),''''),3)::NUMBER NOT BETWEEN 900 AND 999
		THEN NULLIF(REGEXP_REPLACE(TRIM(SSN),''\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]''),'''')
		ELSE NULL
	END
';