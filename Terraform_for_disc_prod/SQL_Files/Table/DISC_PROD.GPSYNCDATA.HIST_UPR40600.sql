CREATE OR REPLACE TABLE DISC_PROD.GPSYNCDATA.HIST_UPR40600 (
	ACRUSTIM NUMBER(3,0),
	ACRUVACN NUMBER(3,0),
	BSDONRTE NUMBER(19,5),
	BSPAYRCD VARCHAR(7),
	DATAENTDFLT NUMBER(3,0),
	DEX_ROW_ID NUMBER(10,0),
	DSCRIPTN VARCHAR(31),
	FFEDTXRT NUMBER(5,0),
	FLSTTXRT NUMBER(5,0),
	INACTIVE NUMBER(3,0),
	MXPYPPER NUMBER(19,5),
	NOTEINDX NUMBER(19,5),
	PAYADVNC NUMBER(19,5),
	PAYFACTR NUMBER(19,5),
	PAYPEROD NUMBER(5,0),
	PAYPRPRD NUMBER(19,5),
	PAYRCORD VARCHAR(7),
	PAYRTAMT NUMBER(19,5),
	PAYTYPE NUMBER(5,0),
	PAYUNIT VARCHAR(25),
	PAYUNPER NUMBER(5,0),
	RPTASWGS NUMBER(3,0),
	SBJTFDTX NUMBER(3,0),
	SBJTFUTA NUMBER(3,0),
	SBJTLTAX NUMBER(3,0),
	SBJTMCAR NUMBER(3,0),
	SBJTSSEC NUMBER(3,0),
	SBJTSTTX NUMBER(3,0),
	SBJTSUTA NUMBER(3,0),
	SHFTCODE VARCHAR(7),
	TAXABLE NUMBER(3,0),
	TIPTYPE NUMBER(5,0),
	W2BXLABL VARCHAR(7),
	W2BXLABL2 VARCHAR(7),
	W2BXLABL3 VARCHAR(7),
	W2BXLABL4 VARCHAR(7),
	W2BXNMBR NUMBER(5,0),
	W2BXNMBR2 NUMBER(5,0),
	W2BXNMBR3 NUMBER(5,0),
	W2BXNMBR4 NUMBER(5,0),
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