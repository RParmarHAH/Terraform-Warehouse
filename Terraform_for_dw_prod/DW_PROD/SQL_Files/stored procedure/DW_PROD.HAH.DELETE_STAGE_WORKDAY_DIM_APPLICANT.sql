CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_WORKDAY_DIM_APPLICANT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
-------------------------------------------------------------------------------------------------------------------------------
/*
Object Type : 	Procedure
Object Name	: 	DELETE_STAGE_WORKDAY_DIM_APPLICANT
Author		:	Abhishek Sunil
Description :
	- This particular object is incremental load
	- This procedure deletes the applicants that are not supposed to in business layer
	  (Workers who never were an applicant)
*/

--*****************************************************************************************************************************
-- CHANGE LOG :
-- Version	Date(MM/DD/YYYY)	Author				Change Description
-- --------	----------------   	------------------	---------------------------------------------------------------------------
-- 1.0		10/03/2023    		Abhishek Sunil		Initial Development
-- 1.1		10/23/2023			Abhishek Sunil		Added condition to delete workers who are marked as duplicates
-- 1.2      10/30/2023          Jainam Shah         Logic added for excluding the employees in rescinded list
-------------------------------------------------------------------------------------------------------------------------------	

DECLARE
	return_result varchar(1000);
BEGIN
	DELETE FROM
		DW_PROD.HAH.DIM_APPLICANT
	WHERE
		SOURCE_SYSTEM_ID = 36
		AND (APPLICANT_ID NOT IN (
		SELECT
			DISTINCT EM.EMPLOYEE_ID
		FROM
			DISC_PROD.WORKDAY.WORKER_SUMMARY EM
		LEFT JOIN 
			DISC_PROD.WORKDAY.WORKER_ADDITIONAL_INFORMATION ADINFO
			ON EM.EMPLOYEE_ID = ADINFO.EMPLOYEE_ID
		LEFT JOIN
		(
			SELECT
				DISTINCT EMPLOYEE_ID
			FROM
				DISC_PROD.WORKDAY.HIST_WORKER_ADDITIONAL_INFORMATION AD
			WHERE
				(TRIM(AD.PRE_BOARDING_COMPLETION)::BOOLEAN = 0 OR 
				TRIM(AD.PRE_BOARDING_COMPLETION)::BOOLEAN IS NULL)
		) APP
		ON APP.EMPLOYEE_ID = EM.EMPLOYEE_ID
		LEFT JOIN
			DISC_PROD.WORKDAY.WORKER_STATUS ST
			ON ST.EMPLOYEE_ID = EM.EMPLOYEE_ID
		WHERE
			(APP.EMPLOYEE_ID IS NOT NULL -- ALL APPLICANTS Historically
				OR ADINFO.EMPLOYEE_ID IS NULL) -- All workers who don''t have a additional info (Future hires)
			AND TRIM(ST.PRIMARY_TERMINATION_REASON) IS DISTINCT FROM (''Terminate Employee > Reject > Duplicate Employee Record''))
			OR APPLICANT_ID  IN (SELECT "CFI INT005 Worker ID LRV" FROM DISC_PROD.WORKDAY.WORKER_EXCLUDE_LIST));

  SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
  return return_result;
 
END;
';