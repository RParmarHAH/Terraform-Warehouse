resource "snowflake_file_format" "DW_PUBLIC_PSV" {
	name = "PSV"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	format_type = "CSV"
	compression = "NONE"
	record_delimiter = "NONE"
	field_delimiter = "|"
	file_extension = "NONE"
	skip_header = 1
	skip_blank_lines = false
	date_format = "AUTO"
	time_format = "AUTO"
	timestamp_format = "AUTO"
	binary_format = "HEX"
	escape = "NONE"
	escape_unenclosed_field = "NONE"
	trim_space = false
	field_optionally_enclosed_by = "\""
	null_if = ["\\n"]
	error_on_column_count_mismatch = true
	replace_invalid_characters = false
	empty_field_as_null = true
	skip_byte_order_mark = true
	encoding = "UTF-8"
}

