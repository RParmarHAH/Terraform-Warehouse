CREATE OR REPLACE TABLE DISC_PROD.GPSYNCDATA.HIST_UPR00900 (
	DEX_ROW_ID NUMBER(10,0),
	EMPLOYID VARCHAR(15),
	FDWTHLDG_1 NUMBER(19,5),
	FDWTHLDG_10 NUMBER(19,5),
	FDWTHLDG_11 NUMBER(19,5),
	FDWTHLDG_12 NUMBER(19,5),
	FDWTHLDG_2 NUMBER(19,5),
	FDWTHLDG_3 NUMBER(19,5),
	FDWTHLDG_4 NUMBER(19,5),
	FDWTHLDG_5 NUMBER(19,5),
	FDWTHLDG_6 NUMBER(19,5),
	FDWTHLDG_7 NUMBER(19,5),
	FDWTHLDG_8 NUMBER(19,5),
	FDWTHLDG_9 NUMBER(19,5),
	FEDERAL_WAGES_1 NUMBER(19,5),
	FEDERAL_WAGES_10 NUMBER(19,5),
	FEDERAL_WAGES_11 NUMBER(19,5),
	FEDERAL_WAGES_12 NUMBER(19,5),
	FEDERAL_WAGES_2 NUMBER(19,5),
	FEDERAL_WAGES_3 NUMBER(19,5),
	FEDERAL_WAGES_4 NUMBER(19,5),
	FEDERAL_WAGES_5 NUMBER(19,5),
	FEDERAL_WAGES_6 NUMBER(19,5),
	FEDERAL_WAGES_7 NUMBER(19,5),
	FEDERAL_WAGES_8 NUMBER(19,5),
	FEDERAL_WAGES_9 NUMBER(19,5),
	FICAMWDG_1 NUMBER(19,5),
	FICAMWDG_10 NUMBER(19,5),
	FICAMWDG_11 NUMBER(19,5),
	FICAMWDG_12 NUMBER(19,5),
	FICAMWDG_2 NUMBER(19,5),
	FICAMWDG_3 NUMBER(19,5),
	FICAMWDG_4 NUMBER(19,5),
	FICAMWDG_5 NUMBER(19,5),
	FICAMWDG_6 NUMBER(19,5),
	FICAMWDG_7 NUMBER(19,5),
	FICAMWDG_8 NUMBER(19,5),
	FICAMWDG_9 NUMBER(19,5),
	FICAMWGS_1 NUMBER(19,5),
	FICAMWGS_10 NUMBER(19,5),
	FICAMWGS_11 NUMBER(19,5),
	FICAMWGS_12 NUMBER(19,5),
	FICAMWGS_2 NUMBER(19,5),
	FICAMWGS_3 NUMBER(19,5),
	FICAMWGS_4 NUMBER(19,5),
	FICAMWGS_5 NUMBER(19,5),
	FICAMWGS_6 NUMBER(19,5),
	FICAMWGS_7 NUMBER(19,5),
	FICAMWGS_8 NUMBER(19,5),
	FICAMWGS_9 NUMBER(19,5),
	FICASSWG_1 NUMBER(19,5),
	FICASSWG_10 NUMBER(19,5),
	FICASSWG_11 NUMBER(19,5),
	FICASSWG_12 NUMBER(19,5),
	FICASSWG_2 NUMBER(19,5),
	FICASSWG_3 NUMBER(19,5),
	FICASSWG_4 NUMBER(19,5),
	FICASSWG_5 NUMBER(19,5),
	FICASSWG_6 NUMBER(19,5),
	FICASSWG_7 NUMBER(19,5),
	FICASSWG_8 NUMBER(19,5),
	FICASSWG_9 NUMBER(19,5),
	FICASSWH_1 NUMBER(19,5),
	FICASSWH_10 NUMBER(19,5),
	FICASSWH_11 NUMBER(19,5),
	FICASSWH_12 NUMBER(19,5),
	FICASSWH_2 NUMBER(19,5),
	FICASSWH_3 NUMBER(19,5),
	FICASSWH_4 NUMBER(19,5),
	FICASSWH_5 NUMBER(19,5),
	FICASSWH_6 NUMBER(19,5),
	FICASSWH_7 NUMBER(19,5),
	FICASSWH_8 NUMBER(19,5),
	FICASSWH_9 NUMBER(19,5),
	FUTAWAGS_1 NUMBER(19,5),
	FUTAWAGS_10 NUMBER(19,5),
	FUTAWAGS_11 NUMBER(19,5),
	FUTAWAGS_12 NUMBER(19,5),
	FUTAWAGS_2 NUMBER(19,5),
	FUTAWAGS_3 NUMBER(19,5),
	FUTAWAGS_4 NUMBER(19,5),
	FUTAWAGS_5 NUMBER(19,5),
	FUTAWAGS_6 NUMBER(19,5),
	FUTAWAGS_7 NUMBER(19,5),
	FUTAWAGS_8 NUMBER(19,5),
	FUTAWAGS_9 NUMBER(19,5),
	GROSWAGS_1 NUMBER(19,5),
	GROSWAGS_10 NUMBER(19,5),
	GROSWAGS_11 NUMBER(19,5),
	GROSWAGS_12 NUMBER(19,5),
	GROSWAGS_2 NUMBER(19,5),
	GROSWAGS_3 NUMBER(19,5),
	GROSWAGS_4 NUMBER(19,5),
	GROSWAGS_5 NUMBER(19,5),
	GROSWAGS_6 NUMBER(19,5),
	GROSWAGS_7 NUMBER(19,5),
	GROSWAGS_8 NUMBER(19,5),
	GROSWAGS_9 NUMBER(19,5),
	LPCHKAMT NUMBER(19,5),
	LPCHKNUM VARCHAR(21),
	LSTPCKDT TIMESTAMP_NTZ(9),
	NETWAGES_1 NUMBER(19,5),
	NETWAGES_10 NUMBER(19,5),
	NETWAGES_11 NUMBER(19,5),
	NETWAGES_12 NUMBER(19,5),
	NETWAGES_2 NUMBER(19,5),
	NETWAGES_3 NUMBER(19,5),
	NETWAGES_4 NUMBER(19,5),
	NETWAGES_5 NUMBER(19,5),
	NETWAGES_6 NUMBER(19,5),
	NETWAGES_7 NUMBER(19,5),
	NETWAGES_8 NUMBER(19,5),
	NETWAGES_9 NUMBER(19,5),
	SUTAWAGS_1 NUMBER(19,5),
	SUTAWAGS_10 NUMBER(19,5),
	SUTAWAGS_11 NUMBER(19,5),
	SUTAWAGS_12 NUMBER(19,5),
	SUTAWAGS_2 NUMBER(19,5),
	SUTAWAGS_3 NUMBER(19,5),
	SUTAWAGS_4 NUMBER(19,5),
	SUTAWAGS_5 NUMBER(19,5),
	SUTAWAGS_6 NUMBER(19,5),
	SUTAWAGS_7 NUMBER(19,5),
	SUTAWAGS_8 NUMBER(19,5),
	SUTAWAGS_9 NUMBER(19,5),
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