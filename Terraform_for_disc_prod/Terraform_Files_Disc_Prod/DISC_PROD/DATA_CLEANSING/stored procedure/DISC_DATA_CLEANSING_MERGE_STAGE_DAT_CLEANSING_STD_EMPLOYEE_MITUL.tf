resource "snowflake_procedure" "DISC_DATA_CLEANSING_MERGE_STAGE_DAT_CLEANSING_STD_EMPLOYEE_MITUL" {
	name ="MERGE_STAGE_DAT_CLEANSING_STD_EMPLOYEE_MITUL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
SELECT   * FROM DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.Employee_Src_Attributes AS addr limit 1;
return return_result;
END;

 EOT
}

