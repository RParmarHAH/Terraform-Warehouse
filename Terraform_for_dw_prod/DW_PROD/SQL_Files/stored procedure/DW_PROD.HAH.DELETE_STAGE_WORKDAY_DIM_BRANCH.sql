CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_WORKDAY_DIM_BRANCH()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
-------------------------------------------------------------------------------------------------------------------------------
/*
Object Type : 	Procedure
Object Name	: 	DELETE_STAGE_WORKDAY_DIM_BRANCH
Author		:	Jainam Shah
Description :
	- This particular object is full load
	- This procedure deletes the branches that are not supposed to in business layer
*/

--*****************************************************************************************************************************
-- CHANGE LOG :
-- Version	Date(MM/DD/YYYY)	Author				Change Description
-- --------	----------------   	------------------	---------------------------------------------------------------------------
-- 1.0		10/03/2023    		Jainam Shah			Initial Development
-------------------------------------------------------------------------------------------------------------------------------	

DECLARE
	return_result varchar(1000);
BEGIN
	DELETE FROM
		DW_PROD.HAH.DIM_BRANCH
	WHERE
		SOURCE_SYSTEM_ID = 36
		AND BRANCH_KEY NOT IN (
			SELECT
				BRANCH_KEY
			FROM
				DW_PROD.STAGE.WORKDAY_DIM_BRANCH);

  SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
  return return_result;
 
END;
';