resource "snowflake_file_format" "DISC_PUBLIC_XML_STRIPOUT_FORMAT_AB" {
	name = "XML_STRIPOUT_FORMAT_AB"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	comment = "XML file format with stripped outer element for XML load - Abhishek"
	format_type = "XML"
	compression = "AUTO"
	ignore_utf8_errors = true
	preserve_space = false
	strip_outer_element = true
	disable_snowflake_data = false
	disable_auto_convert = false
	replace_invalid_characters = false
	skip_byte_order_mark = true
	encoding = "UTF8"
}

