resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_WORKDAY_FACT_APPLICANT_STATUS" {
	name ="DELETE_STAGE_WORKDAY_FACT_APPLICANT_STATUS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

-------------------------------------------------------------------------------------------------------------------------------
/*
Object Type : 	Procedure
Object Name	: 	DELETE_STAGE_WORKDAY_FACT_APPLICANT_STATUS
Author		:	Harshala Kadam
Description :
	
	- This procedure deletes the applicants that are not supposed to in business layer
	  (Workers who never were an applicant)
*/

--*****************************************************************************************************************************
-- CHANGE LOG :
-- Version	Date(MM/DD/YYYY)	Author				Change Description
-- --------	----------------   	------------------	---------------------------------------------------------------------------
-- 1.0		10/20/2023    		Harshala Kadam		Initial Development
-------------------------------------------------------------------------------------------------------------------------------	

DECLARE
	return_result varchar(1000);
BEGIN
	DELETE FROM
		DW_${var.SF_ENVIRONMENT}.HAH.FACT_APPLICANT_STATUS
	WHERE
		SOURCE_SYSTEM_ID = 36
		AND CANDIDATE_ID NOT IN (
		SELECT
			DISTINCT EM.EMPLOYEE_ID
		FROM
			DISC_${var.SF_ENVIRONMENT}.WORKDAY.WORKER_SUMMARY EM
		LEFT JOIN 
			DISC_${var.SF_ENVIRONMENT}.WORKDAY.WORKER_ADDITIONAL_INFORMATION ADINFO
			ON EM.EMPLOYEE_ID = ADINFO.EMPLOYEE_ID
		LEFT JOIN
		(
			SELECT
				DISTINCT EMPLOYEE_ID
			FROM
				DISC_${var.SF_ENVIRONMENT}.WORKDAY.HIST_WORKER_ADDITIONAL_INFORMATION AD
			WHERE
				(TRIM(AD.PRE_BOARDING_COMPLETION)::BOOLEAN = 0 OR 
				TRIM(AD.PRE_BOARDING_COMPLETION)::BOOLEAN IS NULL)
		) APP
		ON APP.EMPLOYEE_ID = EM.EMPLOYEE_ID
		WHERE
			(APP.EMPLOYEE_ID IS NOT NULL -- ALL APPLICANTS Historically
				OR ADINFO.EMPLOYEE_ID IS NULL));-- All workers who don''t have a additional info (Future hires)

  SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
  return return_result;
 
END;

 EOT
}

