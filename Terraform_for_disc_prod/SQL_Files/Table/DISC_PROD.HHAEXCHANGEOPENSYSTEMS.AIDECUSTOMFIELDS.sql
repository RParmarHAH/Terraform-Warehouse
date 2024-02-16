CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.AIDECUSTOMFIELDS (
	AIDECUSTOMFIELDID NUMBER(10,0) NOT NULL,
	AIDEID NUMBER(10,0),
	AGENCYID NUMBER(10,0) NOT NULL,
	TEXT1 VARCHAR(50),
	TEXT2 VARCHAR(50),
	TEXT3 VARCHAR(50),
	TEXT4 VARCHAR(50),
	TEXT5 VARCHAR(50),
	TEXT6 VARCHAR(50),
	TEXT7 VARCHAR(50),
	TEXT8 VARCHAR(50),
	TEXT9 VARCHAR(50),
	TEXT10 VARCHAR(50),
	DROPDOWN1 NUMBER(3,0),
	DROPDOWN2 NUMBER(3,0),
	DROPDOWN3 NUMBER(3,0),
	DROPDOWN4 NUMBER(3,0),
	DROPDOWN5 NUMBER(3,0),
	DROPDOWN6 NUMBER(3,0),
	DROPDOWN7 NUMBER(3,0),
	DROPDOWN8 NUMBER(3,0),
	DROPDOWN9 NUMBER(3,0),
	DROPDOWN10 NUMBER(3,0),
	CHECKBOX1 BOOLEAN,
	CHECKBOX2 BOOLEAN,
	CHECKBOX3 BOOLEAN,
	CHECKBOX4 BOOLEAN,
	CHECKBOX5 BOOLEAN,
	CHECKBOX6 BOOLEAN,
	CHECKBOX7 BOOLEAN,
	CHECKBOX8 BOOLEAN,
	CHECKBOX9 BOOLEAN,
	CHECKBOX10 BOOLEAN,
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	DROPDOWNVALUE1 VARCHAR(50),
	DROPDOWNVALUE2 VARCHAR(50),
	DROPDOWNVALUE3 VARCHAR(50),
	DROPDOWNVALUE4 VARCHAR(50),
	DROPDOWNVALUE5 VARCHAR(50),
	DROPDOWNVALUE6 VARCHAR(50),
	DROPDOWNVALUE7 VARCHAR(50),
	DROPDOWNVALUE8 VARCHAR(50),
	DROPDOWNVALUE9 VARCHAR(50),
	DROPDOWNVALUE10 VARCHAR(50),
	DROPDOWNTEXT1 VARCHAR(50),
	DROPDOWNTEXT2 VARCHAR(50),
	DROPDOWNTEXT3 VARCHAR(50),
	DROPDOWNTEXT4 VARCHAR(50),
	DROPDOWNTEXT5 VARCHAR(50),
	DROPDOWNTEXT6 VARCHAR(50),
	DROPDOWNTEXT7 VARCHAR(50),
	DROPDOWNTEXT8 VARCHAR(50),
	DROPDOWNTEXT9 VARCHAR(50),
	DROPDOWNTEXT10 VARCHAR(50),
	TEXT11 VARCHAR(50),
	TEXT12 VARCHAR(50),
	TEXT13 VARCHAR(50),
	TEXT14 VARCHAR(50),
	TEXT15 VARCHAR(50),
	TEXT16 VARCHAR(50),
	TEXT17 VARCHAR(50),
	TEXT18 VARCHAR(50),
	TEXT19 VARCHAR(50),
	TEXT20 VARCHAR(50),
	CHECKBOX11 BOOLEAN,
	CHECKBOX12 BOOLEAN,
	CHECKBOX13 BOOLEAN,
	CHECKBOX14 BOOLEAN,
	CHECKBOX15 BOOLEAN,
	CHECKBOX16 BOOLEAN,
	CHECKBOX17 BOOLEAN,
	CHECKBOX18 BOOLEAN,
	CHECKBOX19 BOOLEAN,
	CHECKBOX20 BOOLEAN,
	DROPDOWN11 NUMBER(3,0),
	DROPDOWNVALUE11 VARCHAR(50),
	DROPDOWNTEXT11 VARCHAR(50),
	DROPDOWN12 NUMBER(3,0),
	DROPDOWNVALUE12 VARCHAR(50),
	DROPDOWNTEXT12 VARCHAR(50),
	DROPDOWN13 NUMBER(3,0),
	DROPDOWNVALUE13 VARCHAR(50),
	DROPDOWNTEXT13 VARCHAR(50),
	DROPDOWN14 NUMBER(3,0),
	DROPDOWNVALUE14 VARCHAR(50),
	DROPDOWNTEXT14 VARCHAR(50),
	DROPDOWN15 NUMBER(3,0),
	DROPDOWNVALUE15 VARCHAR(50),
	DROPDOWNTEXT15 VARCHAR(50),
	DROPDOWN16 NUMBER(3,0),
	DROPDOWNVALUE16 VARCHAR(50),
	DROPDOWNTEXT16 VARCHAR(50),
	DROPDOWN17 NUMBER(3,0),
	DROPDOWNVALUE17 VARCHAR(50),
	DROPDOWNTEXT17 VARCHAR(50),
	DROPDOWN18 NUMBER(3,0),
	DROPDOWNVALUE18 VARCHAR(50),
	DROPDOWNTEXT18 VARCHAR(50),
	DROPDOWN19 NUMBER(3,0),
	DROPDOWNVALUE19 VARCHAR(50),
	DROPDOWNTEXT19 VARCHAR(50),
	DROPDOWN20 NUMBER(3,0),
	DROPDOWNVALUE20 VARCHAR(50),
	DROPDOWNTEXT20 VARCHAR(50),
	TEXT21 VARCHAR(50),
	TEXT22 VARCHAR(50),
	TEXT23 VARCHAR(50),
	TEXT24 VARCHAR(50),
	TEXT25 VARCHAR(50),
	TEXT26 VARCHAR(50),
	TEXT27 VARCHAR(50),
	TEXT28 VARCHAR(50),
	TEXT29 VARCHAR(50),
	TEXT30 VARCHAR(50),
	PROVIDERID NUMBER(19,0),
	OFFICEID NUMBER(10,0),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	UPDATEDUTCDATE TIMESTAMP_NTZ(9),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);