create or replace view DISC_PROD.APTITIVE_DEV.V_STANDARDIZED_DF_CLIENTS(
	ID,
	DBNAME,
	NUMBER,
	VALID_DOB,
	DOB,
	VALID_PHONE_NUMBER,
	PHONENUMBER,
	VALID_SSN,
	SSN,
	FIRST_NAME_STANDARDIZED,
	FIRSTNAME,
	LAST_NAME_STANDARDIZED,
	LASTNAME,
	MIDDLE_NAME_STANDARDIZED,
	MIDDLENAME,
	FULLNAME,
	VALID_ZIP,
	ZIP,
	ADDRESS_1,
	ADDRESS_2,
	CITY,
	STATE,
	FULL_ADDRESS
) as
/***********************************************************************************************
VIEW:            V_STANDARDIZED_DF_CLIENTS

SOURCE SYSTEMS: DATAFLEX

DATE             AUTHOR              DESCRIPTION
----------       --------------      --------------------------------------------------------
6/25/2021        APTITIVE            INITIAL VERSION
***********************************************************************************************/
(
--DOB NORMALIZING:
-- 1: ELIMINATING INVALID DOB THAT ARE GREATER THAN THE CURRENT DATE or BETWEEN A CERTAIN RANGE
SELECT 
     DBNAME || '|' || NUMBER AS ID
     , DBNAME
     , NUMBER
     , CASE
           WHEN
               DOB > CURRENT_DATE() THEN NULL
           WHEN YEAR(DOB) > year(current_date()) AND YEAR(DOB) < 1910 THEN NULL
           ELSE DOB END                                        AS VALID_DOB
     , DOB                                                     AS DOB
--PHONE NUMBER NORMALIZING:
--1: ELIMINATING PHONE NUMBERS THAT ARE NOT 10 DIGITS NUMBERS
--2: ELIMINATING SPECIAL CHARACTERS ON PHONE NUMBERS
     , CASE
           WHEN length(regexp_replace(PHONENUMBER, '\\W', '')) <> 10 THEN NULL
           ELSE regexp_replace(PHONENUMBER, '\\W', '')
    END                                                        AS VALID_PHONE_NUMBER
     , PHONENUMBER                                             as PHONENUMBER
--SSN NORMALIZING:
--1: ELIMINATING SSN's THAT ARE NOT 9 DIGITS NUMBERS
--2: ELIMINATING SPECIAL CHARACTERS ON SSN's
     , CASE
           WHEN LENGTH(regexp_replace(SSN, '\\W', '')) <> 9 THEN NULL
           else regexp_replace(SSN, '\\W', '') end             as VALID_SSN
     , SSN                                                     AS SSN
--FIRST NAME Standardization:
--1: UPPERING AND TRIMMING FIRSTNAMES
--2: ELIMINATING FIRST NAME WITH SPECIAL AND NUMERIC CHARACTERS
     , upper(trim(regexp_REPLACE(FIRSTNAME, '[\\W\\d]', '')))  AS FIRST_NAME_STANDARDIZED
     , FIRSTNAME                                               AS FIRSTNAME
--LAST NAME Standardization:
--1: UPPERING AND TRIMMING LASTNAMES
--2: ELIMINATING LAST NAME WITH SPECIAL AND NUMERIC CHARACTERS
     , upper(trim(regexp_REPLACE(LASTNAME, '[\\W\\d]', '')))   AS LAST_NAME_STANDARDIZED
     , LASTNAME                                                AS LASTNAME
--MIDDLE NAME Standardization:
--1: UPPERING AND TRIMMING MIDDLENAME
--2: ELIMINATING MIDDLE NAME WITH SPECIAL AND NUMERIC CHARACTERS
     , upper(trim(regexp_REPLACE(MIDDLENAME, '[\\W\\d]', ''))) AS MIDDLE_NAME_STANDARDIZED
     , MIDDLENAME                                              AS MIDDLENAME
     , FIRSTNAME || ' ' || MIDDLENAME || ' ' || LASTNAME AS FULLNAME
--ZIP CODE NORMALIZING:
--1: REPLACING EMPTY STRINGS WITH NULLS
--2: ELIMINATING ZIP CODES THAT ARE NOT 5 DIGITS
     , CASE
           WHEN ZIP = '' THEN NULL
           WHEN LENGTH(ZIP) <> 5 THEN NULL
           ELSE ZIP END                                        AS VALID_ZIP
     , ZIP                                                     AS ZIP
--ADDRESS STANDARDIZATION:
     , UPPER(TRIM(ADDRESS1))                                   AS ADDRESS_1
      , UPPER(TRIM(ADDRESS2)) AS ADDRESS_2
     , UPPER(TRIM(CITY)) AS CITY
     , UPPER(TRIM(STATE)) AS STATE
     , ADDRESS_1 || ' ' || ADDRESS_2 || ' ' || UPPER(TRIM(CITY)) || ' ' || UPPER(TRIM(STATE)) || ' ' || ZIP as FULL_ADDRESS
FROM DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTS
WHERE firstname not ilike 'PAYONLY%' 
  and firstname != 'PAY' 
  and firstname != 'SLS' 
  and firstname != 'HOME' 
  and firstname != 'HELPATHOME' 
  and firstname != 'HELP AT HOME' 
  and firstname != 'MANAGER' 
  and firstname not like '%HOUSE%' 
  and lastname != 'PAY' 
  and firstname != address1 
  and not (lastname = 'HOUSE' and regexp_count(firstname, '\\d') > 0) 
    );