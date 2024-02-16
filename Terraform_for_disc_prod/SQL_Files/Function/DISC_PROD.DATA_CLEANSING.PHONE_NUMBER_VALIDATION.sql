CREATE OR REPLACE FUNCTION DISC_PROD.DATA_CLEANSING.PHONE_NUMBER_VALIDATION("phone" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS '
 IFF(TRIM(phone) IS NULL ,
NULL,
IFF(
LENGTH(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''))=11 AND LEFT(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''),1)=1, -- checks IF the 11 digit number has 1 IN FIRST place i.e. US phone code
         CONCAT(''('', SUBSTRING(RIGHT(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''),10), 1, 3), '') '', SUBSTRING(RIGHT(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''),10), 4, 3), ''-'', SUBSTRING(RIGHT(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''),10), 7, 10)),
IFF(
	regexp_like(TRIM(phone),
	''^(\\\\d{3}|\\\\(\\\\d{3}\\\\))[-.\\s ]*(\\\\d{3})[-.\\s ]*(\\\\d{4})$'') OR LENGTH(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''))=10  ,
        CONCAT(''('', SUBSTRING(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''), 1, 3), '') '', SUBSTRING(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''), 4, 3), ''-'', SUBSTRING(REGEXP_REPLACE(TRIM(phone), ''[^[:digit:]]''), 7, 10)),
NULL
        )))
';