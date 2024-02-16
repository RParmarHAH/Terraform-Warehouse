resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_COSTALSYNCDATA_DIM_BRANCH" {
	name ="MERGE_STAGE_COSTALSYNCDATA_DIM_BRANCH"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN


					
    MERGE INTO HAH.DIM_BRANCH TGT 
USING STAGE.COSTALSYNCDATA_DIM_BRANCH STAGE 
ON TGT.BRANCH_KEY = STAGE.BRANCH_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.BRANCH_NAME= STAGE.BRANCH_NAME
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SOURCE_SYSTEM_TYPE= STAGE.SOURCE_SYSTEM_TYPE
   ,TGT.OFFICE_NUMBER= STAGE.OFFICE_NUMBER
   ,TGT.OFFICE_CODE= STAGE.OFFICE_CODE
   ,TGT.OFFICE_NAME= STAGE.OFFICE_NAME
   ,TGT.OFFICE_NAME_ALT= STAGE.OFFICE_NAME_ALT
   ,TGT.DEPARTMENT_NAME= STAGE.DEPARTMENT_NAME
   ,TGT.BRANCH_SERVICE_LINE= STAGE.BRANCH_SERVICE_LINE
   ,TGT.PARENT_FLAG= STAGE.PARENT_FLAG
   ,TGT.PARENT_BRANCH_KEY= STAGE.PARENT_BRANCH_KEY
   ,TGT.PARENT_OFFICE_NUMBER= STAGE.PARENT_OFFICE_NUMBER
   ,TGT.PARENT_OFFICE_CODE= STAGE.PARENT_OFFICE_CODE
   ,TGT.PARENT_BRANCH_NAME= STAGE.PARENT_BRANCH_NAME
   ,TGT.OFFICE_ADDRESS1= STAGE.OFFICE_ADDRESS1
   ,TGT.OFFICE_ADDRESS2= STAGE.OFFICE_ADDRESS2
   ,TGT.OFFICE_CITY= STAGE.OFFICE_CITY
   ,TGT.OFFICE_STATE_CODE= STAGE.OFFICE_STATE_CODE
   ,TGT.OFFICE_ZIP= STAGE.OFFICE_ZIP
   ,TGT.OFFICE_PHONE= STAGE.OFFICE_PHONE
   ,TGT.OFFICE_TOLL_FREE_PHONE= STAGE.OFFICE_TOLL_FREE_PHONE
   ,TGT.OFFICE_FAX= STAGE.OFFICE_FAX
   ,TGT.DETAILED_OFFICE_NAME= STAGE.DETAILED_OFFICE_NAME
   ,TGT.REGION_NUMBER= STAGE.REGION_NUMBER
   ,TGT.REGION_NAME= STAGE.REGION_NAME
   ,TGT.REGION_MANAGER= STAGE.REGION_MANAGER
   ,TGT.REGION_MANAGER_EMPLOYEE_KEY= STAGE.REGION_MANAGER_EMPLOYEE_KEY
   ,TGT.SUBREGION_NAME= STAGE.SUBREGION_NAME
   ,TGT.PRIMARY_BRANCH_MANAGER_NAME= STAGE.PRIMARY_BRANCH_MANAGER_NAME
   ,TGT.PRIMARY_BRANCH_EMAIL= STAGE.PRIMARY_BRANCH_EMAIL
   ,TGT.PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY= STAGE.PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY
   ,TGT.SECONDARY_BRANCH_MANAGER_NAME= STAGE.SECONDARY_BRANCH_MANAGER_NAME
   ,TGT.SECONDARY_BRANCH_EMAIL= STAGE.SECONDARY_BRANCH_EMAIL
   ,TGT.SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY= STAGE.SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY
   ,TGT.RISKCONNECT_NODE_KEY= STAGE.RISKCONNECT_NODE_KEY
   ,TGT.RISKCONNECT_NAME= STAGE.RISKCONNECT_NAME
   ,TGT.HR_OFFICE_NUMBER= STAGE.HR_OFFICE_NUMBER
   ,TGT.HR_OFFICE_NAME= STAGE.HR_OFFICE_NAME
   ,TGT.ACTIVE_FLAG= STAGE.ACTIVE_FLAG
   ,TGT.EFFECTIVE_FROM_DATE= STAGE.EFFECTIVE_FROM_DATE
   ,TGT.EFFECTIVE_TO_DATE= STAGE.EFFECTIVE_TO_DATE
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.ETL_INFERRED_MEMBER_FLAG= STAGE.ETL_INFERRED_MEMBER_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    BRANCH_KEY
   ,BRANCH_NAME
   ,SYSTEM_CODE
   ,SOURCE_SYSTEM_ID
   ,SOURCE_SYSTEM_TYPE
   ,OFFICE_NUMBER
   ,OFFICE_CODE
   ,OFFICE_NAME
   ,OFFICE_NAME_ALT
   ,DEPARTMENT_NAME
   ,BRANCH_SERVICE_LINE
   ,PARENT_FLAG
   ,PARENT_BRANCH_KEY
   ,PARENT_OFFICE_NUMBER
   ,PARENT_OFFICE_CODE
   ,PARENT_BRANCH_NAME
   ,OFFICE_ADDRESS1
   ,OFFICE_ADDRESS2
   ,OFFICE_CITY
   ,OFFICE_STATE_CODE
   ,OFFICE_ZIP
   ,OFFICE_PHONE
   ,OFFICE_TOLL_FREE_PHONE
   ,OFFICE_FAX
   ,DETAILED_OFFICE_NAME
   ,REGION_NUMBER
   ,REGION_NAME
   ,REGION_MANAGER
   ,REGION_MANAGER_EMPLOYEE_KEY
   ,SUBREGION_NAME
   ,PRIMARY_BRANCH_MANAGER_NAME
   ,PRIMARY_BRANCH_EMAIL
   ,PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY
   ,SECONDARY_BRANCH_MANAGER_NAME
   ,SECONDARY_BRANCH_EMAIL
   ,SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY
   ,RISKCONNECT_NODE_KEY
   ,RISKCONNECT_NAME
   ,HR_OFFICE_NUMBER
   ,HR_OFFICE_NAME
   ,ACTIVE_FLAG
   ,EFFECTIVE_FROM_DATE
   ,EFFECTIVE_TO_DATE
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
    STAGE.BRANCH_KEY
   ,STAGE.BRANCH_NAME
   ,STAGE.SYSTEM_CODE
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SOURCE_SYSTEM_TYPE
   ,STAGE.OFFICE_NUMBER
   ,STAGE.OFFICE_CODE
   ,STAGE.OFFICE_NAME
   ,STAGE.OFFICE_NAME_ALT
   ,STAGE.DEPARTMENT_NAME
   ,STAGE.BRANCH_SERVICE_LINE
   ,STAGE.PARENT_FLAG
   ,STAGE.PARENT_BRANCH_KEY
   ,STAGE.PARENT_OFFICE_NUMBER
   ,STAGE.PARENT_OFFICE_CODE
   ,STAGE.PARENT_BRANCH_NAME
   ,STAGE.OFFICE_ADDRESS1
   ,STAGE.OFFICE_ADDRESS2
   ,STAGE.OFFICE_CITY
   ,STAGE.OFFICE_STATE_CODE
   ,STAGE.OFFICE_ZIP
   ,STAGE.OFFICE_PHONE
   ,STAGE.OFFICE_TOLL_FREE_PHONE
   ,STAGE.OFFICE_FAX
   ,STAGE.DETAILED_OFFICE_NAME
   ,STAGE.REGION_NUMBER
   ,STAGE.REGION_NAME
   ,STAGE.REGION_MANAGER
   ,STAGE.REGION_MANAGER_EMPLOYEE_KEY
   ,STAGE.SUBREGION_NAME
   ,STAGE.PRIMARY_BRANCH_MANAGER_NAME
   ,STAGE.PRIMARY_BRANCH_EMAIL
   ,STAGE.PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY
   ,STAGE.SECONDARY_BRANCH_MANAGER_NAME
   ,STAGE.SECONDARY_BRANCH_EMAIL
   ,STAGE.SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY
   ,STAGE.RISKCONNECT_NODE_KEY
   ,STAGE.RISKCONNECT_NAME
   ,STAGE.HR_OFFICE_NUMBER
   ,STAGE.HR_OFFICE_NAME
   ,STAGE.ACTIVE_FLAG
   ,STAGE.EFFECTIVE_FROM_DATE
   ,STAGE.EFFECTIVE_TO_DATE
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
   ,STAGE.ETL_INFERRED_MEMBER_FLAG
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	  
															   
							 
			   
																	   
														
															   
							 
					
																																																	 
 
return return_result;
END;
    
 EOT
}

