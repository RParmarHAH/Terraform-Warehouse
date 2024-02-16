create or replace view DW_PROD.INTEGRATION.VW_DIM_CLIENT_NY(
	ID,
	SYSTEM_CODE,
	CLIENT_PID,
	CLIENT_DOB,
	CLIENT_NAME,
	CLIENT_FIRST_NAME,
	CLIENT_LAST_NAME,
	CLIENT_ADDRESS1,
	CLIENT_CITY,
	CLIENT_HOME_PHONE
) as
SELECT TRIM(CLIENT_KEY) ID,SYSTEM_CODE,CLIENT_PID,CLIENT_DOB,CLIENT_NAME,CLIENT_FIRST_NAME,CLIENT_LAST_NAME,CLIENT_ADDRESS1,CLIENT_CITY,CLIENT_HOME_PHONE  from DW_PROD.HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID = 17 AND SYSTEM_CODE IN ('PREFERRED','EDISON');