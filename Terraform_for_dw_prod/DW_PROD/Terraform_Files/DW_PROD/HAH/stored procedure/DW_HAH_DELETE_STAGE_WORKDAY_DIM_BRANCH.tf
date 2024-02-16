resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_WORKDAY_DIM_BRANCH" {
	name ="DELETE_STAGE_WORKDAY_DIM_BRANCH"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

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
		DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH
	WHERE
		SOURCE_SYSTEM_ID = 36
		AND BRANCH_KEY NOT IN (
			SELECT
				BRANCH_KEY
			FROM
				DW_${var.SF_ENVIRONMENT}.STAGE.WORKDAY_DIM_BRANCH);

  SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
  return return_result;
 
END;

 EOT
}

