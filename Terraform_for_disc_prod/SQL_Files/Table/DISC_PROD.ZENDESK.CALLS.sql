CREATE OR REPLACE TABLE DISC_PROD.ZENDESK.CALLS (
	SOURCE VARCHAR(10),
	ID NUMBER(20,0),
	CREATED_AT TIMESTAMP_NTZ(9),
	UPDATED_AT TIMESTAMP_NTZ(9),
	AGENT_ID NUMBER(20,0),
	CALL_CHARGE VARCHAR(50),
	CONSULTATION_TIME NUMBER(9,0),
	COMPLETION_STATUS VARCHAR(100),
	CUSTOMER_ID NUMBER(20,0),
	CUSTOMER_REQUESTED_VOICEMAIL BOOLEAN,
	DIRECTION VARCHAR(50),
	DURATION NUMBER(20,0),
	EXCEEDED_QUEUE_WAIT_TIME BOOLEAN,
	HOLD_TIME NUMBER(9,0),
	MINUTES_BILLED NUMBER(9,0),
	OUTSIDE_BUSINESS_HOURS BOOLEAN,
	PHONE_NUMBER_ID NUMBER(20,0),
	PHONE_NUMBER VARCHAR(100),
	TICKET_ID NUMBER(15,0),
	TIME_TO_ANSWER NUMBER(9,0),
	VOICEMAIL BOOLEAN,
	WAIT_TIME NUMBER(9,0),
	WRAP_UP_TIME NUMBER(9,0),
	IVR_TIME_SPENT NUMBER(9,0),
	IVR_HOPS NUMBER(9,0),
	IVR_DESTINATION_GROUP_NAME VARCHAR(100),
	TALK_TIME NUMBER(9,0),
	IVR_ROUTED_TO VARCHAR(100),
	CALLBACK BOOLEAN,
	CALLBACK_SOURCE VARCHAR(16777216),
	DEFAULT_GROUP BOOLEAN,
	IVR_ACTION VARCHAR(16777216),
	LINE VARCHAR(16777216),
	LINE_ID NUMBER(20,0),
	LINE_TYPE VARCHAR(16777216),
	OVERFLOWED BOOLEAN,
	OVERFLOWED_TO VARCHAR(16777216),
	RECORDING_CONTROL_INTERACTIONS NUMBER(9,0),
	RECORDING_TIME NUMBER(9,0),
	NOT_RECORDING_TIME NUMBER(9,0),
	CALL_RECORDING_CONSENT VARCHAR(200),
	CALL_RECORDING_CONSENT_ACTION VARCHAR(16777216),
	CALL_RECORDING_CONSENT_KEYPRESS VARCHAR(16777216),
	CALL_GROUP_ID NUMBER(15,0),
	CALL_CHANNEL VARCHAR(200),
	QUALITY_ISSUES VARIANT,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);