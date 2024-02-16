CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_WORKDAY_CROSSWALK_MAPPING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN 

---UPDATE CURRENT RECORDS AS FLASE SO THAT WE CAN ONLY PICK NEW RECORDS 
UPDATE DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING
SET CURRENT_RECORDS = FALSE ;

INSERT INTO DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING
WITH MAPPING_DATA AS (  -- PULL THE LIST OF DUPLICATES
    SELECT * FROM  DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_DEDUPE_OUTPUT  WHERE CLUSTER_ID IS NOT NULL
) --select * from MAPPING_DATA;
, WORKDAY_RECORDS AS
(
SELECT * FROM MAPPING_DATA  WHERE SOURCE  =''WORKDAY''
) -- select * from WORKDAY_RECORDS;
, AMS_RECORDS AS
(
SELECT * FROM MAPPING_DATA  WHERE SOURCE  =''CROSSWALK''
)  --select * from AMS_RECORDS;
SELECT W.ID AS WORKDAY_ID,W.SOURCE AS WORKDAY_SOURCE ,W.SYSTEM_CODE as WORKDAY_SYSTEM_CODE,
       A.ID AS CROSSWALK_EMPLOYEE_ENTERPRISE_ID, A.SOURCE AS CROSS_WALK_SOURCE, A.SYSTEM_CODE AS AMS_SYSTEM_CODE
        ,-1 AS ETL_TASK_KEY,
		-1 AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG,
        TRUE AS CURRENT_RECORDS,
        FALSE AS ON_HOLD  
FROM WORKDAY_RECORDS W 
INNER JOIN AMS_RECORDS A ON A.CLUSTER_ID = W.CLUSTER_ID;
 
update DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING M
 SET ON_HOLD = TRUE
  from (
with DUPS AS (    
select WORKDAY_ID,ETL_INSERTED_DATE,COUNT(*) from DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING 
GROUP BY all HAVING COUNT(*) >1
  ) SELECT WORKDAY_ID,ETL_INSERTED_DATE FROM DUPS 
    ) D
  WHERE  D.WORKDAY_ID = M.WORKDAY_ID 
  AND D.ETL_INSERTED_DATE = M.ETL_INSERTED_DATE;  
  
RETURN ''SUCCESS'';
end;                        
';