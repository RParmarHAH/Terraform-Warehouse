resource "snowflake_procedure" "DW_REPORT_GET_REPORT_CLIENT_LINEAR_RETENTION_FORWARD_MONTHLY" {
	name ="GET_REPORT_CLIENT_LINEAR_RETENTION_FORWARD_MONTHLY"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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
	iteration_limit integer default 12;
	MONTH_DATE DATE;
BEGIN
	MONTH_DATE:=current_DATE();
    -- Check if its the first day of the month 
    IF (DAYOFMONTH(:MONTH_DATE) = 1) THEN
       for i in 0 to iteration_limit do 
       CALL DW_${var.SF_ENVIRONMENT}.REPORT.GET_REPORT_CLIENT_LINEAR_RETENTION_FORWARD_MONTHLY_INNER(
                ADD_MONTHS(:MONTH_DATE, -:i), :STR_ETL_TASK_KEY);
       END for;  
    ELSEIF (DAYOFMONTH(:MONTH_DATE) > 1 AND DAYOFMONTH(:MONTH_DATE) <= 15) THEN
        -- Condition 1: Reload data of the previous month and the current month on a daily basis
        CALL DW_${var.SF_ENVIRONMENT}.REPORT.GET_REPORT_CLIENT_LINEAR_RETENTION_FORWARD_MONTHLY_INNER(ADD_MONTHS(:MONTH_DATE, -1), :STR_ETL_TASK_KEY);
        CALL DW_${var.SF_ENVIRONMENT}.REPORT.GET_REPORT_CLIENT_LINEAR_RETENTION_FORWARD_MONTHLY_INNER(:MONTH_DATE, :STR_ETL_TASK_KEY);
    ELSE
        -- For other days of the month, call the existing procedure for the current month
        CALL DW_${var.SF_ENVIRONMENT}.REPORT.GET_REPORT_CLIENT_LINEAR_RETENTION_FORWARD_MONTHLY_INNER(:MONTH_DATE, :STR_ETL_TASK_KEY);
    END IF;

    RETURN ''Wrapper procedure completed.'';
END
 EOT
}

