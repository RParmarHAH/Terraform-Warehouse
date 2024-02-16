resource "snowflake_procedure" "DISC_PUBLIC_TESTING_RETURN_STATEMENT" {
	name ="TESTING_RETURN_STATEMENT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
    return_result_temp VARCHAR;
BEGIN
	
	return_result:='''';
--inset

SELECT ''5 ROW  INSERTED'' INTO :return_result_temp;

	return_result:= CONCAT(return_result,'' | '',return_result_temp);

--merge

	SELECT ''7 ROW  uPDATED'' INTO :return_result_temp;

	return_result:= CONCAT(return_result,'' | '',return_result_temp);
	
--delete

SELECT ''2 ROW  dELETE'' INTO :return_result_temp;

	return_result:= CONCAT(return_result,'' | '',return_result_temp);
	
	return concat(''Message : '',return_result);

END;


 EOT
}

