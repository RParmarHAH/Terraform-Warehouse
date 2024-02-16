resource "snowflake_file_format" "DISC_PUBLIC_XML_NOSTRIPOUT_FORMAT" {
	name = "XML_NOSTRIPOUT_FORMAT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	comment = "JAY"
	format_type = "XML"
	compression = "AUTO"
	ignore_utf8_errors = false
	preserve_space = false
	strip_outer_element = false
	disable_snowflake_data = false
	disable_auto_convert = false
	replace_invalid_characters = false
	skip_byte_order_mark = true
	encoding = "UTF8"
}

