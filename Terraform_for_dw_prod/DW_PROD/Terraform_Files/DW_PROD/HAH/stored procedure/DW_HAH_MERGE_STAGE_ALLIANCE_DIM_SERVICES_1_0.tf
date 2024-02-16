resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_ALLIANCE_DIM_SERVICES_1_0" {
	name ="MERGE_STAGE_ALLIANCE_DIM_SERVICES_1_0"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE result_string STRING;
BEGIN
	MERGE INTO HAH.DIM_SERVICES_1_0 TGT
	USING STAGE.ALLIANCE_DIM_SERVICES_1_0 STAGE
	ON TGT.SERVICE_KEY=STAGE.SERVICE_KEY
	WHEN MATCHED THEN
	UPDATE SET
	TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
	,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
	,TGT.SERVICE_CODE_ID= STAGE.SERVICE_CODE_ID
	,TGT.NAME= STAGE.NAME
	,TGT.BILL_CODE_ID= STAGE.BILL_CODE_ID
	,TGT.IS_EXPENSE= STAGE.IS_EXPENSE
	,TGT.IS_MULTIPLE= STAGE.IS_MULTIPLE
	,TGT.OTHER_CODE= STAGE.OTHER_CODE
	,TGT.DEFAULT_COST= STAGE.DEFAULT_COST
	,TGT.DEFAULT_PAY_UNIT_FLAG= STAGE.DEFAULT_PAY_UNIT_FLAG
	,TGT.DEFAULT_BILL_UNIT_FLAG= STAGE.DEFAULT_BILL_UNIT_FLAG
	,TGT.CATEGORY_ID= STAGE.CATEGORY_ID
	,TGT.PAYROLL_CODE= STAGE.PAYROLL_CODE
	,TGT.DEFAULT_REIMBURSMENT= STAGE.DEFAULT_REIMBURSMENT
	,TGT.WC= STAGE.WC
	,TGT.SHIFT_PAY= STAGE.SHIFT_PAY
	,TGT.OT_PAY= STAGE.OT_PAY
	,TGT.BILL_EXCLUDE_HOLIDAY= STAGE.BILL_EXCLUDE_HOLIDAY
	,TGT.PAY_EXCLUDED_HOLIDAY= STAGE.PAY_EXCLUDED_HOLIDAY
	,TGT.IS_CAT= STAGE.IS_CAT
	,TGT.COMMISSION_RATE= STAGE.COMMISSION_RATE
	,TGT.BONUS_POINTS= STAGE.BONUS_POINTS
	,TGT.ACTIVE= STAGE.ACTIVE
	,TGT.REVENUE_CODE= STAGE.REVENUE_CODE
	,TGT.PAY= STAGE.PAY
	,TGT.POC_FIRST_BIL_LABLE_FLAG= STAGE.POC_FIRST_BIL_LABLE_FLAG
	,TGT.EXPENCE_TYPE_ID= STAGE.EXPENCE_TYPE_ID
	,TGT.CREATED_DATE= STAGE.CREATED_DATE
	,TGT.CREATED_USER= STAGE.CREATED_USER
	,TGT.MODIFIED_DATE= STAGE.MODIFIED_DATE
	,TGT.MODIFIED_USER= STAGE.MODIFIED_USER
	,TGT.TS= STAGE.TS
	,TGT.LIST_ITEM_TYPE= STAGE.LIST_ITEM_TYPE
	,TGT.RPT_GROUP_ID= STAGE.RPT_GROUP_ID
	,TGT.BRANCH_ID= STAGE.BRANCH_ID
	,TGT.OVERRIDE_ID= STAGE.OVERRIDE_ID
	,TGT.DESCRIPTION= STAGE.DESCRIPTION
	,TGT.TAX_GROUP_ID= STAGE.TAX_GROUP_ID
	,TGT.LEGACY_ID= STAGE.LEGACY_ID
	,TGT.LEGACY_BRANCH_ID= STAGE.LEGACY_BRANCH_ID
	,TGT.ACCT_ID= STAGE.ACCT_ID
	,TGT.UPLOAD_TELEPHONY= STAGE.UPLOAD_TELEPHONY
	,TGT.TELEPHONY_TASK_ID= STAGE.TELEPHONY_TASK_ID
	,TGT.INCLUDE_EFT= STAGE.INCLUDE_EFT
	,TGT.PROJECTED_AVG_BILL_VISIT= STAGE.PROJECTED_AVG_BILL_VISIT
	,TGT.PROJECTED_AVG_PAY_VISIT= STAGE.PROJECTED_AVG_PAY_VISIT
	,TGT.PROJECTED_AVG_PAY_HOURLY= STAGE.PROJECTED_AVG_PAY_HOURLY
	,TGT.PROJECTED_AVG_BILL_HOURLY= STAGE.PROJECTED_AVG_BILL_HOURLY
	,TGT.IS_COPY= STAGE.IS_COPY
	,TGT.IS_WORKING= STAGE.IS_WORKING
	,TGT.DEDUCTE_ARN= STAGE.DEDUCTE_ARN
	,TGT.LIVE_IN_RPT_HRS= STAGE.LIVE_IN_RPT_HRS
	,TGT.ACCT_CODE= STAGE.ACCT_CODE
	,TGT.DISPLAY_ON_CLIENT_PORTAL= STAGE.DISPLAY_ON_CLIENT_PORTAL
	,TGT.DISPLAY_ON_CAREGIVER_PORTAL= STAGE.DISPLAY_ON_CAREGIVER_PORTAL
	,TGT.THERAPY_COUNTING_TYPE= STAGE.THERAPY_COUNTING_TYPE
	,TGT.MEDICARE_DISCIPLINE= STAGE.MEDICARE_DISCIPLINE
	,TGT.DOC_TYPE= STAGE.DOC_TYPE
	,TGT.IS_MULTIPLE_SERVICE= STAGE.IS_MULTIPLE_SERVICE
	,TGT.INSERT_DATE= STAGE.INSERT_DATE
	,TGT.UPDATE_DATE= STAGE.UPDATE_DATE
	,TGT.DELETED_FLAG= STAGE.DELETED_FLAG
	,TGT.SYS_CHANGE_VERSION= STAGE.SYS_CHANGE_VERSION
	,TGT.SYS_CHANGE_OPERATION= STAGE.SYS_CHANGE_OPERATION
	,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
	,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
	,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
	,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
	,TGT.ETL_INFERRED_MEMBER_FLAG= STAGE.ETL_INFERRED_MEMBER_FLAG
	
	WHEN NOT MATCHED THEN
	INSERT (
	SERVICE_KEY
	,SYSTEM_CODE
	,SOURCE_SYSTEM_ID
	,SERVICE_CODE_ID
	,NAME
	,BILL_CODE_ID
	,IS_EXPENSE
	,IS_MULTIPLE
	,OTHER_CODE
	,DEFAULT_COST
	,DEFAULT_PAY_UNIT_FLAG
	,DEFAULT_BILL_UNIT_FLAG
	,CATEGORY_ID
	,PAYROLL_CODE
	,DEFAULT_REIMBURSMENT
	,WC
	,SHIFT_PAY
	,OT_PAY
	,BILL_EXCLUDE_HOLIDAY
	,PAY_EXCLUDED_HOLIDAY
	,IS_CAT
	,COMMISSION_RATE
	,BONUS_POINTS
	,ACTIVE
	,REVENUE_CODE
	,PAY
	,POC_FIRST_BIL_LABLE_FLAG
	,EXPENCE_TYPE_ID
	,CREATED_DATE
	,CREATED_USER
	,MODIFIED_DATE
	,MODIFIED_USER
	,TS
	,LIST_ITEM_TYPE
	,RPT_GROUP_ID
	,BRANCH_ID
	,OVERRIDE_ID
	,DESCRIPTION
	,TAX_GROUP_ID
	,LEGACY_ID
	,LEGACY_BRANCH_ID
	,ACCT_ID
	,UPLOAD_TELEPHONY
	,TELEPHONY_TASK_ID
	,INCLUDE_EFT
	,PROJECTED_AVG_BILL_VISIT
	,PROJECTED_AVG_PAY_VISIT
	,PROJECTED_AVG_PAY_HOURLY
	,PROJECTED_AVG_BILL_HOURLY
	,IS_COPY
	,IS_WORKING
	,DEDUCTE_ARN
	,LIVE_IN_RPT_HRS
	,ACCT_CODE
	,DISPLAY_ON_CLIENT_PORTAL
	,DISPLAY_ON_CAREGIVER_PORTAL
	,THERAPY_COUNTING_TYPE
	,MEDICARE_DISCIPLINE
	,DOC_TYPE
	,IS_MULTIPLE_SERVICE
	,INSERT_DATE
	,UPDATE_DATE
	,DELETED_FLAG
	,SYS_CHANGE_VERSION
	,SYS_CHANGE_OPERATION
	,ETL_TASK_KEY
	,ETL_INSERTED_TASK_KEY
	,ETL_INSERTED_DATE
	,ETL_INSERTED_BY
	,ETL_LAST_UPDATED_DATE
	,ETL_LAST_UPDATED_BY
	,ETL_DELETED_FLAG
	,ETL_INFERRED_MEMBER_FLAG
	)
		VALUES (
	STAGE.SERVICE_KEY
	,STAGE.SYSTEM_CODE
	,STAGE.SOURCE_SYSTEM_ID
	,STAGE.SERVICE_CODE_ID
	,STAGE.NAME
	,STAGE.BILL_CODE_ID
	,STAGE.IS_EXPENSE
	,STAGE.IS_MULTIPLE
	,STAGE.OTHER_CODE
	,STAGE.DEFAULT_COST
	,STAGE.DEFAULT_PAY_UNIT_FLAG
	,STAGE.DEFAULT_BILL_UNIT_FLAG
	,STAGE.CATEGORY_ID
	,STAGE.PAYROLL_CODE
	,STAGE.DEFAULT_REIMBURSMENT
	,STAGE.WC
	,STAGE.SHIFT_PAY
	,STAGE.OT_PAY
	,STAGE.BILL_EXCLUDE_HOLIDAY
	,STAGE.PAY_EXCLUDED_HOLIDAY
	,STAGE.IS_CAT
	,STAGE.COMMISSION_RATE
	,STAGE.BONUS_POINTS
	,STAGE.ACTIVE
	,STAGE.REVENUE_CODE
	,STAGE.PAY
	,STAGE.POC_FIRST_BIL_LABLE_FLAG
	,STAGE.EXPENCE_TYPE_ID
	,STAGE.CREATED_DATE
	,STAGE.CREATED_USER
	,STAGE.MODIFIED_DATE
	,STAGE.MODIFIED_USER
	,STAGE.TS
	,STAGE.LIST_ITEM_TYPE
	,STAGE.RPT_GROUP_ID
	,STAGE.BRANCH_ID
	,STAGE.OVERRIDE_ID
	,STAGE.DESCRIPTION
	,STAGE.TAX_GROUP_ID
	,STAGE.LEGACY_ID
	,STAGE.LEGACY_BRANCH_ID
	,STAGE.ACCT_ID
	,STAGE.UPLOAD_TELEPHONY
	,STAGE.TELEPHONY_TASK_ID
	,STAGE.INCLUDE_EFT
	,STAGE.PROJECTED_AVG_BILL_VISIT
	,STAGE.PROJECTED_AVG_PAY_VISIT
	,STAGE.PROJECTED_AVG_PAY_HOURLY
	,STAGE.PROJECTED_AVG_BILL_HOURLY
	,STAGE.IS_COPY
	,STAGE.IS_WORKING
	,STAGE.DEDUCTE_ARN
	,STAGE.LIVE_IN_RPT_HRS
	,STAGE.ACCT_CODE
	,STAGE.DISPLAY_ON_CLIENT_PORTAL
	,STAGE.DISPLAY_ON_CAREGIVER_PORTAL
	,STAGE.THERAPY_COUNTING_TYPE
	,STAGE.MEDICARE_DISCIPLINE
	,STAGE.DOC_TYPE
	,STAGE.IS_MULTIPLE_SERVICE
	,STAGE.INSERT_DATE
	,STAGE.UPDATE_DATE
	,STAGE.DELETED_FLAG
	,STAGE.SYS_CHANGE_VERSION
	,STAGE.SYS_CHANGE_OPERATION
	,STAGE.ETL_TASK_KEY
	,STAGE.ETL_INSERTED_TASK_KEY
	,STAGE.ETL_INSERTED_DATE
	,STAGE.ETL_INSERTED_BY
	,STAGE.ETL_LAST_UPDATED_DATE
	,STAGE.ETL_LAST_UPDATED_BY
	,STAGE.ETL_DELETED_FLAG
	,STAGE.ETL_INFERRED_MEMBER_FLAG
	);
SELECT CONCAT(''{ "Inserted": '', "number of rows inserted", '', "Updated": '', "number of rows updated", '' }'') INTO :result_string 
FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN result_string;
END

 EOT
}

