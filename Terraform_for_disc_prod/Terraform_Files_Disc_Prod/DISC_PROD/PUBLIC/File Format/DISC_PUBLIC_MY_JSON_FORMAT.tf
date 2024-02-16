resource "snowflake_file_format" "DISC_PUBLIC_MY_JSON_FORMAT" {
	name = "MY_JSON_FORMAT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	format_type = "JSON"
	compression = "AUTO"
	date_format = "AUTO"
	time_format = "AUTO"
	timestamp_format = "AUTO"
	binary_format = "HEX"
	trim_space = false
	null_if = ["\\n"]
	file_extension = "NONE"
	enable_octal = false
	allow_duplicate = false
	strip_outer_array = true
	strip_null_values = false
	replace_invalid_characters = false
	ignore_utf8_errors = false
	skip_byte_order_mark = true
}

