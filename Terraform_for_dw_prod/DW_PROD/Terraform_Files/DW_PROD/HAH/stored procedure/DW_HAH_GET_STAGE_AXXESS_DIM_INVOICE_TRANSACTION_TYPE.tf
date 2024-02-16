resource "snowflake_procedure" "DW_HAH_GET_STAGE_AXXESS_DIM_INVOICE_TRANSACTION_TYPE" {
	name ="GET_STAGE_AXXESS_DIM_INVOICE_TRANSACTION_TYPE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
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

BEGIN
--*****************************************************************************************************************************
-- NAME:  AXXESS_DIM_INVOICE_TRANSACTION_TYPE
--
-- DEVELOPMENT LOG:
-- DATE                 AUTHOR                      NOTES:
-- -----------    ----------------------      -----------------------------------------------------------------------------------------------
-- 1/15/2024       POONIT MISTRY (OLLION)      Initial development
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.AXXESS_DIM_INVOICE_TRANSACTION_TYPE
SELECT DISTINCT MD5(''AXXESS'' || ''-'' || IFNULL(UPPER(TRIM(FIN.TRANSACTION_TYPE)), ''UNKNOWN'') || ''-'' ||
                    ''AXXESS'')                                                TRANSACTION_TYPE_KEY,
                NULL                                                        AS PARENT_TRANSACTION_TYPE_KEY,
                TRANSACTION_TYPE                                            AS TRANSACTION_CODE,
                CASE
                    WHEN FIN.TRANSACTION_TYPE = 1 THEN ''PAYMENT''
                    WHEN FIN.TRANSACTION_TYPE = 2 THEN ''ADJUSTMENT''
                    WHEN FIN.TRANSACTION_TYPE IS NULL THEN ''UNKNOWN'' END  AS TRANSACTION_NAME,
                NULL                                                        AS TRANSACTION_DESC,
                ''AXXESS''                                                  AS SYSTEM_CODE,
                14                                                          AS SOURCE_SYSTEM_ID,
                :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY,
                :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY,
                convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
        ,
                CURRENT_USER                                                as ETL_INSERTED_BY
        ,
                convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
        ,
                CURRENT_USER                                                as ETL_LAST_UPDATED_BY
        ,
                0                                                           as ETL_DELETED_FLAG
from DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_FINANCIALTRANSACTIONS FIN
union
--homehealth
SELECT DISTINCT MD5(''AXXESS'' || ''-'' || case
                                               when upper(IS_REMITTANCE) = ''TRUE''
                                                   then ''REMITTANCE''
                                               when upper(IS_ADJUSTMENT) = ''TRUE''
                                                   THEN ''ADJUSTMENT''
                                               WHEN UPPER(IS_MANUAL_PAYMENT) = ''TRUE''
                                                   THEN ''MANUAL PAYMENT'' END || ''-'' ||
                    ''AXXESS'')                                                TRANSACTION_TYPE_KEY
        ,
                NULL                                                        AS PARENT_TRANSACTION_TYPE_KEY
        ,
                NULL                                                        AS TRANSACTION_CODE
        ,
                case
                    when upper(IS_REMITTANCE) = ''TRUE''
                        then ''REMITTANCE''
                    when upper(IS_ADJUSTMENT) = ''TRUE''
                        THEN ''ADJUSTMENT''
                    WHEN UPPER(IS_MANUAL_PAYMENT) = ''TRUE''
                        THEN ''MANUAL PAYMENT'' END                         AS TRANSCTION_NAME
        ,
                NULL                                                        AS TRANSACTION_DESC
        ,
                ''AXXESS''                                                  AS SYSTEM_CODE
        ,
                14                                                          AS SOURCE_SYSTEM_ID
        ,
                :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY
        ,
                :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY
        ,
                convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
        ,
                CURRENT_USER                                                as ETL_INSERTED_BY
        ,
                convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
        ,
                CURRENT_USER                                                as ETL_LAST_UPDATED_BY
        ,
                0                                                           as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_TRANSACTIONS T;
RETURN ''SUCCESS'';
END;

 EOT
}

