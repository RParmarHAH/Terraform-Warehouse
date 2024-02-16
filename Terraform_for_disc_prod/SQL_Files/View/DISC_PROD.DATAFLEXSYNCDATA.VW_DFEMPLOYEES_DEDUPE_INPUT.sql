create or replace view DISC_PROD.DATAFLEXSYNCDATA.VW_DFEMPLOYEES_DEDUPE_INPUT(
	ID,
	DBNAME,
	NUMBER,
	NAME,
	FIRSTNAME,
	LASTNAME,
	SSN,
	DOB,
	ADDRESS1,
	CITY,
	PHONENUMBER,
	STATE,
	HIREDATE,
	CREATEDDATE,
	UPDATEDTIME,
	ETL_LAST_UPDATED_DATE
) as
SELECT ID,DBNAME,NUMBER,REGEXP_REPLACE(FIRSTNAME, '[\\\s]+','') || REGEXP_REPLACE(LASTNAME, '[\\\s]+','') as NAME,FIRSTNAME,LASTNAME,SSN,DOB,ADDRESS1,CITY,PHONENUMBER,STATE,HIREDATE,CREATEDDATE,UPDATEDTIME,ETL_LAST_UPDATED_DATE
FROM (
	select DBNAME||NUMBER as ID,
	TRIM(e.DBNAME) DBNAME,
	NUMBER,
	LASTNAME||FIRSTNAME as NAME,
	CASE 
		WHEN UPPER(TRIM(e.FirstName)) <> '' AND e.FirstName IS NOT NULL THEN UPPER(TRIM(e.FirstName))
		WHEN UPPER(TRIM(gp.First_Name)) <> '' THEN UPPER(TRIM(gp.First_Name))
		ELSE NULL
	END AS FIRSTNAME,
	CASE
		WHEN UPPER(TRIM(e.LastName)) <> '' AND e.LastName IS NOT NULL THEN UPPER(TRIM(e.LastName))
		WHEN UPPER(TRIM(gp.Last_Name)) <> '' THEN UPPER(TRIM(gp.Last_Name))
	ELSE NULL
	END AS LASTNAME,
	CASE
		WHEN TRIM(e.ssn) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM(e.ssn) NOT LIKE '00000%' AND LENGTH(TRIM(e.SSN)) = 9 THEN TRIM(e.SSN)
		WHEN TRIM(gp.ssn) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM(gp.ssn) NOT LIKE '00000%' AND LENGTH(TRIM(gp.SSN)) = 9 THEN TRIM(gp.SSN)
		ELSE NULL
	END AS SSN,
	CASE 
		WHEN e.DOB >= CAST('1901-01-01' AS DATE) AND e.DOB <= DATEADD(YEAR, -12, CURRENT_DATE) THEN e.DOB
		WHEN CAST(gp.DOB AS DATE) >= CAST('1901-01-01' AS DATE) AND CAST(gp.DOB AS DATE) <= DATEADD(YEAR, -12, CURRENT_DATE) THEN CAST(gp.DOB AS DATE)
		ELSE NULL
	END AS DOB,
	CASE
		WHEN UPPER(TRIM(e.Address1)) <> '' AND UPPER(TRIM(e.Address1)) IS NOT NULL THEN UPPER(TRIM(e.Address1))
		WHEN UPPER(TRIM(gp.Address1)) <> '' THEN UPPER(TRIM(gp.Address1))
		ELSE NULL
	END AS ADDRESS1,
	CASE 
		WHEN UPPER(TRIM(e.City)) <> '' AND UPPER(TRIM(e.City)) IS NOT NULL THEN UPPER(TRIM(e.City))
		WHEN UPPER(TRIM(gp.City)) <> '' THEN UPPER(TRIM(gp.City))
		ELSE NULL
	END AS CITY,
	CASE 
		WHEN TRIM(REGEXP_REPLACE(e.PhoneNumber,'\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|','')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND e.PhoneNumber NOT LIKE '%0000000%' AND LENGTH(TRIM(REGEXP_REPLACE(e.PhoneNumber,'\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|',''))) = 10 THEN TRIM(REGEXP_REPLACE(e.PhoneNumber,'\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|',''))
		WHEN TRIM(REGEXP_REPLACE(gp.Phone_Number,'\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|','')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND gp.Phone_Number NOT LIKE '%0000000%' AND LENGTH(TRIM(REGEXP_REPLACE(gp.Phone_Number,'\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|',''))) = 10 THEN TRIM(REGEXP_REPLACE(gp.Phone_Number,'\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|',''))
		ELSE NULL
	END AS PHONENUMBER,
	trim(e.STATE) as STATE,
	e.HIREDATE,
	e.CREATEDDATE,
	e.UPDATEDTIME,
	e.ETL_LAST_UPDATED_DATE
	from DISC_PROD.DATAFLEXSYNCDATA.DFEMPLOYEES e
	LEFT OUTER JOIN DISC_PROD.GPSyncData.GPAllEmployeesBase AS gp --RSUTHAR/KDHOKAI - changed DISC_DEV.GPSyncData.GPAllEmployeesBase TO DISC_PROD.GPSyncData.GPAllEmployeesBase 
	ON TRIM(e.number) = TRIM(gp.Employee_ID) 
	AND TRIM(e.DBName) = TRIM(gp.Office_State)
);