resource "snowflake_procedure" "DISC_SANDATAIMPORT_GET_SANDATA_STAFFS" {
	name ="GET_SANDATA_STAFFS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SandataImport.GET_Sandata_Staffs 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_Staffs FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS staffID, t.$4 AS StaffAgencyID, t.$5 AS Status, t.$6 AS Status2, t.$7 AS SOE, t.$8 AS EOE, t.$9 AS RehireDate, t.$10 AS Position, t.$11 AS OfficeStaff, t.$12 AS FieldStaff, t.$13 AS Person, t.$14 AS Contractor, t.$15 AS Title, t.$16 AS FirstName, t.$17 AS MiddleInitial, t.$18 AS LastName, t.$19 AS Suffix, t.$20 AS Ethnicity, t.$21 AS Income, t.$22 AS Language, t.$23 AS Marital, t.$24 AS Sex, t.$25 AS SSN, t.$26 AS DOB, t.$27 AS DOD, t.$28 AS Address, t.$29 AS Address2, t.$30 AS AptNo, t.$31 AS County, t.$32 AS City, t.$33 AS State, t.$34 AS Zip, t.$35 AS HomePhone, t.$36 AS WorkPhone, t.$37 AS MobilePhone, t.$38 AS Fax, t.$39 AS Email, t.$40 AS API, t.$41 AS NPI, t.$42 AS OtherID1, t.$43 AS OtherID2, t.$44 AS Class, t.$45 AS MilitaryStatus, t.$46 AS Transportation, t.$47 AS Compliant, t.$48 AS CompliantThru, t.$49 AS HomeLocation, t.$50 AS IsManager, t.$51 AS IsCoordinator, t.$52 AS Coordinator, t.$53 AS Manager, t.$54 AS CreatedAt, t.$55 AS UpdatedAt, t.$56 AS HashedRowValues, t.$57 AS BatchId, t.$58 AS REFERRAL,t.$59 AS SYS_CHANGE_VERSION, t.$60 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$60,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_Staffs.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_Staffs AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_Staffs GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_Staffs t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

