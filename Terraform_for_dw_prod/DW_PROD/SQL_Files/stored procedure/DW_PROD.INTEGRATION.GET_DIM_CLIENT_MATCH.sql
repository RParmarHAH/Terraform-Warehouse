CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_DIM_CLIENT_MATCH("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN

INSERT OVERWRITE INTO DW_PROD.INTEGRATION.DIM_CLIENT_MATCH 
WITH DEDUPE_RECORD_IDS AS 
(
	SELECT RECORD_ID,CLUSTER_ID,FILENAME
	FROM DISC_DEDUPE_PROD.CCSI.DF_CCSI_CLIENT_DEDUPE_SOURCE
	WHERE 
	CLUSTER_ID IN (SELECT CLUSTER_ID
		FROM DISC_DEDUPE_PROD.CCSI.DF_CCSI_CLIENT_DEDUPE_SOURCE
		GROUP BY CLUSTER_ID
		HAVING COUNT(CLUSTER_ID)>1)
),
CLIENT_MASTER AS
(
	SELECT RECORD_ID,CLUSTER_ID,FILENAME,CCSI_CLIENT.BEGIN_DATE,CCSI_CLIENT.CLIENT_NUMBER
	,ROW_NUMBER() OVER(PARTITION BY DEDUPE.CLUSTER_ID ORDER BY  
		 CCSI_CLIENT.CLIENT_NUMBER DESC ) LEAST_RECORD_ID
	FROM DISC_DEDUPE_PROD.CCSI.DF_CCSI_CLIENT_DEDUPE_SOURCE DEDUPE
	INNER JOIN DW_PROD.HAH.DIM_CLIENT  CCSI_CLIENT ON
	DEDUPE.RECORD_ID = CCSI_CLIENT.CLIENT_KEY 
) 
	SELECT DEDUPE.RECORD_ID ORIGINAL_RECORD_ID  --(CAN KEEP IT SHORT AS ORG_RECORD_ID, WE CAN DECIDE THE NAMING TERMINOLOGY)
		,M.RECORD_ID  MASTER_ID 
		,DEDUPE.CLUSTER_ID
		,CCSI_CLIENT.CLIENT_NUMBER 
		,CCSI_CLIENT.BEGIN_DATE 
        ,ROW_NUMBER() OVER(PARTITION BY DEDUPE.CLUSTER_ID ORDER BY CCSI_CLIENT.CLIENT_NUMBER DESC ) RECORD_ORDER
        ,CCSI_CLIENT.CLIENT_FIRST_NAME
        ,CCSI_CLIENT.CLIENT_LAST_NAME
		,CCSI_CLIENT.CLIENT_MIDDLE_NAME
        ,CCSI_CLIENT.CLIENT_NAME
        ,CCSI_CLIENT.CLIENT_DOB 
--BELOW ARE SOME OF THE ADDITIONAL FIELDS WHICH CAN BE HELPFUL FOR DATA VALIDATION AND TROUBLE SHOOTING 
        ,CCSI_CLIENT.CLIENT_PID 
        ,CCSI_CLIENT.CLIENT_CITY
        ,CCSI_CLIENT.CLIENT_ZIP 	 
        ,CCSI_CLIENT.CLIENT_CELL_PHONE
      FROM DISC_DEDUPE_PROD.CCSI.DF_CCSI_CLIENT_DEDUPE_SOURCE DEDUPE
      INNER JOIN DW_PROD.HAH.DIM_CLIENT CCSI_CLIENT ON
            DEDUPE.RECORD_ID = CCSI_CLIENT.CLIENT_KEY 
      INNER JOIN DEDUPE_RECORD_IDS MATCHES ON
            MATCHES.FILENAME = DEDUPE.FILENAME
            AND MATCHES.RECORD_ID = DEDUPE.RECORD_ID
            AND MATCHES.CLUSTER_ID = DEDUPE.CLUSTER_ID
      INNER JOIN CLIENT_MASTER M ON 
            M.CLUSTER_ID=MATCHES.CLUSTER_ID
            AND LEAST_RECORD_ID=1 
      ORDER BY 3,6 ;
	  
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';