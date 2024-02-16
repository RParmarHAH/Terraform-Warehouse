resource "snowflake_procedure" "DISC_PUBLIC_TEST_RSUTHAR2" {
	name ="TEST_RSUTHAR2"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"

	arguments {
		name = "CON_ID"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "BRANCH_ID"
		type = "NUMBER(38"
}	
	return_type = "TABLE ("BRANCH_ID" NUMBER(38,0), "MAX_VISIT_DATE" TIMESTAMP_NTZ(9))"
	execute_as = "OWNER"
	statement = <<-EOT

declare
	CNT varchar;
    tloc varchar;
    res resultset;
BEGIN
	SELECT QUERY into :tloc FROM DATA_MANAGEMENT.AUDIT.OB_DATA_METRICS WHERE OBJECT_key=:con_id;
    res:=(execute immediate tloc);
    return table(res);
end;

 EOT
}

