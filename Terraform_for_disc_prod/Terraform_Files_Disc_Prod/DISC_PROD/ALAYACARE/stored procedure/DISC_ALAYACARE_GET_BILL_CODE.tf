resource "snowflake_procedure" "DISC_ALAYACARE_GET_BILL_CODE" {
	name ="GET_BILL_CODE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_BILL_CODE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.BILL_CODE (
        BILL_CODE_ID, CODE, DESCRIPTION, BRANCH_ID, UNITPRICE, UNITS, TAXABLE, FUNDER_ID, IS_INTERNAL, BILL_USING, IS_DISABLED, DISABLED_AT, DISABLED_BY, CREATED_AT, CREATED_BY, UPDATED_AT, UPDATED_BY, 
		PROPERTIES_OP, PROPERTIES_ACTIVE, PROPERTIES_BILL_USING, PROPERTIES_BILLING_INCREMENT, PROPERTIES_CODE, PROPERTIES_DESCRIPTION, PROPERTIES_EXTERNAL_ID, PROPERTIES_GL_ASSET_ACC_ACCOUNT_ID, PROPERTIES_GL_REVENUE_ACC_ACCOUNT_ID, PROPERTIES_GUID, PROPERTIES_ID, PROPERTIES_IDFUNDER, PROPERTIES_IDMASTERACCOUNT, PROPERTIES_INCOMEACCOUNTREF, PROPERTIES_IS_DISABLED, PROPERTIES_IS_INTERNAL, PROPERTIES_IS_SERVICE_CODE_DEFAULT_FOR_FUNDER, PROPERTIES_LOCATION_INDICATOR, PROPERTIES_REVENUE_CODE, PROPERTIES_REVENUE_CODE_DESCRIPTION, PROPERTIES_TAXABLE, PROPERTIES_TYPE, PROPERTIES_UNITPRICE, PROPERTIES_UNITS, 
		GL_ASSET_ACC_ACCOUNT_CODE, GL_ASSET_ACC_ACCOUNT_NAME, GL_REVENUE_ACC_ACCOUNT_CODE, GL_REVENUE_ACC_ACCOUNT_NAME, EXCLUDE_BILLING, LOCATION_INDICATOR, BILLITEM_TAX_NAME, BILLITEM_TAX_PERCENT, TOTAL_TAX, BILLITEM_TAXABLE)
        SELECT BILL_CODE_ID AS BILL_CODE_ID, CODE AS CODE, DESCRIPTION AS DESCRIPTION, BRANCH_ID AS BRANCH_ID, UNITPRICE AS UNITPRICE, UNITS AS UNITS, TAXABLE AS TAXABLE, FUNDER_ID AS FUNDER_ID, IS_INTERNAL AS IS_INTERNAL, BILL_USING AS BILL_USING, IS_DISABLED AS IS_DISABLED, DISABLED_AT AS DISABLED_AT, DISABLED_BY AS DISABLED_BY, CREATED_AT AS CREATED_AT, CREATED_BY AS CREATED_BY, UPDATED_AT AS UPDATED_AT, UPDATED_BY AS UPDATED_BY, 
			PROPERTIES:Op::STRING AS PROPERTIES_OP, PROPERTIES:active::STRING AS PROPERTIES_ACTIVE, PROPERTIES:bill_using::STRING AS PROPERTIES_BILL_USING, PROPERTIES:billing_increment::STRING AS PROPERTIES_BILLING_INCREMENT, PROPERTIES:code::STRING AS PROPERTIES_CODE, PROPERTIES:description::STRING AS PROPERTIES_DESCRIPTION, PROPERTIES:external_id::STRING AS PROPERTIES_EXTERNAL_ID, PROPERTIES:gl_asset_acc_account_id::STRING AS PROPERTIES_GL_ASSET_ACC_ACCOUNT_ID, PROPERTIES:gl_revenue_acc_account_id::STRING AS PROPERTIES_GL_REVENUE_ACC_ACCOUNT_ID, PROPERTIES:guid::STRING AS PROPERTIES_GUID, PROPERTIES:id::STRING AS PROPERTIES_ID, PROPERTIES:idfunder::STRING AS PROPERTIES_IDFUNDER, PROPERTIES:idmasteraccount::STRING AS PROPERTIES_IDMASTERACCOUNT, PROPERTIES:incomeaccountref::STRING AS PROPERTIES_INCOMEACCOUNTREF, PROPERTIES:is_disabled::STRING AS PROPERTIES_IS_DISABLED, PROPERTIES:is_internal::STRING AS PROPERTIES_IS_INTERNAL, PROPERTIES:is_service_code_default_for_funder::STRING AS PROPERTIES_IS_SERVICE_CODE_DEFAULT_FOR_FUNDER, PROPERTIES:location_indicator::STRING AS PROPERTIES_LOCATION_INDICATOR, PROPERTIES:revenue_code::STRING AS PROPERTIES_REVENUE_CODE, PROPERTIES:revenue_code_description::STRING AS PROPERTIES_REVENUE_CODE_DESCRIPTION, PROPERTIES:taxable::STRING AS PROPERTIES_TAXABLE, PROPERTIES:type::STRING AS PROPERTIES_TYPE, PROPERTIES:unitprice::STRING AS PROPERTIES_UNITPRICE, PROPERTIES:units::STRING AS PROPERTIES_UNITS, 
			GL_ASSET_ACC_ACCOUNT_CODE AS GL_ASSET_ACC_ACCOUNT_CODE, GL_ASSET_ACC_ACCOUNT_NAME AS GL_ASSET_ACC_ACCOUNT_NAME, GL_REVENUE_ACC_ACCOUNT_CODE AS GL_REVENUE_ACC_ACCOUNT_CODE, GL_REVENUE_ACC_ACCOUNT_NAME AS GL_REVENUE_ACC_ACCOUNT_NAME, EXCLUDE_BILLING AS EXCLUDE_BILLING, LOCATION_INDICATOR AS LOCATION_INDICATOR, BILLITEM_TAX_NAME AS BILLITEM_TAX_NAME, BILLITEM_TAX_PERCENT AS BILLITEM_TAX_PERCENT, TOTAL_TAX AS TOTAL_TAX, BILLITEM_TAXABLE AS BILLITEM_TAXABLE 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_BILL_CODE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

