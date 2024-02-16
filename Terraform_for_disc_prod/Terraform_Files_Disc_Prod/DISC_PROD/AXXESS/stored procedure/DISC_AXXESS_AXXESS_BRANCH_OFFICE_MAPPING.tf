resource "snowflake_procedure" "DISC_AXXESS_AXXESS_BRANCH_OFFICE_MAPPING" {
	name ="AXXESS_BRANCH_OFFICE_MAPPING"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
begin
	/*****************************************************************************************************************************
	NAME:  	 OFFICE_MAPPING
	PURPOSE: 
	DATE           AUTHOR                NOTES:
	---------- 	   -------------------   -----------------------------------------------------------------------------------------------
	09/21/2023     Deepen Gajjar		 Initial development and Last updated
	09/22/2023     Ravi Suthar    		 Added Parameters for ETL and change name GET_OFFICE_MAPPING to AXXESS_BRANCH_OFFICE_MAPPING
	*****************************************************************************************************************************/

INSERT INTO  DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_BRANCH_OFFICE_MAPPING  (BRANCH_ID,BRANCH)

WITH DAT AS (
SELECT DISTINCT  fin.branch_id, nvl(OFFICES.BRANCH,fin.branch_name ) BRANCH
FROM 
(
	SELECT Distinct BRANCH_ID, BRANCH_NAME, NVL(BRANCH_STATE_CODE,''OH'') AS BRANCH_STATE_CODE,BRANCH_ZIP_CODE 
	FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HC_TASKDETAILS
	WHERE BRANCH_ID IS NOT NULL AND BRANCH_NAME IS NOT NULL
) FIN
--LEFT JOIN
--	HAH.DIM_GEOGRAPHY GEO ON FIN.BRANCH_ZIP_CODE = GEO.ZIP_CODE
LEFT JOIN 
	DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_BRANCH_OFFICE_MAPPING OFFICES ON 	FIN.BRANCH_ID = OFFICES.BRANCH_ID
UNION 
SELECT DISTINCT branch_id, branch
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_EPISODESNAPSHOTS 
)
SELECT *
FROM dat a  
WHERE a.BRANCH_ID NOT IN (SELECT BRANCH_ID FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_BRANCH_OFFICE_MAPPING)
;


SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :RETURN_RESULT FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
    RETURN RETURN_RESULT;
end;

 EOT
}

