CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_COSTALSYNCDATA_DIM_INVOICE_TRANSACTION_TYPE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
    BEGIN
        --*****************************************************************************************************************************
        -- NAME:  COSTALSYNCDATA_DIM_INVOICE_TRANSACTION_TYPE
        --
        -- DEVELOPMENT LOG:
        -- DATE         AUTHOR                  NOTES:
        -- ---------     -------------------  -----------------------------------------------------------------------------------------------
        -- 23/01/24     POONIT MISTRY (OLLION) Initial Development

        --*****************************************************************************************************************************
        --
        INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_DIM_INVOICE_TRANSACTION_TYPE
        SELECT DISTINCT MD5(''COSTALSYNCDATA'' || ''-'' ||
                            SYSTEM_CODE || ''-'' ||
                            type.CODE || ''-'' ||
                            ''COSTALSYNCDATA'')                                     AS TRANSACTION_TYPE_KEY
                      , NULL                                                        AS PARENT_TRANSACTION_TYPE_KEY
                      , type.CODE                                                   AS TRANSACTION_CODE
                      , type.DESCRIPTION                                            AS TRANSACTION_NAME
                      , desc.DESCRIPTION                                            AS TRANSACTION_DESC
                      , SYSTEM_CODE                                                 AS SYSTEM_CODE
					  , CASE SYSTEM_CODE
                        WHEN ''SHC_ALTRUS'' THEN 1
                   		WHEN ''SHC_SAVANNAH'' THEN 2
                   		ELSE -1 END                                             	AS SOURCE_SYSTEM_ID
                      , :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY
                      , :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY
                      , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
                      , CURRENT_USER                                                as ETL_INSERTED_BY
                      , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
                      , CURRENT_USER                                                as ETL_LAST_UPDATED_BY
                      , 0                                                           as ETL_DELETED_FLAG
        from DISC_PROD.COSTALSYNCDATA.CAREVOYANT_TRANSACTION_TYPES type
                 LEFT JOIN DISC_PROD.COSTALSYNCDATA.CAREVOYANT_TRANSACTION_DESCRIPTIONS desc
                           on trim(type.type) = trim(desc.code);
        RETURN ''SUCCESS'';
    END ;
';