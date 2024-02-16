CREATE OR REPLACE PROCEDURE DISC_PROD.TRUSTPOINTDATA.LOCATIONS_LOAD_2("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '

CREATE OR REPLACE TABLE DISC_PROD.TRUSTPOINTDATA.TRUSTPOINT_LOC_2 AS 

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
FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_LOC/trustpoint_loc_2 (FILE_FORMAT => DW_PROD.PUBLIC.CSV_FORMAT_TRUSTPOINT) WP;

';