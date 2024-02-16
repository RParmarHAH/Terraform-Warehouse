CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.MERGE_STAGE_DAT_CLEANSING_CLIENT_ADDRESS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME: ADPALLIANCE_SRC_CLIENT
--
-- PURPOSE: Creates script for data cleanse for ADPALLIANCE source
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 10/03/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

/* Data loading in Azure Staging table */

INSERT OVERWRITE INTO DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES 
SELECT * FROM AWS_LANDING_INGEST_DB_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES ;


/* To Update .0 zip with correct value  */

UPDATE DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES 
FROM 
(
SELECT  
source_system_id,
system_code,
CLIENT_NUMBER,
SPLIT_PART(zip,''.'',1)  AS  zip
FROM 
DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES 
WHERE LENGTH(zip) in  (7,6) 
AND zip LIKE ''%.0'' GROUP BY 1,2,3,4
)x 
SET 
zip  = x.zip
WHERE 
DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES.source_system_id = X.source_system_id
AND DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES.system_code = X.system_code
AND DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES .CLIENT_NUMBER = X.CLIENT_NUMBER;

/* To Update Four diigt length zip with proper value  */

UPDATE DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES 
FROM 
(
SELECT  
source_system_id,
system_code,
CLIENT_NUMBER,
''0''||zip AS  zip
FROM 
DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES 
WHERE LENGTH(zip) = 4 
GROUP BY 1,2,3,4
)x 
SET 
zip  = x.zip
WHERE 
DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES .source_system_id = X.source_system_id
AND DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES .system_code = X.system_code
AND DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES .CLIENT_NUMBER = X.CLIENT_NUMBER;


/* Merge Statement to CLIENT_STANDARDIZED_ADDRESSES_20231003 */

MERGE INTO DISC_PROD.DATA_CLEANSING.CLIENT_STANDARDIZED_ADDRESSES   AS tgt
USING
(
SELECT DISTINCT SOURCE_SYSTEM_ID,
				SYSTEM_CODE,
				CLIENT_NUMBER,
				FIRST_NAME,
				LAST_NAME,
				ADDRESS,
				CITY,
				STATE,
				ZIP,
				POINTS,
				LATITUDE,
				LONGITUDE,
				LABEL,
				ADDRESS_NUMBER,
				STREET,
				MUNICIPALITY,
				REGION,
				SUB_REGION,
				COUNTRY_CODE,
				ZIPCODE,
				PLUS_FOUR_CODE,
				RELEVANCE,
				INSERTED_AT       
				FROM DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES 
) AS src
ON src.Source_System_ID = tgt.Source_System_ID
AND src.System_Code = tgt.System_Code
AND src.CLIENT_NUMBER = tgt.CLIENT_NUMBER
WHEN MATCHED AND (
				  IFNULL( src.FIRST_NAME, ''~!@#$%^&*()+'') <> IFNULL( tgt.FIRST_NAME, ''~!@#$%^&*()+'')
              OR  IFNULL( src.LAST_NAME, ''~!@#$%^&*()+'') <> IFNULL( tgt.LAST_NAME, ''~!@#$%^&*()+'')
              OR  IFNULL( src.ADDRESS, ''~!@#$%^&*()+'') <> IFNULL( tgt.ADDRESS, ''~!@#$%^&*()+'')
              OR  IFNULL( src.CITY, ''~!@#$%^&*()+'') <> IFNULL( tgt.CITY, ''~!@#$%^&*()+'')
              OR  IFNULL( src.STATE, ''~!@#$%^&*()+'') <> IFNULL( tgt.STATE, ''~!@#$%^&*()+'')
              OR  IFNULL( src.ZIP, ''~!@#$%^&*()+'') <> IFNULL( tgt.ZIP, ''~!@#$%^&*()+'')
              OR  IFNULL( src.POINTS, ''~!@#$%^&*()+'') <> IFNULL( tgt.POINTS, ''~!@#$%^&*()+'')
              OR  IFNULL( src.LATITUDE::VARCHAR(50), ''~!@#$%^&*()+'') <> IFNULL( tgt.LATITUDE::VARCHAR(50), ''~!@#$%^&*()+'')
              OR  IFNULL( src.LONGITUDE::VARCHAR(50), ''~!@#$%^&*()+'') <> IFNULL( tgt.LONGITUDE::VARCHAR(50), ''~!@#$%^&*()+'')
              OR  IFNULL( src.LABEL, ''~!@#$%^&*()+'') <> IFNULL( tgt.LABEL, ''~!@#$%^&*()+'')
              OR  IFNULL( src.STREET, ''~!@#$%^&*()+'') <> IFNULL( tgt.STREET, ''~!@#$%^&*()+'')
              OR  IFNULL( src.MUNICIPALITY, ''~!@#$%^&*()+'') <> IFNULL( tgt.MUNICIPALITY, ''~!@#$%^&*()+'')
              OR  IFNULL( src.REGION, ''~!@#$%^&*()+'') <> IFNULL( tgt.REGION, ''~!@#$%^&*()+'')
              OR  IFNULL( src.SUB_REGION, ''~!@#$%^&*()+'') <> IFNULL( tgt.SUB_REGION, ''~!@#$%^&*()+'')
              OR  IFNULL( src.COUNTRY_CODE, ''~!@#$%^&*()+'') <> IFNULL( tgt.COUNTRY_CODE, ''~!@#$%^&*()+'')
              OR  IFNULL( src.ZIPCODE, ''~!@#$%^&*()+'') <> IFNULL( tgt.ZIPCODE, ''~!@#$%^&*()+'')
              OR  IFNULL( src.PLUS_FOUR_CODE, ''~!@#$%^&*()+'') <> IFNULL( tgt.PLUS_FOUR_CODE, ''~!@#$%^&*()+'')
              OR  IFNULL( src.RELEVANCE::VARCHAR(50), ''~!@#$%^&*()+'') <> IFNULL( tgt.RELEVANCE::VARCHAR(50), ''~!@#$%^&*()+'')
              OR  IFNULL( src.INSERTED_AT::VARCHAR(50), ''~!@#$%^&*()+'') <> IFNULL( tgt.INSERTED_AT::VARCHAR(50), ''~!@#$%^&*()+'')		  
			  )
 THEN UPDATE SET  tgt.FIRST_NAME = src.FIRST_NAME,
                  tgt.LAST_NAME = src.LAST_NAME,
                  tgt.ADDRESS = src.ADDRESS,
                  tgt.CITY = src.CITY,
                  tgt.STATE = src.STATE,
                  tgt.ZIP = src.ZIP,
                  tgt.POINTS = src.POINTS,
                  tgt.LATITUDE = src.LATITUDE,
                  tgt.LONGITUDE = src.LONGITUDE,
                  tgt.LABEL = src.LABEL,
                  tgt.STREET = src.STREET,
                  tgt.MUNICIPALITY = src.MUNICIPALITY,
                  tgt.REGION = src.REGION,
                  tgt.SUB_REGION = src.SUB_REGION,
                  tgt.COUNTRY_CODE = src.COUNTRY_CODE,
                  tgt.ZIPCODE = src.ZIPCODE,
                  tgt.PLUS_FOUR_CODE = src.PLUS_FOUR_CODE,
                  tgt.RELEVANCE = src.RELEVANCE,
                  tgt.INSERTED_AT = src.INSERTED_AT
WHEN NOT MATCHED THEN INSERT
(SOURCE_SYSTEM_ID,SYSTEM_CODE,CLIENT_NUMBER,FIRST_NAME,LAST_NAME,ADDRESS,CITY,STATE,ZIP,POINTS,LATITUDE,LONGITUDE,
				LABEL,ADDRESS_NUMBER,STREET,MUNICIPALITY,REGION,SUB_REGION,COUNTRY_CODE,ZIPCODE,PLUS_FOUR_CODE,
				RELEVANCE,INSERTED_AT )
VALUES
(SOURCE_SYSTEM_ID,SYSTEM_CODE,CLIENT_NUMBER,FIRST_NAME,LAST_NAME,ADDRESS,CITY,STATE,ZIP,POINTS,LATITUDE,LONGITUDE,
				LABEL,ADDRESS_NUMBER,STREET,MUNICIPALITY,REGION,SUB_REGION,COUNTRY_CODE,ZIPCODE,PLUS_FOUR_CODE,
				RELEVANCE,INSERTED_AT );
				

/* Address storing in historical table */

INSERT INTO DISC_PROD.DATA_CLEANSING.CLIENT_HISTRY_STANDARDIZED_ADDRESSES
SELECT * FROM DISC_PROD.DATA_CLEANSING.CLIENT_STG_STANDARDIZED_ADDRESSES  ;
	
 
 RETURN ''SUCCESS'';
END;
';