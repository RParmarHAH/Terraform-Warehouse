CREATE OR REPLACE TABLE DISC_PROD.LANDING_8X8.HIST_TBL_INBOUND_CALLS (
	DNIS VARCHAR(16777216),
	AA_DESTINATION VARCHAR(16777216),
	CALL_ID VARCHAR(16777216),
	START_TIME_UTC VARCHAR(16777216),
	START_TIME TIMESTAMP_NTZ(9),
	CONNECT_TIME_UTC VARCHAR(16777216),
	CONNECT_TIME VARCHAR(16777216),
	DISCONNECTED_TIME_UTC VARCHAR(16777216),
	DISCONNECTED_TIME TIMESTAMP_NTZ(9),
	TALK_TIME_MS VARCHAR(16777216),
	TALK_TIME VARCHAR(16777216),
	CALLER VARCHAR(16777216),
	CALLER_NAME VARCHAR(16777216),
	CALLEE VARCHAR(16777216),
	CALLEE_NAME VARCHAR(16777216),
	DIRECTION VARCHAR(16777216),
	CALLER_ID VARCHAR(16777216),
	MISSED VARCHAR(16777216),
	ABANDONED VARCHAR(16777216),
	ANSWERED VARCHAR(16777216),
	ANSWERED_TIME TIMESTAMP_NTZ(9),
	CALLEE_DISCONNECT_ON_HOLD VARCHAR(16777216),
	CALLER_DISCONNECT_ON_HOLD VARCHAR(16777216),
	PBX_ID VARCHAR(16777216),
	SIP_CALL_ID VARCHAR(16777216),
	LAST_LEG_DISPOSITION VARCHAR(16777216),
	CALL_LEG_COUNT VARCHAR(16777216),
	CALL_TIME VARCHAR(16777216),
	RING_DURATION VARCHAR(16777216),
	ABANDONED_TIME VARCHAR(16777216),
	CALLEE_HOLD_DURATION_MS VARCHAR(16777216),
	CALLEE_HOLD_DURATION TIME(9),
	WAIT_TIME_MS VARCHAR(16777216),
	WAIT_TIME VARCHAR(16777216),
	DEPARTMENTS VARCHAR(16777216),
	BRANCHES VARCHAR(16777216),
	ETL_TASK_KEY VARCHAR(6),
	ETL_INSERTED_TASK_KEY VARCHAR(6),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216)
);