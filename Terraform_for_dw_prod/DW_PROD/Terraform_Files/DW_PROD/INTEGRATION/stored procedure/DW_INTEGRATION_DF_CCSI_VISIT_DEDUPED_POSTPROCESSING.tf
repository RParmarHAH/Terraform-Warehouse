resource "snowflake_procedure" "DW_INTEGRATION_DF_CCSI_VISIT_DEDUPED_POSTPROCESSING" {
	name ="DF_CCSI_VISIT_DEDUPED_POSTPROCESSING"
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
    return_result VARCHAR;
    return_result_temp VARCHAR;
BEGIN

	CALL DW_${var.SF_ENVIRONMENT}.INTEGRATION.DF_CCSI_VISIT_DEDUPE_MERGED_POSTPROCESSING(1,''1999-01-01'',''9999-12-31'');
	
	DELETE from DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT where visit_key in (select CCSI_VISIT_KEY from DW_${var.SF_ENVIRONMENT}.INTEGRATION.DF_CCSI_VISIT_DEDUPE_MERGED where CCSI_SOURCE_SYSTEM_ID = 8);
	
	SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

	MERGE into DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT AS target
using (
SELECT DISTINCT DF_VISIT_KEY, DUMMY_EMPLOYEE_KEY, ORIGINAL_EMPLOYEE_KEY, EMPLOYEE_KEY, EMPLOYEE_ID FROM (
        SELECT DISTINCT DF_EMPLOYEE_KEY AS DUMMY_EMPLOYEE_KEY,
  E.ORIGINAL_EMPLOYEE_KEY,
  E.EMPLOYEE_KEY,
  DF_VISIT_KEY,
        E.EMPLOYEE_ID, row_number() over (partition by df_visit_key order by E.ORIGINAL_EMPLOYEE_KEY desc) as rno
        --, MAX(E.ORIGINAL_EMPLOYEE_KEY) --OVER (PARTITION BY DF_VISIT_KEY ORDER BY D.HOURS_SERVED DESC) as Hours_served
        FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DF_CCSI_VISIT_DEDUPE_MERGED V
        LEFT JOIN DW_${var.SF_ENVIRONMENT}.integration.dim_employee_merged E ON V.CCSI_EMPLOYEE_KEY = E.ORIGINAL_EMPLOYEE_KEY
        LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DF_CCSI_VISIT_DEDUPE D ON V.CCSI_VISIT_KEY = D.VISIT_KEY AND D.SOURCE_SYSTEM_ID = 8 
        WHERE V.DF_EMPLOYEE_KEY IN (''9b7ba1474e27979ff226887ed4852e45'',''0e8fb5389c265944d7cb75e453461c6c'',''025ff831908e366fba7ad7a25ed0dc8a'')
  AND V.CCSI_SOURCE_SYSTEM_ID = 8 --AND E.SOURCE_SYSTEM_ID =3
  GROUP BY DF_VISIT_KEY, 1,2,3,5
)WHERE --df_visit_key = ''936ab0689e1c2a0880b018a1158b0355'' and 
rno = 1) as b on target.VISIT_KEY = b.DF_VISIT_KEY
when matched then update set target.EMPLOYEE_KEY = b.EMPLOYEE_KEY, TARGET.EMPLOYEE_ID = B.EMPLOYEE_ID;

SELECT CONCAT('' '',"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return CONCAT(return_result_temp,'' | '',return_result);
END;


 EOT
}

