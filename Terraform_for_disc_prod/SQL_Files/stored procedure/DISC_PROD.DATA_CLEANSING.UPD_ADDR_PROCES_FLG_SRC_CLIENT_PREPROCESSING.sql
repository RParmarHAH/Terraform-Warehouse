CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.UPD_ADDR_PROCES_FLG_SRC_CLIENT_PREPROCESSING()
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
-- PURPOSE: Creates script for to ignore those address which is already processed by location service 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 10/04/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

/* Update  address basis */

UPDATE DISC_PROD.DATA_CLEANSING.CLIENT_SRC_ATTRIBUTES 
FROM (
SELECT  
PRCS_FLG_FALSE.SOURCE_SYSTEM_ID ,
PRCS_FLG_FALSE.SYSTEM_CODE ,
PRCS_FLG_FALSE.CLIENT_ID 
FROM 
(SELECT 
SRC_CLIENT_ADDRESS ,
SRC_CLIENT_CITY ,
SRC_CLIENT_STATE_CODE ,
SRC_CLIENT_ZIP 
FROM 
DISC_PROD.DATA_CLEANSING.CLIENT_SRC_ATTRIBUTES
WHERE 
SRC_CLIENT_ADDRESS_PROCESSED_FLAG  = TRUE 
GROUP BY 1,2,3,4)PRCS_FLG_TRUE,
(
SELECT 
SOURCE_SYSTEM_ID ,
SYSTEM_CODE ,
CLIENT_ID ,
SRC_CLIENT_ADDRESS ,
SRC_CLIENT_CITY ,
SRC_CLIENT_STATE_CODE ,
SRC_CLIENT_ZIP 
FROM 
DISC_PROD.DATA_CLEANSING.CLIENT_SRC_ATTRIBUTES
WHERE 
SRC_CLIENT_ADDRESS_PROCESSED_FLAG  = FALSE  
)PRCS_FLG_FALSE
WHERE 
PRCS_FLG_TRUE.SRC_CLIENT_ADDRESS = PRCS_FLG_FALSE.SRC_CLIENT_ADDRESS
AND PRCS_FLG_TRUE.SRC_CLIENT_CITY = PRCS_FLG_FALSE.SRC_CLIENT_CITY
AND PRCS_FLG_TRUE.SRC_CLIENT_STATE_CODE = PRCS_FLG_FALSE.SRC_CLIENT_STATE_CODE
AND PRCS_FLG_TRUE.SRC_CLIENT_ZIP =  PRCS_FLG_FALSE.SRC_CLIENT_ZIP 
) FNL_FLG 
SET 
SRC_CLIENT_ADDRESS_PROCESSED_FLAG  = TRUE  
WHERE 
DISC_PROD.DATA_CLEANSING.CLIENT_SRC_ATTRIBUTES.SOURCE_SYSTEM_ID = FNL_FLG.SOURCE_SYSTEM_ID
AND DISC_PROD.DATA_CLEANSING.CLIENT_SRC_ATTRIBUTES.SYSTEM_CODE = FNL_FLG.SYSTEM_CODE
AND DISC_PROD.DATA_CLEANSING.CLIENT_SRC_ATTRIBUTES.CLIENT_ID = FNL_FLG.CLIENT_ID ;

 
 RETURN ''SUCCESS'';
    END;
';