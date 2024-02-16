CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_GUID_PREMIUM()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_GUID_PREMIUM 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2021-11-11		UNKNOWN					INITIAL DEVELOPMENT
-- 2023-09-05  		RAVI SUTHAR            	MIGRATED JavaScript to SQL
--*****************************************************************************************************************************
    return_result varchar(1000);
BEGIN
	
    INSERT OVERWRITE INTO ALAYACARE.GUID_PREMIUM 
	SELECT ID,	PREMIUM_ID,	PREMIUM_CLIENT_ID,	GUID_TO,	DESCRIPTION,	GUID,	FUNDING_METHODOLOGY,	DEFAULT_RATE,	IS_READ_ONLY,	START_AT,	END_AT,	OVERRIDE_QUANTITY,	OVERRIDE_RATE,	FREQUENCY_TYPE,	FREQUENCY_REPEAT_EVERY,	FREQUENCY_DAY_OF_MONTH,	CREATION_DATE,	BILLABLE_WHEN_CLIENT_ON_HOLD,	BUDGET_PREMIUM_ITEM_ID,	BUDGET_ITEM_ID,	BUDGET_ITEM_CATEGORY,	
PROPERTIES_PREMIUM_BUDGET,	
PROPERTIES_GUID_PREMIUM[''Op'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_OP,
PROPERTIES_GUID_PREMIUM[''apply_date'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_APPLY_DATE,
PROPERTIES_GUID_PREMIUM[''create_time'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_CREATE_TIME,
PROPERTIES_GUID_PREMIUM[''create_user_id'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_CREATE_USER_ID,
PROPERTIES_GUID_PREMIUM[''description'']::VARCHAR(450) AS PROPERTIES_GUID_PREMIUM_DESCRIPTION ,
PROPERTIES_GUID_PREMIUM[''guid'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_GUID,
PROPERTIES_GUID_PREMIUM[''guid_to'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_GUID_TO ,
PROPERTIES_GUID_PREMIUM[''idmasteraccount'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_IDMASTERACCOUNT,
PROPERTIES_GUID_PREMIUM[''premium_id'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_PREMIUM_ID ,
PROPERTIES_GUID_PREMIUM[''quantity'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_QUINTITY,
PROPERTIES_GUID_PREMIUM[''rate'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_RATE,
PROPERTIES_GUID_PREMIUM[''update_time'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_UPDATE_TIME,
PROPERTIES_GUID_PREMIUM[''update_user_id'']::VARCHAR(35) AS PROPERTIES_GUID_PREMIUM_UPDATE_USER_ID,
PROPERTIES_PREMIUM_RULE[''Op'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_OP,
PROPERTIES_PREMIUM_RULE[''create_time'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_CREATION_DATE,
PROPERTIES_PREMIUM_RULE[''description'']::VARCHAR(450) AS PROPERTIES_PREMIUM_RULE_DESCRIPTION,
PROPERTIES_PREMIUM_RULE[''disabled'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_DISABLED,
PROPERTIES_PREMIUM_RULE[''duration'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_DURATION,
PROPERTIES_PREMIUM_RULE[''end_at'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_END_AT,
PROPERTIES_PREMIUM_RULE[''guid'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_GUID,
PROPERTIES_PREMIUM_RULE[''guid_to'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_GUID_TO,
PROPERTIES_PREMIUM_RULE[''id'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_ID,
PROPERTIES_PREMIUM_RULE[''idmasteraccount'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_IDMASTERACCOUNT,
PROPERTIES_PREMIUM_RULE[''rrule'']::VARCHAR(450) AS PROPERTIES_PREMIUM_RULE_RRULE,
PROPERTIES_PREMIUM_RULE[''start_at'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_START_AT,
PROPERTIES_PREMIUM_RULE[''type'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_TYPE,
PROPERTIES_PREMIUM_RULE[''update_time'']::VARCHAR(35) AS PROPERTIES_PREMIUM_RULE_UPDATE_TIME,
BILLITEM_ID_PREMIUM,	BILLITEM_ID_FUNDER_ID
FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_GUID_PREMIUM;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';