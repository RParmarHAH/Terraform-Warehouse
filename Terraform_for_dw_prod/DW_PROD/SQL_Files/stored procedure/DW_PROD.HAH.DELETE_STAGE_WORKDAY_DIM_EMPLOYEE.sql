CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_WORKDAY_DIM_EMPLOYEE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
-------------------------------------------------------------------------------------------------------------------------------
/*
Object Type : 	Procedure
Object Name	: 	DELETE_STAGE_WORKDAY_DIM_EMPLOYEE
Author		:	Abhishek Sunil
Description :
	- This particular object is incremental load
	- This procedure deletes the employees that are not supposed to in business layer
	  (Those who are not employees, but are applicants currently)
*/

--*****************************************************************************************************************************
-- CHANGE LOG :
-- Version	Date(MM/DD/YYYY)	Author				Change Description
-- --------	----------------   	------------------	---------------------------------------------------------------------------
-- 1.0		10/03/2023    		Abhishek Sunil		Initial Development
-- 1.1		10/10/2023    		Abhishek Sunil		Adding condition to delete any records which not in summary table
-- 1.2		10/24/2023			Naresha Bhat		Added condition to delete employees who are marked as duplicates
-- 1.3      10/30/2023          Jainam Shah         Logic added for excluding the employees in rescinded list
-- 1.4		01/19/2023			Naresha Bhat		Modified existed logic by including Historical PRE_BOARDING_COMPLETION records
-------------------------------------------------------------------------------------------------------------------------------	

DECLARE
	return_result varchar(1000);
BEGIN
	DELETE  FROM
		DW_PROD.HAH.DIM_EMPLOYEE
	WHERE
		SOURCE_SYSTEM_ID = 36
		AND EMPLOYEE_ID NOT IN (
			SELECT
				DISTINCT SM.EMPLOYEE_ID
			FROM
				DISC_PROD.WORKDAY.WORKER_SUMMARY SM 
			LEFT JOIN
				DISC_PROD.WORKDAY.WORKER_ADDITIONAL_INFORMATION AD
				ON AD.EMPLOYEE_ID = SM.EMPLOYEE_ID
			LEFT JOIN
				DISC_PROD.WORKDAY.WORKER_STATUS ST
				ON ST.EMPLOYEE_ID = SM.EMPLOYEE_ID
			LEFT JOIN 
				(
			SELECT
				DISTINCT EMPLOYEE_ID
			FROM
				DISC_PROD.WORKDAY.HIST_WORKER_ADDITIONAL_INFORMATION AD
			WHERE
				(TRIM(AD.PRE_BOARDING_COMPLETION)::BOOLEAN = ''1'' )
				) HIST_AD
		ON HIST_AD.EMPLOYEE_ID = SM.EMPLOYEE_ID			
			WHERE (HIST_AD.EMPLOYEE_ID IS NOT NULL OR AD.EMPLOYEE_ID IS NOT NULL)
			AND TRIM(ST.PRIMARY_TERMINATION_REASON) IS DISTINCT FROM (''Terminate Employee > Reject > Duplicate Employee Record''));

  SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
  return return_result;
 
END;
';