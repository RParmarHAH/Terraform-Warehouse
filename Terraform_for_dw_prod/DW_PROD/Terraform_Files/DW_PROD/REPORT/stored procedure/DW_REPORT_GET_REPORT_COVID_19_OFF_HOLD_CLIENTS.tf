resource "snowflake_procedure" "DW_REPORT_GET_REPORT_COVID_19_OFF_HOLD_CLIENTS" {
	name ="GET_REPORT_COVID_19_OFF_HOLD_CLIENTS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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

DECLARE
    return_result VARCHAR;
BEGIN
    INSERT OVERWRITE INTO REPORT.COVID_19_OFF_HOLD_CLIENTS 
WITH QUERY AS (
	SELECT C.DbName,
	       C.OfficeNumber,
	       o.OfficeName,
	       C.OnHoldEndDate,
		   COUNT(DISTINCT C.Number) Clients,
           nvl(b2.BRANCH_KEY, md5(T.DBNAME || ''-'' || COALESCE(O.OfficeName, ''Unknown'') || ''-'' ||  ''DATAFLEXSYNCDATA'')) AS BRANCH_KEY	
	FROM "DISC_${var.SF_ENVIRONMENT}".DataFlexSyncData.DfTimeSheets T
	    JOIN "DISC_${var.SF_ENVIRONMENT}".DataFlexSyncData.DfTimeSheetHours th
	        ON th.DbName = T.DbName
	           AND th.ReferenceNo = T.ReferenceNo
	           AND th.WeekendDate = T.WeekendDate
	    JOIN "DISC_${var.SF_ENVIRONMENT}".DataFlexSyncData.DfClients C
	        ON C.DbName = T.DbName
	           AND C.Number = T.ClientNumber
	    JOIN "DISC_${var.SF_ENVIRONMENT}".DataFlexSyncData.DfClientContracts CC
	        ON CC.DbName = T.DbName
	           AND CC.ClientNumber = T.ClientNumber
	           AND CC.ContractCode = T.ContractCode
	    JOIN "DISC_${var.SF_ENVIRONMENT}".DataFlexSyncData.DfContracts co
	        ON co.DbName = T.DbName
	           AND co.ContractCode = T.ContractCode
	    JOIN "DISC_${var.SF_ENVIRONMENT}".DataFlexSyncData.DfOffices o
	        ON o.DbName = C.DbName
	           AND o.OfficeNumber = C.OfficeNumber
        LEFT JOIN HAH.DIM_BRANCH b2
            ON b2.BRANCH_NAME = COALESCE(o.OfficeName, ''Unknown'')
             AND b2.SYSTEM_CODE = o.DBNAME
	WHERE C.IsActive = 1
	      AND C.OnHoldEndDate
	      BETWEEN ''1/1/2020'' AND GETDATE()
	      AND co.RevenueCategory <> ''cls''
	      AND co.RevenueCategory IN ( ''HC'', ''HH'' )
	      AND co.Billable = 1
	      AND co.Payable = 1
	GROUP BY C.DbName,
	         C.OnHoldEndDate,
	         C.OfficeNumber,
	         o.OfficeName,
             nvl(b2.BRANCH_KEY, md5(T.DBNAME || ''-'' || COALESCE(O.OfficeName, ''Unknown'') || ''-'' ||  ''DATAFLEXSYNCDATA''))
) 
	SELECT *,
        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY ,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
	FROM QUERY;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

