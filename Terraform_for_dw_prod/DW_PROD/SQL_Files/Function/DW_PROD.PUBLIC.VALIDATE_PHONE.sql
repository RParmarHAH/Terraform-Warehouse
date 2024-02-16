CREATE OR REPLACE FUNCTION DW_PROD.PUBLIC.VALIDATE_PHONE("PHONE" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
STRICT
AS '
  case when LENGTH(REGEXP_REPLACE(phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) =10 then REGEXP_REPLACE(phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')
       ELSE NULL
 END  ';