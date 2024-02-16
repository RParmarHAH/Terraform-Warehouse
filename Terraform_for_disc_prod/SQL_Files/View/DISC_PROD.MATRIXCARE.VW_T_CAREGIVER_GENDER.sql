create or replace view DISC_PROD.MATRIXCARE.VW_T_CAREGIVER_GENDER(
	CAR_EMPSEXID,
	GENDER_TEXT
) as
WITH DEFINITIONS AS (
	SELECT CODES.CAR_EMPSEXID, DEFINITIONS.GENDER AS GENDER_TEXT, 
		ROW_NUMBER() OVER (PARTITION BY CODES.CAR_EMPSEXID ORDER BY COUNT(*) DESC) AS ROW_NUMBER
	FROM MATRIXCARE.STVHC_T_CAREGIVER AS CODES
	JOIN ADAPTIVENURSINGEXPORT.T_CAREGIVER AS DEFINITIONS
		ON DEFINITIONS.CAR_ID = CODES.CAR_ID 
	WHERE CODES.CAR_EMPSEXID IS NOT NULL AND DEFINITIONS.GENDER IS NOT NULL
	GROUP BY CODES.CAR_EMPSEXID, DEFINITIONS.GENDER 
)
	SELECT CAR_EMPSEXID, GENDER_TEXT
	FROM DEFINITIONS
	WHERE ROW_NUMBER = 1;