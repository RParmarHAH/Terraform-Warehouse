resource "snowflake_procedure" "DW_INTEGRATION_GET_EMP_MATCH_GA" {
	name ="GET_EMP_MATCH_GA"
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
	return_result_temp varchar(1000);
BEGIN

delete FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_MATCH 
WHERE (
(SOURCE_SYSTEM_ID =3 AND SYSTEM_CODE =''GA'') OR 
(SOURCE_SYSTEM_ID =2 AND SYSTEM_CODE =''SHC_SAVANNAH'') OR 
(SOURCE_SYSTEM_ID =9 AND SYSTEM_CODE like ''%1002%'')
);

SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

INSERT INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_MATCH (
with dedupe_record_ids as 
(
select record_id,cluster_id,filename
from DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMP_GA_DEDUPE_SOURCE
where cluster_id in (select cluster_id
from DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMP_GA_DEDUPE_SOURCE
group by cluster_id
having count(cluster_id)>1
)
)
,GA_emp as
( 
select (CASE WHEN E.source_system_id=9 THEN 1
			 WHEN E.source_system_id=2 THEN 2
			 WHEN E.source_system_id=3 THEN 3
		end) as New_Src_ID,
		E.* from DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE E
)
,
emp_Master as
(
select record_id,cluster_id,filename
		,GA_emp.EMPLOYEE_LAST_WORKED_DATE
    	,GA_emp.EMPLOYEE_HIRE_DATE
,GA_emp.EMPLOYEE_KEY MASTER_KEY
,row_number() over(partition by dedupe.cluster_id order by GA_emp.New_Src_ID) min_record_id
from DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMP_GA_DEDUPE_SOURCE dedupe
INNER JOIN GA_emp on
dedupe.record_id = GA_emp.EMPLOYEE_KEY
)
select dedupe.record_id original_key 
		,M.MASTER_KEY 
        ,dedupe.cluster_id
        ,row_number() over(partition by dedupe.cluster_id order by GA_emp.New_Src_ID) record_order
,GA_emp.SOURCE_SYSTEM_ID
,GA_emp.SYSTEM_CODE
,GA_emp.EMPLOYEE_FIRST_NAME
,GA_emp.EMPLOYEE_LAST_NAME
,GA_emp.EMPLOYEE_DOB
,GA_emp.EMPLOYEE_PID
,GA_emp.EMPLOYEE_ADDRESS1
,GA_emp.EMPLOYEE_ADDRESS2
,GA_emp.EMPLOYEE_CITY
,GA_emp.EMPLOYEE_ZIP
,GA_emp.EMPLOYEE_HIRE_DATE
,GA_emp.EMPLOYEE_ID
,GA_emp.EMPLOYEE_NUMBER 
,GA_emp.ACTIVE_EMPLOYEE_FLAG
,GA_emp.EMPLOYEE_FIRST_CHECK_DATE
,GA_emp.EMPLOYEE_LAST_CHECK_DATE
,GA_emp.EMPLOYEE_LAST_WORKED_DATE
,GA_emp.EMPLOYEE_TERMINATE_DATE
,GA_emp.ETL_INSERTED_DATE
,GA_emp.ETL_LAST_UPDATED_DATE
      from DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMP_GA_DEDUPE_SOURCE dedupe
      inner join GA_emp on dedupe.record_id = GA_emp.EMPLOYEE_KEY
      inner join dedupe_record_ids matches on
            matches.filename = dedupe.filename
            and matches.record_id = dedupe.record_id
            and matches.cluster_id = dedupe.cluster_id
      inner join emp_Master M on 
            M.cluster_id=matches.cluster_id
            and min_record_id=1 
);

SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return CONCAT(return_result,'' | '',return_result_temp);
END;

 EOT
}

