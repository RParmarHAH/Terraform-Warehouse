resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_HH_BRANCHINFO" {
	name ="GET_AXXESS_HH_BRANCHINFO"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_HH_BranchInfo 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                		NOTES:
-- ----------  		-------------------   		-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            		Initial Development
-- 2023-12-15 		EDumpala/RSuthar     		Added logic for incremental load   
--*****************************************************************************************************************************
BEGIN 
    --TargetSQL
    MERGE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.HIST_AXXESS_HH_BRANCHINFO TARGET USING (SELECT A.$1 AS Branch_Id, A.$2 AS Create_Timestamp, A.$3 AS Update_Timestamp, A.$4 AS Name, A.$5 AS Tax_Id, A.$6 AS National_Provider_Number, A.$7 AS Medicare_Provider_Number, A.$8 AS Medicaid_Provider_Number, A.$9 AS Location_Name, A.$10 AS Location_Address_Line1, A.$11 AS Location_Address_Line2, A.$12 AS Location_Address_City_Name, A.$13 AS Location_Address_State_Code, A.$14 AS Location_Address_Zip_Code, A.$15 AS Primary_Phone_Number, A.$16 AS Fax_Number, A.$17 AS Agency_Id, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HH_BRANCHINFO(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A) SOURCE
	ON EQUAL_NULL(TARGET.Branch_Id , SOURCE.Branch_Id) OR EQUAL_NULL(TARGET.Create_Timestamp , SOURCE.Create_Timestamp) OR EQUAL_NULL(TARGET.Update_Timestamp , SOURCE.Update_Timestamp) OR EQUAL_NULL(TARGET.Name , SOURCE.Name) OR EQUAL_NULL(TARGET.Tax_Id , SOURCE.Tax_Id) OR EQUAL_NULL(TARGET.National_Provider_Number , SOURCE.National_Provider_Number) OR EQUAL_NULL(TARGET.Location_Name , SOURCE.Location_Name) OR EQUAL_NULL(TARGET.Location_Address_Line1 , SOURCE.Location_Address_Line1) OR EQUAL_NULL(TARGET.Location_Address_Line2 , SOURCE.Location_Address_Line2) OR EQUAL_NULL(TARGET.Location_Address_City_Name , SOURCE.Location_Address_City_Name) OR EQUAL_NULL(TARGET.Location_Address_State_Code , SOURCE.Location_Address_State_Code) OR EQUAL_NULL(TARGET.Location_Address_Zip_Code , SOURCE.Location_Address_Zip_Code) OR EQUAL_NULL(TARGET.Primary_Phone_Number , SOURCE.Primary_Phone_Number) OR EQUAL_NULL(TARGET.Fax_Number , SOURCE.Fax_Number) OR EQUAL_NULL(TARGET.Agency_Id , SOURCE.Agency_Id) OR EQUAL_NULL(TARGET.ETL_TASK_KEY , SOURCE.ETL_TASK_KEY) OR EQUAL_NULL(TARGET.ETL_INSERTED_DATE , SOURCE.ETL_INSERTED_DATE) OR EQUAL_NULL(TARGET.ETL_INSERTED_BY , SOURCE.ETL_INSERTED_BY) OR EQUAL_NULL(TARGET.ETL_LAST_UPDATED_DATE , SOURCE.ETL_LAST_UPDATED_DATE) OR EQUAL_NULL(TARGET.ETL_LAST_UPDATED_BY , SOURCE.ETL_LAST_UPDATED_BY) OR EQUAL_NULL(TARGET.ETL_DELETED_FLAG , SOURCE.ETL_DELETED_FLAG)  
WHEN NOT MATCHED THEN
        INSERT (
	BRANCH_ID ,
	CREATE_TIMESTAMP ,
	UPDATE_TIMESTAMP ,
	NAME ,
	TAX_ID ,
	NATIONAL_PROVIDER_NUMBER ,
	MEDICARE_PROVIDER_NUMBER ,
	MEDICAID_PROVIDER_NUMBER ,
	LOCATION_NAME ,
	LOCATION_ADDRESS_LINE1  ,
	LOCATION_ADDRESS_LINE2 ,
	LOCATION_ADDRESS_CITY_NAME ,
	LOCATION_ADDRESS_STATE_CODE ,
	LOCATION_ADDRESS_ZIP_CODE ,
	PRIMARY_PHONE_NUMBER ,
	FAX_NUMBER ,
	AGENCY_ID ,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY ,
	ETL_INSERTED_DATE ,
	ETL_INSERTED_BY ,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
	) VALUES (
	SOURCE.BRANCH_ID ,
	SOURCE.CREATE_TIMESTAMP ,
	SOURCE.UPDATE_TIMESTAMP ,
	SOURCE.NAME ,
	SOURCE.TAX_ID ,
	SOURCE.NATIONAL_PROVIDER_NUMBER ,
	SOURCE.MEDICARE_PROVIDER_NUMBER ,
	SOURCE.MEDICAID_PROVIDER_NUMBER ,
	SOURCE.LOCATION_NAME ,
	SOURCE.LOCATION_ADDRESS_LINE1  ,
	SOURCE.LOCATION_ADDRESS_LINE2 ,
	SOURCE.LOCATION_ADDRESS_CITY_NAME ,
	SOURCE.LOCATION_ADDRESS_STATE_CODE ,
	SOURCE.LOCATION_ADDRESS_ZIP_CODE ,
	SOURCE.PRIMARY_PHONE_NUMBER ,
	SOURCE.FAX_NUMBER ,
	SOURCE.AGENCY_ID ,
	SOURCE.ETL_TASK_KEY,
	SOURCE.ETL_INSERTED_TASK_KEY ,
	SOURCE.ETL_INSERTED_DATE ,
	SOURCE.ETL_INSERTED_BY ,
	SOURCE.ETL_LAST_UPDATED_DATE,
	SOURCE.ETL_LAST_UPDATED_BY,
	SOURCE.ETL_DELETED_FLAG
	);
	
	UPDATE DISC_${var.SF_ENVIRONMENT}.AXXESS.HIST_AXXESS_HH_BRANCHINFO SET
	ETL_DELETED_FLAG=TRUE, ETL_LAST_UPDATED_DATE=CURRENT_TIMESTAMP(),ETL_LAST_UPDATED_BY=CURRENT_USER()
	WHERE Branch_Id NOT IN (SELECT A.$1 FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HH_BRANCHINFO(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);
	
	CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HH_BRANCHINFO AS SELECT * FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.HIST_AXXESS_HH_BRANCHINFO WHERE 
   ETL_DELETED_FLAG=FALSE AND (Branch_Id,ETL_INSERTED_DATE) IN (SELECT Branch_Id,MAX(ETL_INSERTED_DATE)FROM 
   DISC_${var.SF_ENVIRONMENT}.AXXESS.HIST_AXXESS_HH_BRANCHINFO GROUP BY Branch_Id);
    
END;

 EOT
}

