CREATE OR REPLACE FILE FORMAT DW_PROD.PUBLIC.MY_JSON_FORMAT
	TYPE = JSON
	NULL_IF = ()
	STRIP_OUTER_ARRAY = TRUE
;