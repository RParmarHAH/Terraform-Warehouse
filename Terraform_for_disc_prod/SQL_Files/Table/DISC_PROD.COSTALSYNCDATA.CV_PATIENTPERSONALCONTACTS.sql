CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.CV_PATIENTPERSONALCONTACTS (
	DB VARCHAR(25),
	RECSTAT VARCHAR(1),
	ENTRY_USER VARCHAR(3),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(3),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	PATIENT_NUMBER VARCHAR(9),
	SEQUENCE_NUMBER NUMBER(19,5),
	FIRST_NAME VARCHAR(15),
	MIDDLE_INITIAL VARCHAR(1),
	LAST_NAME VARCHAR(25),
	RLNSHIP__CODE VARCHAR(3),
	NEXT_OF_KIN NUMBER(3,0),
	PRIMARY_CAREGIVER NUMBER(3,0),
	EMERGENCY NUMBER(3,0),
	CB_RESPONSIBLE_PARTY NUMBER(3,0),
	CB_SECONDARY_RESPONSIBLE NUMBER(3,0),
	POWER_OF_ATTORNEY NUMBER(3,0),
	SAME_ADDRESS NUMBER(3,0),
	ADDRESS_1 VARCHAR(31),
	ADDRESS_2 VARCHAR(31),
	CITY VARCHAR(25),
	STATE_CODE VARCHAR(3),
	ZIPCODE VARCHAR(11),
	PHONE_NUMBER VARCHAR(11),
	WORK_PHONE VARCHAR(11),
	BEEPER_CODE VARCHAR(15),
	BEEPER_NUMBER VARCHAR(11),
	FAX_NUMBER VARCHAR(11),
	E_MAIL_ADDRESS VARCHAR(41),
	BEREAVEMENT NUMBER(3,0),
	RISK_SCORE VARCHAR(3),
	EMPLOYER_CODE VARCHAR(11),
	CONTACT_PERSON VARCHAR(31),
	CONTACT_PHONE VARCHAR(11),
	EXTENSION_NUMBER VARCHAR(5),
	STATRT_DATE TIMESTAMP_NTZ(9),
	REMARK VARCHAR(41),
	SOCIAL_SECURITY_NUMBER VARCHAR(9),
	BIRTH_DATE TIMESTAMP_NTZ(9),
	SEX NUMBER(5,0),
	SALUTE VARCHAR(5),
	PERSONAL_CONTACT_TYPE_CD VARCHAR(7),
	CB_WILLING_TO_PRVDE_CARE NUMBER(3,0),
	CB_ABILITY_TO_PRVDE_CARE NUMBER(3,0),
	CB_AVAIL_TO_PROVIDE_CARE NUMBER(3,0),
	DEX_ROW_ID NUMBER(10,0),
	PAT_SCH_CONTACT_NOTES VARCHAR(2048),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);