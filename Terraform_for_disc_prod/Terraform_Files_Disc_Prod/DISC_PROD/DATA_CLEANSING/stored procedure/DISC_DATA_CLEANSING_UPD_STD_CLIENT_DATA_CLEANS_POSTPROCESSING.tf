resource "snowflake_procedure" "DISC_DATA_CLEANSING_UPD_STD_CLIENT_DATA_CLEANS_POSTPROCESSING" {
	name ="UPD_STD_CLIENT_DATA_CLEANS_POSTPROCESSING"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  Client_Src_Attributes_Update_Address_Flags
--
-- PURPOSE: To update Processed flag and Cleansed flag for client
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/09/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

/*Update SRC_CLIENT_ADDRESS_PROCESSED_FLAG from CLIENT_STANDARDIZED_ADDRESSES basis of CLIENT_ID  */

	UPDATE DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES" 
    FROM (
    SELECT 
    STD_ATTRBT."SOURCE_SYSTEM_ID" ,
    STD_ATTRBT."SYSTEM_CODE" ,
    STD_ATTRBT."CLIENT_ID" 
    FROM 
    DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STANDARDIZED_ADDRESSES" ADD_OUTPT
    JOIN DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES" STD_ATTRBT
    ON ADD_OUTPT."SOURCE_SYSTEM_ID"  = STD_ATTRBT."SOURCE_SYSTEM_ID" 
    AND ADD_OUTPT."SYSTEM_CODE"  = STD_ATTRBT."SYSTEM_CODE" 
    AND ADD_OUTPT."CLIENT_NUMBER"  = STD_ATTRBT."CLIENT_ID" 
	AND STD_ATTRBT.SRC_CLIENT_ADDRESS_PROCESSED_FLAG = FALSE 
    GROUP BY 1,2,3 ) X
    SET 
    SRC_CLIENT_ADDRESS_PROCESSED_FLAG = TRUE 
    WHERE 
    DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"."SOURCE_SYSTEM_ID"  = X.SOURCE_SYSTEM_ID
    AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES".SYSTEM_CODE = X.SYSTEM_CODE
    AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES".CLIENT_ID = X.CLIENT_ID ;

	
/* Update SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG where  METHD_UPD is not null */
	
	UPDATE DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"  FROM 
	(
	SELECT 
	"SOURCE_SYSTEM_ID" ,
	"SYSTEM_CODE" ,
	"CLIENT_ID" 
	FROM 
	DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES" 
	WHERE 
	METHD_UPD IS NOT NULL 
	AND "SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG" = FALSE 
	AND ( METHD_UPD LIKE ''%LOD%'' OR METHD_UPD like ''%UPD_FRM_ADD_TBL'')
	GROUP BY 1,2,3 )xx
	SET 
	SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG = TRUE 
	WHERE 
	DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"."SOURCE_SYSTEM_ID"  = xx.SOURCE_SYSTEM_ID
	AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES".SYSTEM_CODE = xx.SYSTEM_CODE
	AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES".CLIENT_ID = xx.CLIENT_ID ;


/* PROCESSED and CLEANSED FLAG ALONG WITH OTHER ADDRESS WHICH HAS SAME ADDRESS within table and will update whose CLEANSE_FLG is FALSE  */

	UPDATE  DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"  
	FROM 
	(SELECT Y."SOURCE_SYSTEM_ID" ,Y."SYSTEM_CODE" ,Y."CLIENT_ID" ,X.STD_CLIENT_ADDRESS,
	X.STD_CLIENT_CITY,X.STD_CLIENT_COUNTY,X.STD_CLIENT_STATE_NAME,X.STD_CLIENT_STATE_CODE,X.STD_CLIENT_ZIP,X.STD_CLIENT_ZIP_PLUS_FOUR,X.LABEL,
	X.STD_CLIENT_COUNTRY_CODE,
	X.ADDRESS_NUMBER,X.STREET,X.POINTS,X.LATITUDE ,X.LONGITUDE ,X.RELEVANCE
	FROM  
	(SELECT 
	"SRC_CLIENT_ADDRESS" ,
	"SRC_CLIENT_CITY" ,
	"SRC_CLIENT_STATE_CODE" ,
	"SRC_CLIENT_ZIP" ,
	STD_CLIENT_ADDRESS,
	STD_CLIENT_CITY,
	STD_CLIENT_COUNTY,
	STD_CLIENT_STATE_NAME,
	STD_CLIENT_STATE_CODE,
	STD_CLIENT_ZIP,
	STD_CLIENT_ZIP_PLUS_FOUR,
	STD_CLIENT_COUNTRY_CODE,
	ADDRESS_NUMBER,
	STREET,
	LABEL,
	POINTS,
	LATITUDE ,
	LONGITUDE ,
	RELEVANCE 
	FROM  
	DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES" 
	WHERE "SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG" = TRUE 	
	GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19)x
	JOIN (SELECT source_system_id,system_code,CLIENT_id,SRC_CLIENT_ADDRESS,SRC_CLIENT_CITY, SRC_CLIENT_STATE_CODE,
	SRC_CLIENT_ZIP FROM  DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"  
		WHERE "SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG" = FALSE )   Y 
	ON X.SRC_CLIENT_ADDRESS = Y.SRC_CLIENT_ADDRESS 
	AND X.SRC_CLIENT_CITY = Y."SRC_CLIENT_CITY" 
	AND X.SRC_CLIENT_STATE_CODE = Y.SRC_CLIENT_STATE_CODE 
	AND X.SRC_CLIENT_ZIP = Y.SRC_CLIENT_ZIP
	GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18) XX
	SET 
	STD_CLIENT_ADDRESS = XX.STD_CLIENT_ADDRESS,
	STD_CLIENT_CITY  = XX.STD_CLIENT_CITY,
	STD_CLIENT_COUNTY  = XX.STD_CLIENT_COUNTY,
	STD_CLIENT_STATE_NAME  = XX.STD_CLIENT_STATE_NAME,
	STD_CLIENT_STATE_CODE  = XX.STD_CLIENT_STATE_CODE,
	STD_CLIENT_ZIP  = XX.STD_CLIENT_ZIP,
	STD_CLIENT_ZIP_PLUS_FOUR = XX.STD_CLIENT_ZIP_PLUS_FOUR,
	STD_CLIENT_COUNTRY_CODE  = XX.STD_CLIENT_COUNTRY_CODE ,
	ADDRESS_NUMBER  = XX.ADDRESS_NUMBER ,
	STREET  = XX.STREET ,
	POINTS  = XX. POINTS,
	LABEL = XX.LABEL,
	LATITUDE  = XX.LATITUDE ,
	LONGITUDE  = XX.LONGITUDE ,
	RELEVANCE  = XX.RELEVANCE,
	METHD_UPD = COALESCE(METHD_UPD,'''')||''UPD_FRM_STD_ADD_TBL'' ,
	SRC_CLIENT_ADDRESS_PROCESSED_FLAG =  TRUE ,
	SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG = TRUE 
	WHERE 
	DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES".SOURCE_SYSTEM_ID = XX.SOURCE_SYSTEM_ID
	AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"."SYSTEM_CODE"  = XX.SYSTEM_CODE
	AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"."CLIENT_ID"  = XX.CLIENT_ID ;

/* Update Process flag which has not cleansed successfully with all attribute*/


	UPDATE  DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES" 
	FROM (
	SELECT y.source_system_id,y.system_code,y.CLIENT_id,X.STD_CLIENT_ADDRESS,
	X.STD_CLIENT_CITY,X.STD_CLIENT_COUNTY,X.STD_CLIENT_STATE_NAME,X.STD_CLIENT_STATE_CODE,X.STD_CLIENT_ZIP,X.STD_CLIENT_ZIP_PLUS_FOUR,X.LABEL,
	X.STD_CLIENT_COUNTRY_CODE,
	X.ADDRESS_NUMBER,X.STREET,X.POINTS,X.LATITUDE ,X.LONGITUDE ,X.RELEVANCE
	FROM 
	(SELECT 
		"SRC_CLIENT_ADDRESS" ,
		"SRC_CLIENT_CITY" ,
		"SRC_CLIENT_STATE_CODE" ,
		"SRC_CLIENT_ZIP" ,
		STD_CLIENT_ADDRESS,
		STD_CLIENT_CITY,
		STD_CLIENT_COUNTY,
		STD_CLIENT_STATE_NAME,
		STD_CLIENT_STATE_CODE,
		STD_CLIENT_ZIP,
		STD_CLIENT_ZIP_PLUS_FOUR,
		STD_CLIENT_COUNTRY_CODE,
		ADDRESS_NUMBER,
		STREET,
		LABEL,
		POINTS,
		LATITUDE ,
		LONGITUDE ,
		RELEVANCE 
	FROM DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"
	WHERE "SRC_CLIENT_ADDRESS_PROCESSED_FLAG" = TRUE 
	AND "SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG" = FALSE 
	GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19)x 
	JOIN (SELECT source_system_id,system_code,CLIENT_id,"SRC_CLIENT_ADDRESS" ,
		"SRC_CLIENT_CITY" ,
		"SRC_CLIENT_STATE_CODE" ,
		"SRC_CLIENT_ZIP" 
	FROM DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES"
	WHERE "SRC_CLIENT_ADDRESS_PROCESSED_FLAG" = FALSE  
	AND "SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG" = FALSE 
	)y 
	ON x.SRC_CLIENT_ADDRESS = y.SRC_CLIENT_ADDRESS
	AND x.SRC_CLIENT_CITY = y.SRC_CLIENT_CITY 
	AND x.SRC_CLIENT_STATE_CODE = y.SRC_CLIENT_STATE_CODE
	AND x.SRC_CLIENT_ZIP = y.SRC_CLIENT_ZIP )xx
	SET
	STD_CLIENT_ADDRESS = xx.STD_CLIENT_ADDRESS,
	STD_CLIENT_CITY  = xx.STD_CLIENT_CITY,
	STD_CLIENT_COUNTY  =xx.STD_CLIENT_COUNTY,
	STD_CLIENT_STATE_NAME  = xx.STD_CLIENT_STATE_NAME,
	STD_CLIENT_STATE_CODE  = xx.STD_CLIENT_STATE_CODE,
	STD_CLIENT_ZIP  = xx.STD_CLIENT_ZIP,
	STD_CLIENT_ZIP_PLUS_FOUR = xx.STD_CLIENT_ZIP_PLUS_FOUR,
	STD_CLIENT_COUNTRY_CODE  = xx.STD_CLIENT_COUNTRY_CODE ,
	ADDRESS_NUMBER  = xx.ADDRESS_NUMBER ,
	STREET  = xx.STREET ,
	POINTS  = xx. POINTS,
	LABEL = xx.LABEL,
	LATITUDE  = xx.LATITUDE ,
	LONGITUDE  = xx.LONGITUDE ,
	RELEVANCE  = xx.RELEVANCE,
	SRC_CLIENT_ADDRESS_PROCESSED_FLAG = TRUE ,
	METHD_UPD = COALESCE (METHD_UPD,'''')||''| PROCS_FLG_UPD_NON_CLENS_REC''
	WHERE 
	DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES".source_system_id = xx.source_system_id
	AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES".system_code = xx.system_code
	AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES".CLIENT_id = xx.CLIENT_id  ;



/* FLAG UPDATE FROM  STANDARD ATTRIBUTE TO SOURCE ATTRIBUTE  */

	UPDATE  DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_SRC_ATTRIBUTES" FROM 
	(SELECT  
	SRC."SOURCE_SYSTEM_ID" ,
	SRC."SYSTEM_CODE" ,
	SRC."CLIENT_ID" ,
	STD."SRC_CLIENT_ADDRESS_PROCESSED_FLAG" ,
	STD."SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG" 
	FROM 
	DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_SRC_ATTRIBUTES" SRC
	JOIN DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_STD_ATTRIBUTES" STD 
	ON SRC.SOURCE_SYSTEM_ID =  STD."SOURCE_SYSTEM_ID" 
	AND SRC.SYSTEM_CODE =  STD."SYSTEM_CODE" 
	AND SRC.CLIENT_ID = STD."CLIENT_ID" )XX
	SET 
	"SRC_CLIENT_ADDRESS_PROCESSED_FLAG"  = XX.SRC_CLIENT_ADDRESS_PROCESSED_FLAG,
	"SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG" = XX.SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG
	WHERE 
	DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_SRC_ATTRIBUTES"."SOURCE_SYSTEM_ID"  = XX.SOURCE_SYSTEM_ID
	AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_SRC_ATTRIBUTES"."SYSTEM_CODE"  = XX.SYSTEM_CODE
	AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING."CLIENT_SRC_ATTRIBUTES"."CLIENT_ID"  = XX.CLIENT_ID ;


 
 RETURN ''SUCCESS'';
    END;

 EOT
}

