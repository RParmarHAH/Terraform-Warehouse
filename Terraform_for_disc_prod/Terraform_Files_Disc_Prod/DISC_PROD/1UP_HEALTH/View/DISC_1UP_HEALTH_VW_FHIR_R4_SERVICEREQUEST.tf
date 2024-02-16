resource "snowflake_view" "DISC_1UP_HEALTH_VW_FHIR_R4_SERVICEREQUEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "VW_FHIR_R4_SERVICEREQUEST"
	statement = <<-SQL
	 (
select
parse_json(source_data):id::string as id,
parse_json(source_data):code:coding[0]:code::string as code_coding_code,
parse_json(source_data):code:coding[0]:display::string as code_coding_display,
parse_json(source_data):code:text::string as code_text,
parse_json(source_data):identifier[0]:system::string as identifier_system1,
parse_json(source_data):identifier[0]:type:coding[0]:code::string as identifier_type_coding_code1,
parse_json(source_data):identifier[0]:type:coding[0]:display::string as identifier_type_coding_display1,
parse_json(source_data):identifier[0]:type:coding[0]:system::string as identifier_type_coding_system1,
parse_json(source_data):identifier[0]:value::string as identifier_value1,
parse_json(source_data):identifier[1]:system::string as identifier_system2,
parse_json(source_data):identifier[1]:type:coding[0]:code::string as identifier_type_coding_code2,
parse_json(source_data):identifier[1]:type:coding[0]:display::string as identifier_type_coding_display2,
parse_json(source_data):identifier[1]:type:coding[0]:system::string as identifier_type_coding_system2,
parse_json(source_data):identifier[1]:value::string as identifier_value2,
parse_json(source_data):intent::string as intent,
parse_json(source_data):meta:extension[0]:url::string as meta_extension_url1,
parse_json(source_data):meta:extension[0]:valueDateTime::TIMESTAMP_NTZ as meta_extension_valueDateTime1,
parse_json(source_data):meta:extension[1]:url::string as meta_extension_url2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:code::string as meta_extension_valucodeableconcept_coding_code2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:system::string as meta_extension_valuecodeableconcept_coding_system2,
parse_json(source_data):meta:extension[2]:url::string as meta_extension_url3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:code::string as meta_extension_valuecodeableconcept_coding_code3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:system::string as meta_valuecodeableconcept_coding_system3,
parse_json(source_data):meta:extension[3]:url::string as meta_extension_url4,
parse_json(source_data):meta:extension[3]:valueDateTime::TIMESTAMP_NTZ as meta_extension_valueDateTime4,
parse_json(source_data):meta:extension[4]:url::string as meta_extension_url5,
parse_json(source_data):meta:extension[4]:valueString::string as meta_extension_valueString5,
parse_json(source_data):meta:extension[5]:url::string as meta_extension_url6,
parse_json(source_data):meta:extension[5]:valueString::string as meta_extension_valueString6,
parse_json(source_data):meta:extension[6]:url::string as meta_extension_url7,
parse_json(source_data):meta:extension[6]:valueString::string as meta_extension_valueString7,
parse_json(source_data):meta:lastUpdated::TIMESTAMP_NTZ as meta_lastUpdated,
parse_json(source_data):meta:source::string as meta_source,
parse_json(source_data):meta:versionId::string as meta_versionId,
parse_json(source_data):occurrenceDateTime::TIMESTAMP_NTZ as occurrenceDateTime,
parse_json(source_data):requester:display::string as requester_display,
parse_json(source_data):requester:reference::string as requester_reference,
parse_json(source_data):resourceType::string as resourceType,
parse_json(source_data):status::string as status,
parse_json(source_data):subject:reference::string as subject_reference,
parse_json(source_data):text:div::string as text_div,
parse_json(source_data):text:status::string as text_status,
LANDING_INSERTED_DATE,
LANDING_INSERTED_BY,
FILENAME,
ETL_INSERTED_BY,
ETL_TASK_KEY,
ETL_INSERTED_DATE
FROM DISC_${var.SF_ENVIRONMENT}."1UP_HEALTH".HIST_FHIR_R4_SERVICEREQUEST);
SQL
	or_replace = true 
	is_secure = false 
}

