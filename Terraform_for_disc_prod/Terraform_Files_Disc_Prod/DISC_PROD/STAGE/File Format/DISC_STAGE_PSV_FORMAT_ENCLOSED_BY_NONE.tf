resource "snowflake_file_format" "DISC_STAGE_PSV_FORMAT_ENCLOSED_BY_NONE" {
	name = "PSV_FORMAT_ENCLOSED_BY_NONE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
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
	escape_unenclosed_field = "\\"
	trim_space = false
	field_optionally_enclosed_by = "NONE"
	null_if = ["\\n"]
	error_on_column_count_mismatch = true
	replace_invalid_characters = false
	empty_field_as_null = true
	skip_byte_order_mark = true
	encoding = "UTF-8"
}

