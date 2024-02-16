create or replace view DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES_INCNSTNT(
	ADDRESS,
	CITY,
	STATE,
	ZIP,
	CNT
) as (
SELECT X.ADDRESS ,X.CITY,X.STATE,X.ZIP ,count(*) FROM  
	(SELECT DISTINCT 
	ADDRESS,
	CITY,
	STATE,
	ZIP,
	ADDRESS_NUMBER,
	STREET,
	MUNICIPALITY,
	REGION,
	SUB_REGION,
	COUNTRY_CODE
	FROM DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
	WHERE zip = ZIPCODE )X 
	GROUP BY 1,2,3,4 HAVING count(*) > 1);