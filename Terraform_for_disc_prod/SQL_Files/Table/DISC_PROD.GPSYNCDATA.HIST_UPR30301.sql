CREATE OR REPLACE TABLE DISC_PROD.GPSYNCDATA.HIST_UPR30301 (
	DEX_ROW_ID NUMBER(10,0),
	EMPLOYID VARCHAR(15),
	LCTXBLWG_1 NUMBER(19,5),
	LCTXBLWG_10 NUMBER(19,5),
	LCTXBLWG_11 NUMBER(19,5),
	LCTXBLWG_12 NUMBER(19,5),
	LCTXBLWG_2 NUMBER(19,5),
	LCTXBLWG_3 NUMBER(19,5),
	LCTXBLWG_4 NUMBER(19,5),
	LCTXBLWG_5 NUMBER(19,5),
	LCTXBLWG_6 NUMBER(19,5),
	LCTXBLWG_7 NUMBER(19,5),
	LCTXBLWG_8 NUMBER(19,5),
	LCTXBLWG_9 NUMBER(19,5),
	MTDHOURS_1 NUMBER(10,0),
	MTDHOURS_10 NUMBER(10,0),
	MTDHOURS_11 NUMBER(10,0),
	MTDHOURS_12 NUMBER(10,0),
	MTDHOURS_2 NUMBER(10,0),
	MTDHOURS_3 NUMBER(10,0),
	MTDHOURS_4 NUMBER(10,0),
	MTDHOURS_5 NUMBER(10,0),
	MTDHOURS_6 NUMBER(10,0),
	MTDHOURS_7 NUMBER(10,0),
	MTDHOURS_8 NUMBER(10,0),
	MTDHOURS_9 NUMBER(10,0),
	MTDWAGES_1 NUMBER(19,5),
	MTDWAGES_10 NUMBER(19,5),
	MTDWAGES_11 NUMBER(19,5),
	MTDWAGES_12 NUMBER(19,5),
	MTDWAGES_2 NUMBER(19,5),
	MTDWAGES_3 NUMBER(19,5),
	MTDWAGES_4 NUMBER(19,5),
	MTDWAGES_5 NUMBER(19,5),
	MTDWAGES_6 NUMBER(19,5),
	MTDWAGES_7 NUMBER(19,5),
	MTDWAGES_8 NUMBER(19,5),
	MTDWAGES_9 NUMBER(19,5),
	PAYROLCD VARCHAR(7),
	PYRLRTYP NUMBER(5,0),
	STXBLWGS_1 NUMBER(19,5),
	STXBLWGS_10 NUMBER(19,5),
	STXBLWGS_11 NUMBER(19,5),
	STXBLWGS_12 NUMBER(19,5),
	STXBLWGS_2 NUMBER(19,5),
	STXBLWGS_3 NUMBER(19,5),
	STXBLWGS_4 NUMBER(19,5),
	STXBLWGS_5 NUMBER(19,5),
	STXBLWGS_6 NUMBER(19,5),
	STXBLWGS_7 NUMBER(19,5),
	STXBLWGS_8 NUMBER(19,5),
	STXBLWGS_9 NUMBER(19,5),
	YEAR1 NUMBER(5,0),
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