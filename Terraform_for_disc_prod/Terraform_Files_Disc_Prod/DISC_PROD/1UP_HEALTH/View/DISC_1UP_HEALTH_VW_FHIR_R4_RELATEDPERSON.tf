resource "snowflake_view" "DISC_1UP_HEALTH_VW_FHIR_R4_RELATEDPERSON" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "VW_FHIR_R4_RELATEDPERSON"
	statement = <<-SQL
	 (
select
parse_json(source_data):id::string as id,
parse_json(source_data):active::string as active,
parse_json(source_data):address[0]:city::string as address_city,
parse_json(source_data):address[0]:country::string as address_country,
parse_json(source_data):address[0]:line[0]::string as address_line1,
parse_json(source_data):address[0]:line[1]::string as address_line2,
parse_json(source_data):address[0]:postalCode::string as address_postalCode,
parse_json(source_data):address[0]:state::string as address_state,
parse_json(source_data):birthDate::date as birth_Date,
parse_json(source_data):gender::string as gender,
parse_json(source_data):identifier[0]:system::string as identifier_system,
parse_json(source_data):identifier[0]:use::string as identifier_use,
parse_json(source_data):identifier[0]:value::string as identifier_value,
parse_json(source_data):meta:extension[0]:url::string as meta_extension_url1,
parse_json(source_data):meta:extension[0]:valueDateTime::TIMESTAMP_NTZ (9) as meta_extension_valueDateTime1,
parse_json(source_data):meta:extension[1]:url::string as meta_extension_url2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:code::string as meta_extension_valueCodeableConcept_coding_code2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:system::string as meta_extension_valueCodeableConcept_coding_system2,
parse_json(source_data):meta:extension[2]:url::string as meta_extension_url3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:code::string as meta_extension_coding_code3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:system::string as meta_extension_coding_system3,
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
parse_json(source_data):meta:versionId::string as meta_versionId,
parse_json(source_data):name[0]:family::string as name_family,
parse_json(source_data):name[0]:given[0]::string as name_given1,
parse_json(source_data):name[0]:given[1]::string as name_given2,
parse_json(source_data):name[0]:text::string as name_text,
parse_json(source_data):patient:reference::string as patient_reference,
parse_json(source_data):relationship[0]:coding[0]:code::string as relationship_coding_code,
parse_json(source_data):relationship[0]:coding[0]:display::string as relationship_coding_display,
parse_json(source_data):relationship[0]:coding[0]:system::string as relationship_coding_system,
parse_json(source_data):relationship[0]:text::string as relationship_text,
parse_json(source_data):resourceType::string as resourceType,
parse_json(source_data):telecom[0]:system::string as telecom_system,
parse_json(source_data):telecom[0]:use::string as telecom_use,
parse_json(source_data):telecom[0]:value::string as telecom_value,
LANDING_INSERTED_DATE,
LANDING_INSERTED_BY,
FILENAME,
ETL_INSERTED_BY,
ETL_TASK_KEY,
ETL_INSERTED_DATE
FROM DISC_${var.SF_ENVIRONMENT}."1UP_HEALTH".HIST_FHIR_R4_RELATEDPERSON
);
SQL
	or_replace = true 
	is_secure = false 
}

