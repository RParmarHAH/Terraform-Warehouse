resource "snowflake_procedure" "DISC_TRUSTPOINTDATA_LOCATIONS_LOAD_2" {
	name ="LOCATIONS_LOAD_2"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT


CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.TRUSTPOINT_LOC_2 AS 

SELECT DISTINCT 
	wp.$1 as Company,
	wp.$2 as GP_1_Company_Code,
	wp.$3 as Location_Name,
	wp.$4 as Alternate_Name,
	wp.$5 as Notes,
	wp.$6 as AMS,
	wp.$7 as Location_Code,
	wp.$8 as Address_1,
	wp.$9 as Address2,
	wp.$10 as City,
	wp.$11 as State,
	wp.$12 as ZIP,
	wp.$13 as Setup_in_GP,
	wp.$14 as Setup_in_Coupa,
	wp.$15 as Requestor,
	wp.$16 as Date_Assigned,
	wp.$17 as Comment_Initials
FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_LOC/trustpoint_loc_2 (FILE_FORMAT => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT) WP;


 EOT
}

