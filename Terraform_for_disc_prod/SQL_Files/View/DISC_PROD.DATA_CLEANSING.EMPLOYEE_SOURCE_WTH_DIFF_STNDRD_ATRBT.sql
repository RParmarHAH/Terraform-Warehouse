create or replace view DISC_PROD.DATA_CLEANSING.EMPLOYEE_SOURCE_WTH_DIFF_STNDRD_ATRBT(
	SRC_EMPLOYEE_ADDRESS,
	SRC_EMPLOYEE_CITY,
	SRC_EMPLOYEE_STATE_CODE,
	SRC_EMPLOYEE_ZIP,
	CNT
) as
		SELECT  x.SRC_EMPLOYEE_ADDRESS,x.SRC_EMPLOYEE_CITY,x.SRC_EMPLOYEE_STATE_CODE,x.SRC_EMPLOYEE_ZIP,count(*) AS CNT FROM  
		(SELECT 
		"SRC_EMPLOYEE_ADDRESS" ,
		"SRC_EMPLOYEE_CITY" ,
		"SRC_EMPLOYEE_STATE_CODE" ,
		"SRC_EMPLOYEE_ZIP" ,
		STD_EMPLOYEE_ADDRESS,
		STD_EMPLOYEE_CITY,
		STD_EMPLOYEE_COUNTY,
		STD_EMPLOYEE_STATE_NAME,
		STD_EMPLOYEE_STATE_CODE,
		STD_EMPLOYEE_ZIP,
		STD_EMPLOYEE_ZIP_PLUS_FOUR,
		STD_EMPLOYEE_COUNTRY_CODE,
		ADDRESS_NUMBER,
		STREET,
		LABEL,
		POINTS,
		LATITUDE ,
		LONGITUDE ,
		RELEVANCE 
		FROM  
		DISC_PROD.DATA_CLEANSING."EMPLOYEE_STD_ATTRIBUTES" 
		WHERE SRC_EMPLOYEE_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG = TRUE 
		GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19)x
		GROUP BY 1,2,3,4 HAVING count(*) > 1;