CREATE OR REPLACE TABLE DISC_PROD.UTIL.GP_PAYCODES_MAP_TO_SERVICE (
	DB VARCHAR(10),
	PAY_CODE VARCHAR(12),
	DESCRIPTION VARCHAR(50),
	IS_CODE_ACTIVE BOOLEAN,
	IS_OVERTIME_CODE BOOLEAN,
	IS_SERVICE_DELIVERY_CODE BOOLEAN,
	SERVICE_CODE VARCHAR(50),
	SERVICE_DESCRIPTION VARCHAR(1024)
);