resource "snowflake_view" "DW_STAGE_VW_CURRENT_CCSI_DIM_SUPERVISOR" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_CCSI_DIM_SUPERVISOR"
	statement = <<-SQL
	 SELECT DISTINCT
		md5(DI.AREA ||'-'|| nvl(DI.SUPERVISOR_INITIAL,'Unknown') ||'-'|| 'CCSI') AS SUPERVISOR_KEY
	FROM DISC_${var.SF_ENVIRONMENT}.CCSI.DESKINFO DI
	LEFT JOIN STAGE.CCSI_DIM_BRANCH B ON TRIM(DI.AREA) = TRIM(B.OFFICE_CODE) AND B.SOURCE_SYSTEM_ID =8
	WHERE DI.ETL_LAST_UPDATED_DATE >= '1900-01-01';
SQL
	or_replace = true 
	is_secure = false 
}

