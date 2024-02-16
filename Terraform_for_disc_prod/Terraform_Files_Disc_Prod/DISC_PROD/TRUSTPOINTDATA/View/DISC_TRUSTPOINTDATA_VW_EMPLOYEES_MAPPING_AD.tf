resource "snowflake_view" "DISC_TRUSTPOINTDATA_VW_EMPLOYEES_MAPPING_AD" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
	name = "VW_EMPLOYEES_MAPPING_AD"
	statement = <<-SQL
	 ( 
SELECT
	wp.$1 AS SSN,
	WP.$2 AS Employee_Id,
	WP.$3 AS First_Name,
	WP.$4 AS Last_Name,
	WP.$5 AS Employee_EIN,
	WP.$6 AS Time,
	WP.$7 AS Change,
	WP.$8 AS Object,
	WP.$9 AS Field_Desc,
	WP.$10 AS New_Value,
	WP.$11 AS Old_Value,
	ROW_NUMBER() OVER (PARTITION BY FIRST_NAME, LAST_NAME ORDER BY TO_TIMESTAMP(REGEXP_REPLACE(TIME, ' EST|EDT'), 'MM/DD/YYYY HH:MI:SS:FF') DESC) AS RANK,
	-1,
	-1,
	current_date() AS ETL_INSERTED_DATE,
    current_user() AS ETL_INSERTED_BY,
    current_date() AS ETL_LAST_UPDATED_DATE,
    current_user() AS ETL_LAST_UPDATED_BY,
    FALSE ETL_DELETED_FLAG
FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_EMP_MAPPING/Account (FILE_FORMAT => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST_JP) WP 
);
SQL
	or_replace = true 
	is_secure = false 
}

