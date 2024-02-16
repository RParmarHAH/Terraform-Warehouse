resource "snowflake_procedure" "DW_HAH_GET_STAGE_DOCEBO_FACT_DOCEBO_PAYROLL" {
	name ="GET_STAGE_DOCEBO_FACT_DOCEBO_PAYROLL"
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
-- NAME:  DOCEBO_FACT_DOCEBO_PAYROLL
--
-- PURPOSE: Creates one row per DOCEBO Payroll
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                               NOTES:
-- --------    -------------------                  ---------------------------------------------------------------------------
-- 08/04/2022  Deepen Gajjar       	 	            Initial development
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.DOCEBO_FACT_DOCEBO_PAYROLL
SELECT
	NULL AS PAYROLL_BATCH_ID,
	NULL AS PAYROLL_GROUP,
	B.PAYROLL_ID AS EMPLOYEE_PAYROLL_ID,
	B.USER_UNIQUE_ID ,
	B.COURSE_UNIQUE_ID ,
	B.CREDITS_CEUS AS CREDIT_HOURS,
	NULL AS PAY_CODE,
	NULL AS PAY_DATE,
	NULL AS PAY_PERIOD_BEGIN_DATE,
	NULL AS PAY_PERIOD_END_DATE,
	B."LOCATION" ,
	NULL AS SUPPLEMENT_DATA,
	NULL AS "TIMESTAMP" ,
	
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
CURRENT_USER AS ETL_INSERTED_BY,
CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE,
CURRENT_USER AS ETL_LAST_UPDATED_BY,
0 AS ETL_DELETED_FLAG,
0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.DOCEBO.PAYROLL B
WHERE UPPER(TRIM(B.COURSE_ENROLLMENT_STATUS)) =''COMPLETED'';
;
    RETURN ''SUCCESS'';
    END;
    
 EOT
}

