resource "snowflake_procedure" "DISC_VIVENTIUM_GET_LMSEXPORTEMPLOYEE" {
	name ="GET_LMSEXPORTEMPLOYEE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN 
    --TargetSQL
    insert into disc_prod.viventium.hist_lmsexportemployee select  j.$1:employeeKey::varchar as employeeKey, j.$1:employeeNumber::varchar as employeeNumber, j.$1:divisionKey:companyCode::varchar as companyCode, j.$1:divisionKey:divisionCode::varchar as divisionCode, j.$1:personalId::varchar as personalId, j.$1:lastName::varchar as lastName, j.$1:middleInitial::varchar as middleInitial, j.$1:firstName::varchar as firstName, j.$1:ssn::varchar as ssn, j.$1:employeeStatus::varchar as employeeStatus, j.$1:hireDate::date as hireDate, j.$1:rehireDate::date as rehireDate, j.$1:terminationDate::date as terminationDate, j.$1:employeeType::varchar as employeeType, j.$1:payGroup::varchar as payGroup, j.$1:locationCode::varchar as locationCode, j.$1:shiftCode::varchar as shiftCode, j.$1:costCenter1::varchar as costCenter1, j.$1:costCenter2::varchar as costCenter2, j.$1:costCenter3::varchar as costCenter3, j.$1:costCenter4::varchar as costCenter4, j.$1:costCenter5::varchar as costCenter5, j.$1:jobTitle::varchar as jobTitle, j.$1:birthDate::date as birthDate, j.$1:gender::varchar as gender, j.$1:email::varchar as email, j.$1:homePhone::varchar as homePhone, j.$1:workPhone::varchar as workPhone, j.$1:mobilePhone::varchar as mobilePhone, j.$1:modifiedOn::varchar as modifiedOn, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE, CURRENT_USER AS ETL_INSERTED_BY , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE, CURRENT_USER AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG, 0 AS ETL_INFERRED_MEMBER_FLAG from @disc_prod.STAGE.AWSAZSTAGEPROD/Viventium/Daily_Files/LMSExportEmployees/(file_format => disc_prod.PUBLIC.MY_JSON_FORMAT) j;

    --ViewSQL
    CREATE OR REPLACE TABLE disc_prod.VIVENTIUM.LMSEXPORTEMPLOYEE AS  WITH curr_v AS ( SELECT employeekey,employeenumber , max(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE  FROM disc_prod.VIVENTIUM.HIST_LMSEXPORTEMPLOYEE GROUP BY employeekey,employeenumber ) SELECT HL.* EXCLUDE ETL_DELETED_FLAG, CASE WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE ELSE HL.ETL_DELETED_FLAG END AS ETL_DELETED_FLAG   FROM disc_prod.VIVENTIUM.HIST_LMSEXPORTEMPLOYEE HL  INNER JOIN curr_v v ON HL.employeekey = v.employeekey AND HL.employeenumber = v.employeenumber   AND HL.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

