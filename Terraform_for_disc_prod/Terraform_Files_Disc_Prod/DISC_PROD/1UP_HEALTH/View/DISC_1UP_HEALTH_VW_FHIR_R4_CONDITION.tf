resource "snowflake_view" "DISC_1UP_HEALTH_VW_FHIR_R4_CONDITION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "VW_FHIR_R4_CONDITION"
	statement = <<-SQL
	 (
select 
parse_json(source_data):id::string as id,
parse_json(source_data):asserter:display::string as asserter_display,
parse_json(source_data):asserter:reference::string as asserter_reference,
parse_json(source_data):category[0]:coding[0]:code::string as category_coding_code, 
parse_json(source_data):category[0]:coding[0]:display::string as category_coding_display,
parse_json(source_data):category[0]:coding[0]:system::string as category_coding_system,
parse_json(source_data):category[0]:text::string as category_text,
parse_json(source_data):clinicalStatus:coding[0]:code::string as clinicalStatus_coding_code,
parse_json(source_data):clinicalStatus:coding[0]:display::string as clinicalStatus_coding_display,
parse_json(source_data):clinicalStatus:coding[0]:system::string as clinicalStatus_coding_system,
parse_json(source_data):code:coding[0]:code::string as code_coding_code1,
parse_json(source_data):code:coding[0]:display::string as code_coding_display1,
parse_json(source_data):code:coding[0]:system::string as code_coding_system1,
parse_json(source_data):code:coding[1]:code::string as code_coding_code2,
parse_json(source_data):code:coding[1]:display::string as code_coding_display2,
parse_json(source_data):code:coding[1]:system::string as code_coding_system2,
parse_json(source_data):code:coding[2]:code::string as code_coding_code3,
parse_json(source_data):code:coding[2]:display::string as code_coding_display3,
parse_json(source_data):code:coding[2]:system::string as code_coding_system3,
parse_json(source_data):code:coding[3]:code::string as code_coding_code4,
parse_json(source_data):code:coding[3]:display::string as code_coding_display4,
parse_json(source_data):code:coding[3]:system::string as code_coding_system4,
parse_json(source_data):code:text::string as code_text,
parse_json(source_data):encounter:reference::string as encounter_reference,
parse_json(source_data):identifier[0]:system::string as identifier_system1,
parse_json(source_data):identifier[0]:type:coding[0]:code::string as identifier_type_coding_code1,
parse_json(source_data):identifier[0]:type:coding[0]:display::string as identifier_type_coding_display1,
parse_json(source_data):identifier[0]:type:coding[0]:system::string as identifier_type_coding_system1,
parse_json(source_data):identifier[0]:value::string as identifier_value1,
parse_json(source_data):identifier[1]:system::string as identifier_system2,
parse_json(source_data):identifier[1]:value::string as identifier_value2,
parse_json(source_data):identifier[2]:system::string as identifier_system3,
parse_json(source_data):identifier[2]:use::string as identifier_use3,
parse_json(source_data):identifier[2]:value::string as identifier_value3,
parse_json(source_data):meta:extension[0]:url::string as meta_extension_url1,
parse_json(source_data):meta:extension[0]:valueDateTime::TIMESTAMP_NTZ (9) as meta_extension_valueDateTime1,
PARSE_JSON(SOURCE_DATA):meta:extension[0]:valueCodeableConcept:coding[0]:code::STRING AS meta_extension_valueCodeableConcept_coding_code1,
PARSE_JSON(SOURCE_DATA):meta:extension[0]:valueCodeableConcept:coding[0]:display::STRING AS meta_extension_valueCodeableConcept_coding_display1,
PARSE_JSON(SOURCE_DATA):meta:extension[0]:valueCodeableConcept:coding[0]:system::STRING AS meta_extension_valueCodeableConcept_coding_system1,
parse_json(source_data):meta:extension[1]:url::string as meta_extension_url2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:code::string as meta_extension_valueCodeableConcept_code_code2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:system::string as meta_extension_valueCodeableConcept_code_system2,
parse_json(source_data):meta:extension[2]:url::string as meta_extension_url3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:code::string as meta_extension_valueCodeableConcept_code_code3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:system::string as meta_extension_valueCodeableConcept_code_system3,
parse_json(source_data):meta:extension[3]:url::string as meta_extension_url4,
parse_json(source_data):meta:extension[3]:valueDateTime::TIMESTAMP_NTZ (9) as meta_extension_valueDateTime4,
parse_json(source_data):meta:extension[4]:url::string as meta_extension_url5,
parse_json(source_data):meta:extension[4]:valueString::string as meta_extension_valueString5,
parse_json(source_data):meta:extension[5]:url::string as meta_extension_url6,
parse_json(source_data):meta:extension[5]:valueString::string as meta_extension_valueString6,
parse_json(source_data):meta:extension[6]:url::string as meta_extension_url7,
parse_json(source_data):meta:extension[6]:valueString::string as meta_extension_valueString7,
parse_json(source_data):meta:lastUpdated::TIMESTAMP_NTZ (9) as meta_lastUpdated,
parse_json(source_data):meta:profile[0]::string as meta_profile,
parse_json(source_data):meta:source::string as meta_source,
parse_json(source_data):meta:tag[0]:code::string as meta_tag_code,
parse_json(source_data):meta:tag[0]:system::string as meta_tag_system,
parse_json(source_data):meta:tag[0]:version::string as meta_tag_version,
parse_json(source_data):meta:versionId::string as meta_versionId,
parse_json(source_data):resourceType::string as resourceType,
parse_json(source_data):onsetDateTime::TIMESTAMP_NTZ (9) as onsetDateTime,
parse_json(source_data):subject:display::string as subject_display,
parse_json(source_data):subject:reference::string as subject_reference,
parse_json(source_data):verificationStatus:coding[0]:code::string as verificationStatus_coding_code,
parse_json(source_data):verificationStatus:coding[0]:display::string as verificationStatus_coding_display,
parse_json(source_data):verificationStatus:coding[0]:system::string as verificationStatus_coding_system,
PARSE_JSON(SOURCE_DATA):extension[0]:url::STRING AS extension_url,
PARSE_JSON(SOURCE_DATA):extension[0]:valueDateTime::date AS extension_valueDateTime,
LANDING_INSERTED_DATE,
LANDING_INSERTED_BY,
FILENAME,
ETL_INSERTED_BY,
ETL_TASK_KEY,
ETL_INSERTED_DATE
FROM DISC_${var.SF_ENVIRONMENT}."1UP_HEALTH".HIST_FHIR_R4_CONDITION
);
SQL
	or_replace = true 
	is_secure = false 
}

