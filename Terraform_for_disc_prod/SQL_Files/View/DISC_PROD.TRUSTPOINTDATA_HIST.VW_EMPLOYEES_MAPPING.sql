create or replace view DISC_PROD.TRUSTPOINTDATA_HIST.VW_EMPLOYEES_MAPPING(
	SSN,
	EMPLOYEE_ID,
	FIRST_NAME,
	LAST_NAME,
	EMPLOYEE_EIN,
	TIME,
	CHANGE,
	OBJECT,
	FIELD_DESC,
	NEW_VALUE,
	OLD_VALUE,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
) as ( 
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
	-1,
	-1,
	current_date() AS ETL_INSERTED_DATE,
    current_user() AS ETL_INSERTED_BY,
    current_date() AS ETL_LAST_UPDATED_DATE,
    current_user() AS ETL_LAST_UPDATED_BY,
    FALSE ETL_DELETED_FLAG
FROM @DISC_DEV.STAGE.AZSTAGE/ADP_Opal/Trustpoint_Temp/EE (FILE_FORMAT => DW_DEV.PUBLIC.CSV_FORMAT) WP 
);