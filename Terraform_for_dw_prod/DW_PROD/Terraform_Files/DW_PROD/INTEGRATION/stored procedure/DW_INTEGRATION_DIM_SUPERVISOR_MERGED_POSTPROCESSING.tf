resource "snowflake_procedure" "DW_INTEGRATION_DIM_SUPERVISOR_MERGED_POSTPROCESSING" {
	name ="DIM_SUPERVISOR_MERGED_POSTPROCESSING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
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
    return_result varchar(1000);
BEGIN

--**************************************************************************************************************************
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 		  					        Initial development
-- 01/24/2023  Sanket jain 			removed oshah filter bak prc-DIM_SUPERVISOR_MERGED_POSTPROCESSING_BAK_1_23_2023
--24/1/2023		Pooja Shah				Removed SOURCE_SYSTEM_ID NOT IN Filter for 14 -Axxess
--*****************************************************************************************************************************
    INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_SUPERVISOR_MERGED
WITH DATAFLEX AS 
(
	SELECT S.SUPERVISOR_KEY , S.SUPERVISOR_CODE , S.SYSTEM_CODE , S.SOURCE_SYSTEM_ID  , SUPERVISOR_NAME, 
	CASE WHEN CHARINDEX(''('',SUPERVISOR_NAME)=0 THEN
	UPPER(SUPERVISOR_NAME) ELSE UPPER(SUBSTRING(SUPERVISOR_NAME,1, CHARINDEX(''('',SUPERVISOR_NAME)-1)) END AS FULL_NAME,
	CASE WHEN CHARINDEX('' '',TRIM(FULL_NAME))=0 THEN
	FULL_NAME ELSE TRIM(SUBSTRING (FULL_NAME,1,CHARINDEX('' '',TRIM(FULL_NAME)))) END AS FIRST_NAME,
	CASE WHEN CHARINDEX('' '',TRIM(FULL_NAME))=0 THEN
	NULL ELSE TRIM(SUBSTRING (FULL_NAME,CHARINDEX('' '',TRIM(FULL_NAME)),100)) END AS LAST_NAME	
	FROM HAH.DIM_SUPERVISOR S
	WHERE SUPERVISOR_KEY  NOT IN (SELECT SUPERVISOR_KEY FROM HAH.DIM_SUPERVISOR 
	WHERE UPPER(SUPERVISOR_NAME) LIKE ANY (''BULK BILLING SPV%'',''%BRANCH'',''DO NOT%'',''%OFFICE'',''% DD'',''DD-%'',''%(CHICAGO)'',''%EMPTY'',''EMPTY%'')
	OR UPPER(SUPERVISOR_NAME) LIKE ANY (SELECT BRANCH_NAME FROM HAH.DIM_BRANCH))
	AND SOURCE_SYSTEM_ID =3
	AND SUPERVISOR_STATE_CODE NOT IN (''AL'',''GA'',''KY'',''SC'',''TN'',''MI'')
)
--SELECT * FROM DATAFLEX;  --ORIGINAL COUNT 1086 --AFTER FILTER COUNT 577
, CAREVOYANT AS 
(
	SELECT S.SUPERVISOR_KEY , S.SUPERVISOR_CODE , S.SYSTEM_CODE , S.SOURCE_SYSTEM_ID  , SUPERVISOR_NAME 
	FROM HAH.DIM_SUPERVISOR S
	WHERE SOURCE_SYSTEM_ID IN (1,2) 
)
--SELECT * FROM CAREVOYANT;
, SANDATA AS 
(
	SELECT S.SUPERVISOR_KEY , S.SUPERVISOR_CODE , S.SYSTEM_CODE , S.SOURCE_SYSTEM_ID , UPPER(SUPERVISOR_NAME) AS U_SUPERVISOR_NAME,
	CASE WHEN CHARINDEX('','',TRIM(U_SUPERVISOR_NAME))=0 THEN
	U_SUPERVISOR_NAME ELSE TRIM(SUBSTRING (U_SUPERVISOR_NAME,1,CHARINDEX('','',TRIM(U_SUPERVISOR_NAME))-1)) END AS LAST_NAME,
	CASE WHEN CHARINDEX('','',TRIM(U_SUPERVISOR_NAME))=0 THEN
	NULL ELSE TRIM(SUBSTRING (U_SUPERVISOR_NAME,CHARINDEX('','',TRIM(U_SUPERVISOR_NAME))+1,100)) END AS FIRST_NAME	
	FROM HAH.DIM_SUPERVISOR S
	WHERE SOURCE_SYSTEM_ID = 4
	AND SUPERVISOR_NAME IS NOT NULL 
)
--SELECT * FROM SANDATA;
,MATRIXCARE AS 
(
	SELECT S.SUPERVISOR_KEY , S.SUPERVISOR_CODE , S.SYSTEM_CODE , S.SOURCE_SYSTEM_ID , SUPERVISOR_NAME,
	CASE WHEN CHARINDEX('','',TRIM(SUPERVISOR_NAME))=0 THEN
	SUPERVISOR_NAME ELSE TRIM(SUBSTRING (SUPERVISOR_NAME,1,CHARINDEX('','',TRIM(SUPERVISOR_NAME))-1)) END AS LAST_NAME,
	CASE WHEN CHARINDEX('','',TRIM(SUPERVISOR_NAME))=0 THEN
	NULL ELSE TRIM(SUBSTRING (SUPERVISOR_NAME,CHARINDEX('','',TRIM(SUPERVISOR_NAME))+1,100)) END AS FIRST_NAME	
	FROM HAH.DIM_SUPERVISOR S
	WHERE SOURCE_SYSTEM_ID = 7
	AND SUPERVISOR_NAME IS NOT NULL 
)
,CCSI AS 
(
	SELECT S.SUPERVISOR_KEY , S.SUPERVISOR_CODE , S.SYSTEM_CODE , S.SOURCE_SYSTEM_ID  , SUPERVISOR_NAME	
	FROM HAH.DIM_SUPERVISOR S
	WHERE SOURCE_SYSTEM_ID = 8
)
,COMMON AS 
(
	SELECT D.SUPERVISOR_KEY AS OLD_KEY, D.SUPERVISOR_CODE AS ORIGINAL_SUPERVISOR_CODE , D.SYSTEM_CODE AS ORIGINAL_SYSTEM_CODE , D.SOURCE_SYSTEM_ID AS ORIGINAL_SOURCE_SYSTEM_ID,
	S.SUPERVISOR_KEY AS NEW_KEY, D.FIRST_NAME, D.LAST_NAME, S.FIRST_NAME, S.LAST_NAME 
	FROM DATAFLEX D 
	JOIN SANDATA S ON S.FIRST_NAME=D.FIRST_NAME AND S.LAST_NAME = D.LAST_NAME
	UNION 
	SELECT D.SUPERVISOR_KEY AS ORIGINAL_SUPERVISOR_KEY, D.SUPERVISOR_CODE AS ORIGINAL_SUPERVISOR_CODE,D.SYSTEM_CODE AS ORIGINAL_SYSTEM_CODE , D.SOURCE_SYSTEM_ID AS ORIGINAL_SOURCE_SYSTEM_ID,
	M.SUPERVISOR_KEY AS NEW_KEY, D.FIRST_NAME, D.LAST_NAME, M.FIRST_NAME, M.LAST_NAME 
	FROM DATAFLEX D 
	JOIN MATRIXCARE M ON M.FIRST_NAME=D.FIRST_NAME AND M.LAST_NAME = D.LAST_NAME
)
SELECT * FROM (
--SELECT * FROM COMMON;
SELECT DISTINCT S.SUPERVISOR_KEY AS ORIGINAL_SUPERVISOR_KEY, S.SUPERVISOR_CODE AS ORIGINAL_SUPERVISOR_CODE,S.SYSTEM_CODE AS ORIGINAL_SYSTEM_CODE, 
S.SOURCE_SYSTEM_ID  AS ORIGINAL_SOURCE_SYSTEM_ID,SS.*
	FROM HAH.DIM_SUPERVISOR AS S
	LEFT JOIN COMMON AS C ON C.OLD_KEY = S.SUPERVISOR_KEY 
	JOIN HAH.DIM_SUPERVISOR AS SS ON SS.SUPERVISOR_KEY = COALESCE(C.NEW_KEY, S.SUPERVISOR_KEY))
    WHERE SOURCE_SYSTEM_ID NOT IN (''15'') ;
--WHERE S.SUPERVISOR_KEY NOT IN (SELECT NEW_KEY FROM COMMON);

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

