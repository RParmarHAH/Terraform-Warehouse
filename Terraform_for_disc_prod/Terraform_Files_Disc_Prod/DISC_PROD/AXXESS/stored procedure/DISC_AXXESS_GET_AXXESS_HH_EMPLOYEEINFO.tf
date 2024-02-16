resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_HH_EMPLOYEEINFO" {
	name ="GET_AXXESS_HH_EMPLOYEEINFO"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_HH_EMPLOYEEINFO 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-12-11 		Ravi Suthar            	Initial Development
-- 2023-12-15 		EDumpala/RSuthar     	Added logic for incremental load   
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.HIST_AXXESS_HH_EMPLOYEEINFO (SELECT A.$1 AS System_Employee_Id, A.$2 AS Create_Timestamp, A.$3 AS Update_Timestamp, A.$4 AS Active_Status, A.$5 AS User_Email, A.$6 AS Hire_Date, A.$7 AS Termination_Date, A.$8 AS First_Name, A.$9 AS Middle_Name, A.$10 AS Last_Name, A.$11 AS SSN, A.$12 AS Date_Of_Birth, A.$13 AS Employee_Id, A.$14 AS Address_Line_1, A.$15 AS Address_Line_2, A.$16 AS Address_City, A.$17 AS Address_ZipCode, A.$18 AS Address_StateCode, A.$19 AS Primary_Phone_Type, A.$20 AS Primary_Phone_Number, A.$21 AS Gender, A.$22 AS Employment_Type, A.$23 AS Credentials, A.$24 AS Title_Type, A.$25 AS Is_Case_Manager, A.$26 AS Comments, A.$27 AS Account_Id, A.$28 AS Account_Name, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/AXXESS_HH_EMPLOYEEINFO(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HH_EMPLOYEEINFO
 AS WITH curr_v AS 
 (SELECT System_Employee_Id, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE 
 FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.HIST_AXXESS_HH_EMPLOYEEINFO GROUP BY System_Employee_Id )   
 SELECT P.* exclude ETL_DELETED_FLAG,
 CASE WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE ELSE P.ETL_DELETED_FLAG END AS ETL_DELETED_FLAG 
 FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.HIST_AXXESS_HH_EMPLOYEEINFO P 
 INNER JOIN curr_v v ON P.System_Employee_Id = v.System_Employee_Id
 AND P.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;


----REPLACE HIST TABLE WITH CURRENT TABLE 
create OR REPLACE table DISC_${var.SF_ENVIRONMENT}.AXXESS.HIST_AXXESS_HH_EMPLOYEEINFO CLONE DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HH_EMPLOYEEINFO;
 
END;

 EOT
}

